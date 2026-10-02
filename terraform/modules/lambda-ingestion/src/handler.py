
import json
import os
import uuid
import base64
from datetime import datetime, timezone

import boto3

s3 = boto3.client("s3")
events = boto3.client("events")

BUCKET_NAME = os.environ["RAW_BUCKET_NAME"]


def handler(event, context):
    # API Gateway HTTP API request
    if isinstance(event, dict) and "body" in event:
        body = event.get("body") or "{}"

        if event.get("isBase64Encoded"):
            body = base64.b64decode(body).decode("utf-8")

        try:
            request_event = json.loads(body)
        except json.JSONDecodeError:
            return {
                "statusCode": 400,
                "headers": {
                    "Content-Type": "application/json"
                },
                "body": json.dumps({
                    "error": "Invalid JSON payload"
                })
            }

    # Direct Lambda invocation
    else:
        request_event = event

    event_id = request_event.get(
        "event_id",
        str(uuid.uuid4())
    )

    timestamp = datetime.now(timezone.utc)

    key = (
        f"raw/"
        f"year={timestamp.year}/"
        f"month={timestamp.month:02d}/"
        f"day={timestamp.day:02d}/"
        f"{event_id}.json"
    )

    # ---------------------------------------------------------
    # 1. Store the event in the RAW S3 layer
    # ---------------------------------------------------------

    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=key,
        Body=json.dumps(request_event).encode("utf-8"),
        ContentType="application/json",
    )

    # ---------------------------------------------------------
    # 2. Publish an Object Created event to EventBridge
    # ---------------------------------------------------------

    eventbridge_response = events.put_events(
        Entries=[
            {
                "Source": "aws.s3",
                "DetailType": "Object Created",
                "Detail": json.dumps({
                    "bucket": {
                        "name": BUCKET_NAME
                    },
                    "object": {
                        "key": key
                    }
                })
            }
        ]
    )

    # Check whether EventBridge accepted the event
    if eventbridge_response.get("FailedEntryCount", 0) > 0:
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "error": "Failed to publish EventBridge event",
                "event_id": event_id,
                "bucket": BUCKET_NAME,
                "key": key,
                "eventbridge": eventbridge_response
            })
        }

    # ---------------------------------------------------------
    # 3. Return successful ingestion response
    # ---------------------------------------------------------

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "Event ingested successfully",
            "event_id": event_id,
            "bucket": BUCKET_NAME,
            "key": key,
            "eventbridge_event_id": (
                eventbridge_response["Entries"][0].get("EventId")
            )
        })
    }

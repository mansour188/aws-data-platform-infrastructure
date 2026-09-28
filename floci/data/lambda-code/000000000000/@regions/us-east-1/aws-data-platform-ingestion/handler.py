import json
import os
import uuid
from datetime import datetime, timezone

import boto3

s3 = boto3.client("s3")

BUCKET_NAME = os.environ["RAW_BUCKET_NAME"]


def handler(event, context):
    event_id = event.get("event_id", str(uuid.uuid4()))

    timestamp = datetime.now(timezone.utc)

    key = (
        f"raw/"
        f"year={timestamp.year}/"
        f"month={timestamp.month:02d}/"
        f"day={timestamp.day:02d}/"
        f"{event_id}.json"
    )

    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=key,
        Body=json.dumps(event).encode("utf-8"),
        ContentType="application/json",
    )

    return {
        "statusCode": 200,
        "bucket": BUCKET_NAME,
        "key": key,
        "event_id": event_id,
    }

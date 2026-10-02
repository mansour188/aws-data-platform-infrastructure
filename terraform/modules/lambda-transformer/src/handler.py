import json
import os

import boto3

s3 = boto3.client("s3")

RAW_BUCKET = os.environ["RAW_BUCKET_NAME"]
BRONZE_BUCKET = os.environ["BRONZE_BUCKET_NAME"]

REQUIRED_FIELDS = [
    "event_id",
    "user_id",
    "event_type",
    "product_id",
    "amount",
    "currency",
]


def handler(event, context):
    # EventBridge S3 event
    if "detail" in event and "bucket" in event["detail"]:
        bucket = event["detail"]["bucket"]["name"]
        key = event["detail"]["object"]["key"]

    # Manual/direct invocation
    elif "bucket" in event and "key" in event:
        bucket = event["bucket"]
        key = event["key"]

    else:
        raise ValueError("Unsupported event format")

    if bucket != RAW_BUCKET:
        raise ValueError("Unexpected source bucket")

    response = s3.get_object(
        Bucket=RAW_BUCKET,
        Key=key,
    )

    raw_event = json.loads(response["Body"].read())

    missing_fields = [
        field for field in REQUIRED_FIELDS
        if field not in raw_event
    ]

    if missing_fields:
        raise ValueError(
            f"Missing required fields: {missing_fields}"
        )

    bronze_event = {
        "event_id": str(raw_event["event_id"]),
        "user_id": str(raw_event["user_id"]),
        "event_type": str(raw_event["event_type"]),
        "product_id": str(raw_event["product_id"]),
        "amount": float(raw_event["amount"]),
        "currency": str(raw_event["currency"]).upper(),
    }

    bronze_key = key.replace("raw/", "events/", 1)

    s3.put_object(
        Bucket=BRONZE_BUCKET,
        Key=bronze_key,
        Body=json.dumps(bronze_event).encode("utf-8"),
        ContentType="application/json",
    )

    return {
        "status": "success",
        "source": f"s3://{RAW_BUCKET}/{key}",
        "destination": f"s3://{BRONZE_BUCKET}/{bronze_key}",
    }
 Lambda Ingestion Module
Purpose

This module creates the Lambda function responsible for ingesting application events into the S3 data lake.

The Lambda receives an event, generates a partitioned S3 object path, and writes the event as JSON into the raw/ layer of the data lake.

Architecture
                         DATA PRODUCER
                              │
                              │ JSON event
                              ▼
                       ┌─────────────┐
                       │   Lambda    │
                       │  Ingestion  │
                       └──────┬──────┘
                              │
                              │ assumes
                              ▼
                       ┌─────────────┐
                       │ IAM Role    │
                       │ ingestion   │
                       └──────┬──────┘
                              │
                              │ s3:PutObject
                              ▼
                       ┌─────────────┐
                       │     S3      │
                       │  Data Lake  │
                       └──────┬──────┘
                              │
                              ▼
                            raw/


Data flow
Application Event
       │
       ▼
Lambda Ingestion
       │
       ▼
IAM Authorization
       │
       ▼
S3 PutObject
       │
       ▼
s3://data-platform-raw/raw/
Example Event

The Lambda can receive an event such as:

{
  "event_id": "evt-001",
  "user_id": "user-123",
  "event_type": "purchase",
  "product_id": "prod-42",
  "amount": 149.99,
  "currency": "USD"
}
S3 Data Layout

Events are stored using date-based partitions:

s3://data-platform-raw/

raw/
└── year=2026/
    └── month=09/
        └── day=28/
            ├── evt-001.json
            ├── evt-002.json
            └── evt-003.json

This structure prepares the data lake for later processing with services such as Glue, Spark, and Athena.
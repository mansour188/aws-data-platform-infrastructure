                   POST /events
                        │
                        ▼
              ┌─────────────────┐
              │   API Gateway   │
              │    HTTP API     │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Lambda Ingestion│
              └────────┬────────┘
                       │
                 s3:PutObject
                       │
                       ▼
              ┌─────────────────┐
              │   S3 RAW        │
              │ data-platform-raw│
              └─────────────────┘






   API Gateway
     │
     │ lambda:InvokeFunction
     ▼
   Lambda
     │
     │ assumes
     ▼
 IAM ingestion role
     │
     │ s3:PutObject
     ▼
    S3
# IAM Module

## Purpose

This module manages IAM roles used by workloads in the data platform.

The first implemented role is the ingestion role, which is designed for AWS Lambda workloads that ingest data into the S3 data lake.

---

## Architecture

```text
                         IAM
                          │
             ┌────────────┴────────────┐
             ▼                         ▼
      Ingestion Role             Processing Role
             │                         │
             ▼                         ▼
          S3 RAW                 S3 Bronze/Silver



## S3 Ingestion Policy

The ingestion role receives a dedicated S3 policy.

The current permission is:

```text
s3:PutObject
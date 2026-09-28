variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "bucket_name" {
  description = "Raw S3 bucket"
  type        = string
}

variable "ingestion_role_arn" {
  description = "IAM role ARN used by Lambda"
  type        = string
}

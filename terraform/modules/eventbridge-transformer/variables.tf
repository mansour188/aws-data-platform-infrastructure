variable "rule_name" {
  description = "EventBridge rule for RAW S3 objects"
  type        = string
}

variable "raw_bucket_name" {
  description = "RAW S3 bucket"
  type        = string
}

variable "transformer_function_name" {
  description = "Transformer Lambda function name"
  type        = string
}

variable "transformer_function_arn" {
  description = "Transformer Lambda function ARN"
  type        = string
}
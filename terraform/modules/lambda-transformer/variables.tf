variable "function_name" {
  description = "Transformer Lambda function name"
  type        = string
}

variable "raw_bucket_name" {
  description = "Raw S3 bucket"
  type        = string
}

variable "bronze_bucket_name" {
  description = "Bronze S3 bucket"
  type        = string
}

variable "transformer_role_arn" {
  description = "IAM role ARN for transformer Lambda"
  type        = string
}
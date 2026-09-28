variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}


variable "raw_bucket_name" {
  description = "S3 bucket used for raw data ingestion"
  type        = string
}
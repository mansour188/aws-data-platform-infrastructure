variable "aws_region" {
  description = "AWS region used by the local environment"
  type        = string
  default     = "us-east-1"
}

variable "floci_endpoint" {
  description = "Floci AWS-compatible endpoint"
  type        = string
  default     = "http://localhost:4566"
}

variable "aws_access_key" {
  description = "Local AWS access key used by Floci"
  type        = string
  default     = "test"
}

variable "aws_secret_key" {
  description = "Local AWS secret key used by Floci"
  type        = string
  default     = "test"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-data-platform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "local"
}

variable "raw_bucket_name" {
  description = "Raw data lake S3 bucket"
  type        = string
  default     = "data-platform-raw"
}



variable "bucket_name" {
  description = "Name of the S3 data lake bucket"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "local"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "aws-data-platform"
}
variable "layer" {
  description = "Data lake layer"
  type        = string
}
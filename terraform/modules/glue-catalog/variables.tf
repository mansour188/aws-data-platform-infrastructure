variable "database_name" {
  description = "Glue Data Catalog database name"
  type        = string
}

variable "bronze_bucket_name" {
  description = "S3 bucket containing Bronze data"
  type        = string
}
variable "silver_bucket_name" {
  description = "Silver S3 bucket"
  type        = string
}
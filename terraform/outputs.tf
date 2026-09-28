output "raw_bucket_name" {
  description = "Name of the raw data lake bucket"
  value       = module.raw_data_lake.bucket_name
}

output "raw_bucket_arn" {
  description = "ARN of the raw data lake bucket"
  value       = module.raw_data_lake.bucket_arn
}

output "raw_bucket_name" {
  description = "Name of the raw data lake bucket"
  value       = module.raw_data_lake.bucket_name
}

output "raw_bucket_arn" {
  description = "ARN of the raw data lake bucket"
  value       = module.raw_data_lake.bucket_arn
}


output "api_id" {
  description = "HTTP API identifier"
  value       = module.api_gateway.api_id
}

output "api_endpoint" {
  description = "HTTP API endpoint"
  value       = module.api_gateway.api_endpoint
}

output "api_arn" {
  description = "HTTP API ARN"
  value       = module.api_gateway.api_arn
}

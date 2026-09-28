output "function_name" {
  description = "Lambda ingestion function name"
  value       = aws_lambda_function.ingestion.function_name
}

output "function_arn" {
  description = "Lambda ingestion function ARN"
  value       = aws_lambda_function.ingestion.arn
}

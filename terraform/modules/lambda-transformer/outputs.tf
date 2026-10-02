output "function_name" {
  description = "Transformer Lambda function name"
  value       = aws_lambda_function.transformer.function_name
}

output "function_arn" {
  description = "Transformer Lambda function ARN"
  value       = aws_lambda_function.transformer.arn
}
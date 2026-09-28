output "api_id" {
  description = "HTTP API identifier"
  value       = aws_apigatewayv2_api.this.id
}

output "api_endpoint" {
  description = "HTTP API endpoint"
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "api_arn" {
  description = "HTTP API ARN"
  value       = aws_apigatewayv2_api.this.arn
}

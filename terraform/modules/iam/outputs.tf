output "ingestion_role_name" {
  description = "Name of the ingestion IAM role"
  value       = aws_iam_role.ingestion.name
}

output "ingestion_role_arn" {
  description = "ARN of the ingestion IAM role"
  value       = aws_iam_role.ingestion.arn
}
output "transformer_role_arn" {
  description = "IAM role ARN for the transformer Lambda"
  value       = aws_iam_role.transformer.arn
}
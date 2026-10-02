output "database_name" {
  description = "Glue Data Catalog database name"
  value       = aws_glue_catalog_database.this.name
}

output "bronze_table_name" {
  description = "Glue Bronze events table name"
  value       = aws_glue_catalog_table.bronze_events.name
}

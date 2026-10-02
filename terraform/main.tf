module "raw_data_lake" {
  source = "./modules/s3-data-lake"

  bucket_name = var.raw_bucket_name
  environment = var.environment
  project     = var.project_name
  layer       = "raw"
}
module "iam" {
  source = "./modules/iam"

  project_name       = var.project_name
  environment        = var.environment
  raw_bucket_name    = var.raw_bucket_name
  bronze_bucket_name = module.bronze_data_lake.bucket_name
}

module "lambda_ingestion" {
  source = "./modules/lambda-ingestion"

  function_name      = "${var.project_name}-ingestion"
  bucket_name        = var.raw_bucket_name
  ingestion_role_arn = module.iam.ingestion_role_arn
}


module "api_gateway" {
  source = "./modules/api-gateway"

  api_name             = "${var.project_name}-api"
  lambda_function_name = module.lambda_ingestion.function_name
  lambda_function_arn  = module.lambda_ingestion.function_arn
}

module "bronze_data_lake" {
  source = "./modules/s3-data-lake"

  bucket_name = "data-platform-bronze"
  environment = var.environment
  project     = var.project_name
  layer       = "bronze"
}

module "glue_catalog" {
  source = "./modules/glue-catalog"

  database_name      = "data_platform"
  bronze_bucket_name = module.bronze_data_lake.bucket_name
  silver_bucket_name = module.silver_data_lake.bucket_name
}

module "lambda_transformer" {
  source = "./modules/lambda-transformer"

  function_name        = "${var.project_name}-transformer"
  raw_bucket_name      = var.raw_bucket_name
  bronze_bucket_name   = module.bronze_data_lake.bucket_name
  transformer_role_arn = module.iam.transformer_role_arn
}

module "eventbridge_transformer" {
  source = "./modules/eventbridge-transformer"

  rule_name                 = "${var.project_name}-raw-object-created"
  raw_bucket_name           = var.raw_bucket_name
  transformer_function_name = module.lambda_transformer.function_name
  transformer_function_arn  = module.lambda_transformer.function_arn
}


module "silver_data_lake" {
  source = "./modules/s3-data-lake"

  bucket_name = "data-platform-silver"
  environment = var.environment
  project     = var.project_name
  layer       = "silver"
}


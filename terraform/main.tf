module "raw_data_lake" {
  source = "./modules/s3-data-lake"

  bucket_name = var.raw_bucket_name
  environment = var.environment
  project     = var.project_name
}
module "iam" {
  source = "./modules/iam"

  project_name    = var.project_name
  environment     = var.environment
  raw_bucket_name = var.raw_bucket_name

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
provider "aws" {
  region = var.aws_region

  endpoints {
    s3  = var.floci_endpoint
    sts = var.floci_endpoint
  }

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

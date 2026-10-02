data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "transformer" {
  function_name = var.function_name
  role          = var.transformer_role_arn

  handler = "handler.handler"
  runtime = "python3.12"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  environment {
    variables = {
      RAW_BUCKET_NAME    = var.raw_bucket_name
      BRONZE_BUCKET_NAME = var.bronze_bucket_name
    }
  }

  tags = {
    Component = "transformer"
  }
}
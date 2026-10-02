resource "aws_cloudwatch_event_rule" "s3_raw_object_created" {
  name        = var.rule_name
  description = "Trigger transformer when a RAW S3 object is created"

  event_pattern = jsonencode({
    source = [
      "aws.s3"
    ]

    detail-type = [
      "Object Created"
    ]

    detail = {
      bucket = {
        name = [
          var.raw_bucket_name
        ]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "transformer" {
  rule = aws_cloudwatch_event_rule.s3_raw_object_created.name
  arn  = var.transformer_function_arn
}

resource "aws_lambda_permission" "eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.transformer_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_raw_object_created.arn
}
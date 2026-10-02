resource "aws_iam_role" "ingestion" {
  name = "${var.project_name}-ingestion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Component   = "ingestion"
  }
}

resource "aws_iam_policy" "ingestion_s3" {
  name = "${var.project_name}-ingestion-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = "arn:aws:s3:::${var.raw_bucket_name}/raw/*"
      },
      {
        Effect = "Allow"

        Action = [
          "events:PutEvents"
        ]

        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ingestion_s3" {
  role       = aws_iam_role.ingestion.name
  policy_arn = aws_iam_policy.ingestion_s3.arn
}

resource "aws_iam_role" "transformer" {
  name = "${var.project_name}-transformer-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Component   = "transformer"
  }
}

resource "aws_iam_policy" "transformer_s3" {
  name = "${var.project_name}-transformer-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = "arn:aws:s3:::${var.raw_bucket_name}/raw/*"
      },
      {
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = "arn:aws:s3:::${var.bronze_bucket_name}/events/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "transformer_s3" {
  role       = aws_iam_role.transformer.name
  policy_arn = aws_iam_policy.transformer_s3.arn
}
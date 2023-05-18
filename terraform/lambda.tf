data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "secrets_policy" {
  statement {
    effect = "Allow"

    actions = ["secretsmanager:GetSecretValue"]

    resources = [
      aws_secretsmanager_secret.WC_API_URL.arn,
      aws_secretsmanager_secret.WC_CONSUMER_KEY.arn,
      aws_secretsmanager_secret.WC_CONSUMER_SECRET.arn
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_policy" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      aws_dynamodb_table.products.arn
    ]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = "secrets_policy"
    policy = data.aws_iam_policy_document.secrets_policy.json
  }

  inline_policy {
    name   = "dynamodb_policy"
    policy = data.aws_iam_policy_document.dynamodb_policy.json
  }

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

  tags = var.common_tags
}

resource "aws_lambda_function" "process_products" {
  function_name = "process-products"

  role      = aws_iam_role.iam_for_lambda.arn
  image_uri = "${aws_ecr_repository.ecr_repository.repository_url}:latest"

  package_type = "Image"
  timeout      = 60

  depends_on = [aws_ecr_repository.ecr_repository]

  tags = var.common_tags
}

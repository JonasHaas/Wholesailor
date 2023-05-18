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

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

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

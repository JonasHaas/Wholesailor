resource "aws_secretsmanager_secret" "WC_API_URL" {
  name = "WC_API_URL"
}

resource "aws_secretsmanager_secret" "WC_CONSUMER_KEY" {
  name = "WC_CONSUMER_KEY"
}

resource "aws_secretsmanager_secret" "WC_CONSUMER_SECRET" {
  name = "WC_CONSUMER_SECRET"
}

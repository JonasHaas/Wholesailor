  name        = "WC_API_URL"
  description = "The API URL for WC"
}

resource "aws_secretsmanager_secret" "WC_CONSUMER_KEY" {
  name        = "WC_CONSUMER_KEY"
  description = "The consumer key for WC"
}

resource "aws_secretsmanager_secret" "WC_CONSUMER_SECRET" {
  name        = "WC_CONSUMER_SECRET"
  description = "The consumer secret for WC"
}
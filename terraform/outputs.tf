output "website_url" {
  description = "The URL of the website hosted in the S3 bucket"
  value       = "https://${aws_s3_bucket.frontend_bucket.bucket}.s3.${data.aws_region.current.name}.amazonaws.com/index.html"
}

output "ecr_uri" {
  value       = aws_ecr_repository.ecr_repository.repository_url
  description = "The URI of the ECR repository."
}

output "ecr_uri2" {
  value       = aws_ecr_repository.ecr_repository2.repository_url
  description = "The URI of the ECR2 repository."
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.ecr_repository.arn
  description = "The arn of the ECR repository."
}

output "ecr_repository_arn2" {
  value       = aws_ecr_repository.ecr_repository2.arn
  description = "The arnURI of the ECR2 repository."
}

output "api_gateway_invoke_url" {
  description = "The URL to invoke the API Gateway"
  value       = aws_api_gateway_deployment.deployment.invoke_url
}

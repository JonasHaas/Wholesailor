output "website_url" {
  description = "The URL of the website hosted in the S3 bucket"
  value       = "https://${aws_s3_bucket.frontend_bucket.bucket}.s3.${data.aws_region.current.name}.amazonaws.com/index.html"
}

output "uri" {
  value       = aws_ecr_repository.ecr_repository.repository_url
  description = "The URI of the ECR repository."
}

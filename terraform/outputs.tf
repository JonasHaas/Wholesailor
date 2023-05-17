output "website_url" {
  description = "The URL of the website hosted in the S3 bucket"
  value       = "https://${aws_s3_bucket.frontend_bucket.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}

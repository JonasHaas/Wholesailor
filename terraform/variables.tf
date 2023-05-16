variable "common_tags" {
  description = "tags for this project"
  default = {
    "ManagedBy"   = "Terraform"
    "Environment" = "Dev"
    "Project"     = "Wholesailor"
    "Owner"       = "Jonas Haas"
  }
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
  default     = "wholesailor-frontend-bucket"
}

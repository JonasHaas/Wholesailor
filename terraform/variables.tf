variable "common_tags" {
  description = "tags for this project"
  default = {
    "ManagedBy"   = "Terraform"
    "Environment" = "Dev"
    "Project"     = "Wholesailor"
    "Owner"       = "Jonas Haas"
  }
}

variable "project_name" {
  type    = string
  default = "wholesailor"
}

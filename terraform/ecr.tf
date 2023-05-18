resource "aws_ecr_repository" "ecr_repository" {
  name                 = "${var.project_name}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.common_tags
}

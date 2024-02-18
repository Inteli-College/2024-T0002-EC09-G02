resource "aws_ecr_repository" "image_ecr" {
  name                 = "image-repo"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
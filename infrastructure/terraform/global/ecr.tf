resource "aws_ecr_repository" "kafka-listener-repo" {
  name = "kafka-listener-repo"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kafka-consumer-repo" {
  name = "kafka-consumer-repo"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
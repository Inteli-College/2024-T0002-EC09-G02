resource "aws_s3_bucket" "infrastructure_state_terraform" {
  bucket_prefix = "infrastructure-state-terraform"
  acl    = "public-read"

  versioning {
    enabled = true
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_object" "infrastructure_state_terraform_folder" {
  bucket = aws_s3_bucket.infrastructure_state_terraform.bucket
  key    = "state-files/"
  acl    = "public-read"
  content_type = "application/x-directory"
}
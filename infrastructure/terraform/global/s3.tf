resource "aws_s3_bucket" "infrastructure_state_terraform" {
  bucket_prefix = "infrastructure-state-terraform"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET, PUT, POST, DELETE, HEAD"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_object" "infrastructure_state_terraform_folder" {
  bucket = aws_s3_bucket.infrastructure_state_terraform.bucket
  key    = "state-files/"
  content_type = "application/x-directory"
}

resource "aws_cloudfront_origin_access_identity" "s3_origin_access_identity" {
  comment = "S3 origin access identity for store-bucket"
}

resource "aws_s3_bucket_ownership_controls" "infrastructure_state_terraform_oc" {
  bucket = aws_s3_bucket.infrastructure_state_terraform.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "infrastructure_state_terraform" {
  bucket = aws_s3_bucket.infrastructure_state_terraform.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "infrastructure_state_terraform_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.infrastructure_state_terraform_oc,
    aws_s3_bucket_public_access_block.infrastructure_state_terraform,
  ]

  bucket = aws_s3_bucket.infrastructure_state_terraform.id
  acl    = "public-read"
}
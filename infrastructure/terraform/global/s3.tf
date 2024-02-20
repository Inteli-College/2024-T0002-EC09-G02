resource "aws_s3_bucket" "infrastructure_state_terraform" {
  bucket_prefix = "infrastructure-state-terraform"
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
  content_type = "application/x-directory"
}

resource "aws_cloudfront_origin_access_identity" "s3_origin_access_identity" {
  comment = "S3 origin access identity for store-bucket"
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.infrastructure_state_terraform.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "Policy1692122833651",
    "Statement": [
        {
            "Sid": "Stmt1692122770670",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "${aws_s3_bucket.infrastructure_state_terraform.arn}/state-files/*"
        }
    ]
  })
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
resource "aws_s3_bucket" "infrastructure_state_terraform" {
  bucket_prefix = "infrastructure-state-terraform"
  object_ownership = "BucketOwnerEnforced"
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
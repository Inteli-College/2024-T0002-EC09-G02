resource "aws_s3_bucket" "data_storage" {
  bucket_prefix = "data-storage"

  versioning {
    enabled = true
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

output "bucket_data_storage_name" {
  value = aws_s3_bucket.data_storage.name
}

resource "aws_s3_bucket_object" "data_storage_folder" {
  bucket       = aws_s3_bucket.data_storage.bucket
  key          = "state-files/"
  content_type = "application/x-directory"
}

resource "aws_cloudfront_origin_access_identity" "s3_origin_access_identity" {
  comment = "S3 origin access identity for store-bucket"
}

resource "aws_s3_bucket_ownership_controls" "data_storage_oc" {
  bucket = aws_s3_bucket.data_storage.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "data_storage" {
  bucket = aws_s3_bucket.data_storage.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "data_storage_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.data_storage_oc,
    aws_s3_bucket_public_access_block.data_storage,
  ]

  bucket = aws_s3_bucket.data_storage.id
  acl    = "public-read"
}

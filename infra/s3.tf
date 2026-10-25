resource "aws_s3_bucket" "devopsing_site" {
  bucket        = "devopsing-site-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "devopsing_site" {
  bucket = aws_s3_bucket.devopsing_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "devopsing_site" {
  bucket = aws_s3_bucket.devopsing_site.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

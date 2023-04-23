#todo add cloudfront distribution once ready for prod

resource "aws_s3_bucket" "frontend_assets" {
  bucket        = "flight-booking-fe"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "frontend" {
  bucket = aws_s3_bucket.frontend_assets.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend_assets.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "frontend" {
  depends_on = [
    aws_s3_bucket_ownership_controls.frontend,
    aws_s3_bucket_public_access_block.frontend,
  ]

  bucket = aws_s3_bucket.frontend_assets.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "flight_booking_config" {
  bucket = aws_s3_bucket.frontend_assets.bucket
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_policy" "frontend_assets_policy" {
  bucket = aws_s3_bucket.frontend_assets.id
  policy = templatefile(
    "${path.module}/s3-policy.json",
    { bucket = aws_s3_bucket.frontend_assets.bucket }
  )
}

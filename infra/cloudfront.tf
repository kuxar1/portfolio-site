locals {
  s3_origin_id = "DevOpsingSiteS3Origin"
}

resource "aws_cloudfront_function" "index_rewrite" {
  name    = "devopsing-site-index-rewrite"
  runtime = "cloudfront-js-2.0"
  comment = "Append index.html to directory URIs"
  publish = true
  code    = file("${path.module}/functions/index-rewrite.js")
}

data "aws_iam_policy_document" "devopsing_site" {
  statement {
    sid    = "AllowCloudFrontRead"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.devopsing_site.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.devopsing_site.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "devopsing_site" {
  bucket = aws_s3_bucket.devopsing_site.id
  policy = data.aws_iam_policy_document.devopsing_site.json
}

resource "aws_cloudfront_origin_access_control" "devopsing_site" {
  name                              = "devopsing-site-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "devopsing_site" {
  origin {
    domain_name              = aws_s3_bucket.devopsing_site.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.devopsing_site.id
    origin_id                = local.s3_origin_id
  }

  http_version    = "http2and3"
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id
    viewer_protocol_policy = "redirect-to-https"

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.index_rewrite.arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}

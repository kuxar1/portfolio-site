output "account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "The AWS account ID"
}

output "site_bucket_name" {
  value       = aws_s3_bucket.devopsing_site.bucket
  description = "The name of the S3 bucket for the site"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.devopsing_site.id
  description = "The ID of the CloudFront distribution"
}

output "cloudfront_distribution_domain_name" {
  value       = aws_cloudfront_distribution.devopsing_site.domain_name
  description = "The domain name of the CloudFront distribution"
}

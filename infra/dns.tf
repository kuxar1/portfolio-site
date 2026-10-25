resource "cloudflare_dns_record" "site_apex" {
  name    = var.domain_name
  content = aws_cloudfront_distribution.devopsing_site.domain_name
  ttl     = 1
  type    = "CNAME"
  proxied = false
  zone_id = var.cloudflare_zone_id
}

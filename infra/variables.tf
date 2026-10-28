variable "domain_name" {
  type        = string
  default     = "devopsing.dev"
  description = "The domain name for the portfolio site"
}

variable "cloudflare_zone_id" {
  type        = string
  default     = "5ec8b80e11125caf8ffab74e8d32e960"
  description = "The Cloudflare zone ID for the domain"
}

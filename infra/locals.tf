locals {
  s3_origin_id = "DevOpsingSiteS3Origin"
  common_tags = {
    Project    = "portfolio-site"
    ManagedBy  = "terraform"
    Repository = "github.com/kuxar1/portfolio-site"
  }
}

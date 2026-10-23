terraform {
  backend "s3" {
    bucket       = "devopsing-tfstate-882386995952"
    key          = "portfolio-site/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
    encrypt      = true
  }
}

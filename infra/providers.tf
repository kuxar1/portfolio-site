provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Project    = "portfolio-site"
      ManagedBy  = "terraform"
      Repository = "github.com/kuxar1/portfolio-site"
    }
  }
}

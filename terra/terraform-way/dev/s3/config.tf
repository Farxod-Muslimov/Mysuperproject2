provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "farhod1994.terraform"
    key    = "dev/s3/terraform.tfstate"
    region = "eu-central-1"
  }
}

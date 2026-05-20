provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "farhod1994.terraform"
    key    = "globalvars/terraform.tfstate"
    region = "eu-central-1"
  }
}

#--------------------------------------------
output "company_name" {
  value = "Huawei"
}

output "owner" {
  value = "Farxod Muslimov"
}

output "tags" {
  value = {
    Project    = "Huawei project"
    CostCenter = "R&D"
    Country    = "Uzbekistan"
  }
}

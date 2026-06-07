include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v5.8.2"
}

inputs = {
  bucket = "farhod1994.terragrunt-dev"
  tags = {
    Owner       = "Farxod Muslimov"
    Environment = "dev"
    }
}

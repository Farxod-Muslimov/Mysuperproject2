# Generate backend.tf file with remote state configuration
remote_state {
  backend = "s3"

  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket  = "farhod1994.terragrunt"
    region  = "eu-central-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
  }
}

# Generate config.tf file with provider configuration
generate "my_config" {
  path      = "_config.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = var.aws_region
}

variable "aws_region" {}
EOF
}

# Load Variables
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      find_in_parent_folders("common.tfvars"),
    ]
  }
}

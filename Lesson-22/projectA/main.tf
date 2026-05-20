provider "aws" {
  region = "eu-central-1"
}

/*
module "vpc-default" {
  source = "../modules/aws_network"
}
*/

module "vpc-prod" {
  //source               = "../modules/aws_network"
  source               = "git@github.com:Farxod-Muslimov/Mysuperproject2.git//aws_network"
  env                  = "production"
  vpc_cidr             = "10.10.0.0/16"
  puclic_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = ["10.10.11.0/24", "10.10.22.0/24"]
}

#------------------------------------------------------------

output "prod_vpc_id" {
  value = module.vpc-prod.vpc_id
}

output "prod_vpc_cidr" {
  value = module.vpc-prod.vpc_cidr
}

output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}

# Auto fill parameters 

# File can be named as:
# terraform.tfvars
# dev.auto.tfvars
# prod.auto.tfvars

region                     = "eu-central-1"
instance_type              = "t3.micro"
enable_detailed_monitoring = false

allow_ports = ["80", "443"]
common_tags = {
  Owner       = "Farxod Muslimov"
  Project     = "Huawei"
  Environment = "Dev"
}

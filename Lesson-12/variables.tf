variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "allow_ports" {
  description = "List of Ports to open for Server"
  default     = ["80", "443", "22"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  default = {
    Owner       = "Farxod Muslimov"
    Project     = "Huawei"
    Environment = "Development"
  }
}

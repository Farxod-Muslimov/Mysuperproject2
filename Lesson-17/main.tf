provider "aws" {
  region = "eu-central-1"
}

variable "env" {
  default = "dev"
}

variable "prod_owner" {
  default = "Farxod Muslimov"
}

variable "noprod_owner" {
  default = "Oybek Muslimov"
}

variable "ec2_size" {
  default = {
    "prod"    = "c7i-flex.large"
    "dev"     = "t3.micro"
    "staging" = "t3.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "22"]
  }
}


resource "aws_instance" "my_webserver1" {
  ami = "ami-0de6934e87badb694"
  //instance_type = var.env == "prod" ? "t3.small" : "t3.micro"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-0de6934e87badb694"
  instance_type = "t3.micro"

  tags = {
    Name = "dev-server"
  }
}

resource "aws_instance" "my_webserver2" {
  ami           = "ami-0de6934e87badb694"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic-Security-Group"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Security-Group"
    Owner = "Farxod Muslimov"
  }
}

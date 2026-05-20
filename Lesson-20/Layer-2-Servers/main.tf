provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "farhod1994.terraform"
    key    = "dev/servers/terraform.tfstate"
    region = "eu-central-1"
  }
}

#---------------------------------------------------------------


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "farhod1994.terraform"
    key    = "dev/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

output "network_details" {
  value = data.terraform_remote_state.network
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}
#-----------------------------------------------------------------
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  user_data              = file("user_data.sh")
  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "webserver" {
  name   = "WebServer Security Group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "web-server-sg"
    Owner = "Farxod Muslimov"
  }
}

#----------------------------------------------------------------------

output "webserver_sg_id" {
  value = aws_security_group.webserver.id
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

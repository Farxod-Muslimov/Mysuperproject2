provider "aws" {
  region = "eu-central-1"
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}


resource "aws_instance" "my_default_server" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_amazon_linux.id
  key_name      = "Frankfurt-key"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
    Name = "Default Server"
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic-Security-Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
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
    Name = "Security-Group"
  }

}




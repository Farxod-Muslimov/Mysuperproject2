data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")
  tags = {
    Name  = "PROD WebServer - ${terraform.workspace}"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_security_group" "web" {
  name = "WebServer SG Prod - ${terraform.workspace}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup - ${terraform.workspace}"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags = {
    Name  = "PROD WebServer IP - ${terraform.workspace}"
    Owner = "Farxod Muslimov"
  }
}

#######################################
output "web_public_ip" {
  value = aws_eip.web.public_ip
}

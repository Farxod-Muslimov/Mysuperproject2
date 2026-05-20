resource "aws_instance" "web-prod" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web-prod.id]
  user_data              = file("user_data.sh")
  tags = {
    Name  = "PROD WebServer"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_security_group" "web-prod" {
  name        = "WebServer SG Prod"
  description = "My First SecurityGroup"

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
    Name  = "Web Server SecurityGroup"
    Owner = "Farxod Muslimov"
  }
}

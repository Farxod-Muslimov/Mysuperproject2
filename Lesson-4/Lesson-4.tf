provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webser" {
  ami                    = "ami-0de6934e87badb694"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webser.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Farxod",
    l_name = "Muslimov",
    names  = ["Oybek", "Zafar", "Aziza", "Muslim"]
  })

  tags = {
    Name = "Web-Server"
  }
}

resource "aws_security_group" "my_webser" {
  name        = "WebServer-Security-Group"
  description = "My-First-Security-Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "Security-Group"
  }

}

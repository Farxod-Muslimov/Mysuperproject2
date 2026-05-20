resource "aws_instance" "amazon1" {
  ami                    = "ami-0abe96a6773a37eb1"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.amazon1.id]
  ebs_optimized          = true
  tags = {
    Name  = "amazon project"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_security_group" "amazon1" {
  description = "SSH-HTTP"
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

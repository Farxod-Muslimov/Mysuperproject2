provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "node1" {
  ami           = "ami-0abe96a6773a37eb1"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-1"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-0abe96a6773a37eb1"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-2"
    Owner = "Farxod Muslimov"
  }
}

resource "aws_instance" "node3" {
  ami           = "ami-0abe96a6773a37eb1"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-3"
    Owner = "Farxod Muslimov"
  }
  depends_on = [aws_instance.node2]
}

provider "aws" {}

resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-05852c5f195d545ea"
  instance_type = "t3.micro"

  tags = {
    Name = "My Ubuntu Server"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-014f11e8c26ed3e15"
  instance_type = "t3.micro"

  tags = {
    Name = "My Amazon Server"
  }
}

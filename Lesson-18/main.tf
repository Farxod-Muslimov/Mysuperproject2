provider "aws" {
  region = "eu-central-1"
}

variable "aws_users" {
  description = "List of users"
  default     = ["Muslim", "Aziza", "Oybek", "Zafar"]
}

resource "aws_iam_user" "user" {
  name = "pushkin"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}


#--------------------------------------------------

resource "aws_instance" "server" {
  count         = 3
  ami           = "ami-0de6934e87badb694"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}



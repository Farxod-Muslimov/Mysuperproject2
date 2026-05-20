provider "aws" {
  region = "eu-central-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform Start: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Hello World!')"
    interpreter = ["python3", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = " echo $Name1 $Name2 $Name3 >> names.txt"
    environment = {
      Name1 = "Muslim"
      Name2 = "Oybek"
      Name3 = "Zafar"
    }
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-0de6934e87badb694"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo Hello from AWS Instance Creations"
  }
}


resource "null_resource" "command6" {
  provisioner "local-exec" {
    command = "echo Terraform End: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2,
  null_resource.command3, null_resource.command4, aws_instance.myserver]
}

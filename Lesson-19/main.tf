provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

data "aws_ami" "usa_amazon_linux" {
  provider    = aws.USA
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
  tags = {
    Name = "Default Server"
  }
}

resource "aws_instance" "my_usa_server" {
  provider      = aws.USA
  instance_type = "t3.micro"
  ami           = data.aws_ami.usa_amazon_linux.id
  tags = {
    Name = "USA Server"
  }
}

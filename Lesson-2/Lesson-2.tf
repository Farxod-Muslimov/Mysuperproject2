provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my-webser" {
  ami                    = "ami-0de6934e87badb694"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webser.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

myip=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html

systemctl enable httpd
systemctl start httpd
EOF

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

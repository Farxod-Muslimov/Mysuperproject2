provider "aws" {
  region = "eu-central-1"
}

variable "name" {
  default = "oybek"
}
resource "random_string" "rds_password" { # sozdat parol
  length           = 12
  special          = true
  override_special = "!#$&"
  keepers = {
    kepeer1 = var.name
  }
}

resource "aws_ssm_parameter" "rds_password" { # soxranit parol v aws system manger
  name        = "/prod/mysql"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
}

data "aws_ssm_parameter" "my_rds_password" { # vzyat parol iz aws system manger
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}

resource "aws_db_instance" "default" { # ispolzovat parol v rds
  identifier           = "prod-rds"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "administrator"
  password             = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  apply_immediately    = true
}


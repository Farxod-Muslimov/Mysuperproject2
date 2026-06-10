# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "sql" {
  ami                                  = "ami-0c8ab82f51d47e1be"
  associate_public_ip_address          = true
  availability_zone                    = "eu-central-1b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  key_name                             = "Frankfurt-key"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "172.31.41.181"
  region                               = "eu-central-1"
  secondary_private_ips                = []
  security_groups                      = ["My-SQLServer-sg"]
  source_dest_check                    = true
  subnet_id                            = "subnet-039595cc713f37885"
  tags = {
    Name = "SQL-Server"
  }
  tags_all = {
    Name = "SQL-Server"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e5bc7c5805fdb344"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}

# __generated__ by Terraform
resource "aws_instance" "web" {
  ami                                  = "ami-0c8ab82f51d47e1be"
  associate_public_ip_address          = true
  availability_zone                    = "eu-central-1b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  key_name                             = "Frankfurt-key"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "172.31.37.138"
  region                               = "eu-central-1"
  secondary_private_ips                = []
  security_groups                      = ["My-WebServer-sg"]
  source_dest_check                    = true
  subnet_id                            = "subnet-039595cc713f37885"
  tags = {
    Name = "WEB-Server"
  }
  tags_all = {
    Name = "WEB-Server"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0b67246e1c40b3895"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}

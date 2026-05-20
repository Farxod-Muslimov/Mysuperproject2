provider "aws" {
  region = "eu-central-1"
}

# -----------------------------
# Data sources
# -----------------------------
data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

# -----------------------------
# Default subnets
# -----------------------------
resource "aws_default_subnet" "az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Launch Template
# -----------------------------
resource "aws_launch_template" "web" {
  name_prefix   = "web-template-"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = base64encode(file("user_data.sh"))
}

# -----------------------------
# ALB (Load Balancer)
# -----------------------------
resource "aws_lb" "web" {
  name               = "web-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [
    aws_default_subnet.az1.id,
    aws_default_subnet.az2.id
  ]
}

# -----------------------------
# Target Group
# -----------------------------
resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_subnet.az1.vpc_id

  health_check {
    path = "/"
    port = "80"
  }
}

# -----------------------------
# Listener
# -----------------------------
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# -----------------------------
# Auto Scaling Group
# -----------------------------
resource "aws_autoscaling_group" "web" {
  name = "web-asg"

  min_size         = 2
  max_size         = 2
  desired_capacity = 2

  vpc_zone_identifier = [
    aws_default_subnet.az1.id,
    aws_default_subnet.az2.id
  ]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web.arn]

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "WebServer-in-ASG"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# -----------------------------
# Output
# -----------------------------
output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

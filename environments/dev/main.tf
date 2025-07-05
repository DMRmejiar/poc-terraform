provider "aws" {
  region = var.aws_region
}

# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group for the EC2 instance
resource "aws_security_group" "demo_sg" {
  name        = "terraform-poc-sg-${var.environment}"
  description = "Security group for Terraform PoC EC2 instance"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name        = "terraform-poc-sg-${var.environment}"
    Environment = var.environment
  }
}

# EC2 instance
resource "aws_instance" "demo" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name != "" ? var.key_name : null
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    encrypted   = false

    tags = {
      Name = "terraform-poc-root-${var.environment}"
    }
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Terraform PoC</title>
                  <style>
                      body { font-family: Arial; margin: 40px; background: #f5f5f5; }
                      .container { background: white; padding: 20px; border-radius: 8px; }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🚀 Terraform PoC - ${var.environment}</h1>
                      <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
                      <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
                      <p><strong>Region:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/region)</p>
                      <hr>
                      <small>Infraestructura como Código con Terraform</small>
                  </div>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name        = "terraform-poc-instance-${var.environment}"
    Environment = var.environment
    Project     = "terraform-poc"
  }
}

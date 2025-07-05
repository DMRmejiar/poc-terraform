# ==============================================
# WEB SERVER MODULE
# ==============================================

# Data source for latest Amazon Linux 2 AMI
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

# EC2 Instance
resource "aws_instance" "this" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name != "" ? var.key_name : null
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = var.encrypted

    tags = merge(var.tags, {
      Name = "${var.name}-root"
    })
  }

  user_data = var.user_data

  tags = merge(var.tags, {
    Name = var.name
    Role = var.role
  })
}

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
              
              # Obtener datos de metadatos
              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              INSTANCE_TYPE=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)
              REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
              AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
              
              # Crear página HTML con los datos obtenidos
              cat > /var/www/html/index.html << HTML
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Terraform PoC</title>
                  <style>
                      body { 
                          font-family: Arial, sans-serif; 
                          margin: 40px; 
                          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                          color: white;
                      }
                      .container { 
                          background: rgba(255,255,255,0.1); 
                          padding: 30px; 
                          border-radius: 15px; 
                          backdrop-filter: blur(10px);
                          max-width: 600px;
                          margin: 0 auto;
                      }
                      .info-item {
                          background: rgba(255,255,255,0.1);
                          padding: 10px;
                          margin: 10px 0;
                          border-radius: 5px;
                      }
                      .success { color: #4CAF50; font-weight: bold; }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🚀 Terraform PoC Exitosa</h1>
                      <div class="success">✅ Infraestructura desplegada correctamente</div>
                      
                      <h3>📊 Información de la Instancia:</h3>
                      <div class="info-item"><strong>Instance ID:</strong> $INSTANCE_ID</div>
                      <div class="info-item"><strong>Instance Type:</strong> $INSTANCE_TYPE</div>
                      <div class="info-item"><strong>Región:</strong> $REGION</div>
                      <div class="info-item"><strong>Zona de Disponibilidad:</strong> $AZ</div>
                      <div class="info-item"><strong>Entorno:</strong> ${var.environment}</div>
                      
                      <hr style="margin: 20px 0; border: 1px solid rgba(255,255,255,0.3);">
                      <p>🎯 <strong>Terraform PoC</strong> - Infrastructure as Code</p>
                      <small>Desplegado automáticamente con Terraform + GitHub Actions</small>
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

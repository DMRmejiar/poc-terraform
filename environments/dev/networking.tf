# ==============================================
# NETWORKING USING MODULES
# ==============================================

# Security Group using module
module "security_group" {
  source = "../../modules/security-group"

  name        = "terraform-poc-sg-${var.environment}"
  description = "Security group for Terraform PoC EC2 instances"

  ingress_rules = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = local.common_tags
}

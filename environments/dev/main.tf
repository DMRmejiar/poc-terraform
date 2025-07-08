# ==============================================
# TERRAFORM POC - MAIN CONFIGURATION
# ==============================================

# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Local values for common configurations
locals {
  common_tags = {
    Environment = var.environment
    Project     = "terraform-poc"
    Repository  = "poc-terraform"
  }
}


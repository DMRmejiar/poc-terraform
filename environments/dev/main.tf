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
    CreatedBy   = "terraform"
    Repository  = "poc-terraform"
    Version     = "v1.0"
  }
}


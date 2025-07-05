# ==============================================
# TERRAFORM POC - MAIN CONFIGURATION
# ==============================================

# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Terraform configuration
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
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


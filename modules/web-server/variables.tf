# ==============================================
# WEB SERVER MODULE - VARIABLES
# ==============================================

variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "role" {
  description = "Role of the server (e.g., primary, secondary)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance (optional, will use latest Amazon Linux 2 if not provided)"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs to assign to the instance"
  type        = list(string)
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
  default     = ""
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "EBS volume size in GB"
  type        = number
  default     = 8
}

variable "encrypted" {
  description = "Whether to encrypt the EBS volume"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

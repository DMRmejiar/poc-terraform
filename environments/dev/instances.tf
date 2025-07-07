# ==============================================
# EC2 INSTANCES USING MODULES
# ==============================================

# Primary Server using module
module "primary_server" {
  source = "../../modules/web-server"

  name               = "terraform-poc-primary-${var.environment}"
  role               = "primary-server"
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  key_name           = var.key_name
  security_group_ids = [module.security_group.security_group_id]
  user_data = templatefile("${path.module}/user-data-primary.sh", {
    environment = var.environment
  })

  tags = local.common_tags
}

# Secondary Server using module (agregado en commit 2)
# module "secondary_server" {
#   source = "../../modules/web-server"

#   name               = "terraform-poc-secondary-${var.environment}"
#   role               = "secondary-server"
#   instance_type      = var.instance_type
#   ami_id             = var.ami_id
#   key_name           = var.key_name
#   security_group_ids = [module.security_group.security_group_id]
#   user_data = templatefile("${path.module}/user-data-secondary.sh", {
#     environment = var.environment
#   })

#   tags = local.common_tags
# }

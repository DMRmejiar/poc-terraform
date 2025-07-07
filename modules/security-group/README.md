# Security Group Module

Este módulo crea un Security Group de AWS con reglas de ingress y egress configurables.

## Uso

```hcl
module "security_group" {
  source = "../../modules/security-group"

  name        = "my-security-group"
  description = "Security group for web servers"

  ingress_rules = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "terraform-poc"
  }
}
```

## Variables

| Variable | Descripción | Tipo | Default | Requerido |
|----------|-------------|------|---------|-----------|
| name | Nombre del security group | string | - | ✅ |
| description | Descripción del security group | string | "Security group managed by Terraform" | ❌ |
| ingress_rules | Lista de reglas de ingress | list(object) | [] | ❌ |
| egress_rules | Lista de reglas de egress | list(object) | [regla para todo el tráfico saliente] | ❌ |
| tags | Tags a aplicar | map(string) | {} | ❌ |

## Outputs

| Output | Descripción |
|--------|-------------|
| security_group_id | ID del security group |
| security_group_name | Nombre del security group |
| security_group_arn | ARN del security group |

# Web Server Module

Este módulo crea una instancia EC2 configurada como servidor web con Apache.

## Uso

```hcl
module "web_server" {
  source = "../../modules/web-server"

  name               = "my-web-server"
  role               = "primary-server"
  instance_type      = "t2.micro"
  security_group_ids = [module.security_group.security_group_id]
  user_data          = local.my_user_data

  tags = {
    Environment = "dev"
    Project     = "terraform-poc"
  }
}
```

## Variables

| Variable | Descripción | Tipo | Default | Requerido |
|----------|-------------|------|---------|-----------|
| name | Nombre de la instancia EC2 | string | - | ✅ |
| role | Rol del servidor | string | - | ✅ |
| instance_type | Tipo de instancia EC2 | string | "t2.micro" | ❌ |
| ami_id | ID de la AMI | string | "" (usa la más reciente de Amazon Linux 2) | ❌ |
| key_name | Nombre del key pair para SSH | string | "" | ❌ |
| security_group_ids | Lista de IDs de security groups | list(string) | - | ✅ |
| user_data | Script de inicialización | string | "" | ❌ |
| volume_type | Tipo de volumen EBS | string | "gp2" | ❌ |
| volume_size | Tamaño del volumen en GB | number | 8 | ❌ |
| encrypted | Cifrar el volumen EBS | bool | false | ❌ |
| tags | Tags a aplicar | map(string) | {} | ❌ |

## Outputs

| Output | Descripción |
|--------|-------------|
| instance_id | ID de la instancia EC2 |
| instance_public_ip | IP pública de la instancia |
| instance_private_ip | IP privada de la instancia |
| instance_public_dns | DNS público de la instancia |
| web_url | URL para acceder al servidor web |
| instance_arn | ARN de la instancia EC2 |

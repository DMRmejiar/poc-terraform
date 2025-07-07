# Terraform PoC AWS

� **Prueba de Concepto** que demuestra Infrastructure as Code (IaC) con Terraform y AWS.  
🔒 **Repositorio público** - Sin datos sensibles.

## ⚡ Inicio Rápido

### 1. Obtener credenciales AWS
1. **AWS Console** → IAM → Users → Create user
2. **Permissions**: Attach `AmazonEC2FullAccess`
3. **Security credentials** → Create access key → CLI
4. **Copiar**: `Access Key ID` (AKIA...) y `Secret Access Key`

### 2. Configurar y ejecutar
```bash
# Configurar AWS
aws configure
# Pegar Access Key ID, Secret Key, región: us-east-1

# Ejecutar proyecto
cd environments/dev
terraform init
terraform apply       # Escribir 'yes'

# Ver resultado
terraform output primary_web_url
terraform output secondary_web_url

# Limpiar
terraform destroy      # Escribir 'yes'
```

## 🏗️ Qué despliega

- **2 EC2 Instances**: t2.micro + Amazon Linux 2 (primary y secondary)
- **Security Group**: HTTP (80) 
- **Web Servers**: Apache con páginas demo personalizadas
- **Módulos**: Componentes reutilizables para web-server y security-group

## 🔄 CI/CD (Opcional)

Para deploy automático con GitHub Actions:
1. **Repository Secrets** → Add:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. **Push to main** → Deploy automático

### Eliminar recursos desde GitHub:
1. **Actions** → **Terraform Destroy**
2. **Run workflow** → Escribir `destroy` → **Run**

## 📁 Estructura

```
environments/dev/
├── main.tf           # Configuración base
├── instances.tf      # Instancias EC2 con módulos
├── networking.tf     # Security Groups
├── variables.tf      # Variables
├── outputs.tf        # IPs, URLs
├── versions.tf       # Providers
├── user-data-*.sh    # Scripts de configuración
└── terraform.tfvars  # Valores de variables

modules/
├── web-server/       # Módulo instancias EC2
└── security-group/   # Módulo firewall
```

## 🔒 Seguridad

- ✅ No hay credenciales en el código
- ✅ `.gitignore` protege archivos sensibles
- ✅ Variables por defecto seguras (t2.micro)

## ⚠️ Importante

- **Siempre ejecutar** `terraform destroy` al terminar
- **Monitorear** AWS Free Tier usage
- **Entorno de desarrollo** - evaluar para producción

---
**🎯 Objetivo**: Demostrar Terraform e IaC con implementación práctica

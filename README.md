# Terraform PoC AWS

📚 **Proyecto educativo** que demuestra Infrastructure as Code (IaC) con Terraform y AWS.  
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
terraform output web_url

# Limpiar
terraform destroy      # Escribir 'yes'
```

## 🏗️ Qué despliega

- **EC2 Instance**: t2.micro + Amazon Linux 2
- **Security Group**: SSH (22) + HTTP (80) 
- **Web Server**: Apache con página demo

**Costo**: $0 (AWS Free Tier - primeros 12 meses)

## 🔄 CI/CD (Opcional)

Para deploy automático con GitHub Actions:
1. **Repository Secrets** → Add:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. **Push to main** → Deploy automático

## 📁 Estructura

```
environments/dev/
├── main.tf           # Recursos AWS
├── variables.tf      # Variables
├── outputs.tf        # IPs, URLs
└── versions.tf       # Providers
```

## 🔒 Seguridad

- ✅ No hay credenciales en el código
- ✅ `.gitignore` protege archivos sensibles
- ✅ Variables por defecto seguras (t2.micro)

## ⚠️ Importante

- **Siempre ejecutar** `terraform destroy` al terminar
- **Monitorear** AWS Free Tier usage
- **Solo para aprendizaje** - no producción

---
**🎯 Objetivo**: Aprender Terraform e IaC sin complejidad innecesaria

# 🔒 Guía de Seguridad - PoC Terraform

## ⚠️ Importante

Este es un **repositorio público con fines educativos**. No acepta contribuciones externas.

## ❌ NUNCA incluir en el repositorio:

- **Credenciales de AWS** (Access Keys, Secret Keys)
- **Archivos terraform.tfvars** con datos reales
- **Claves privadas** (.pem, .ppk)
- **Estados de Terraform** (.tfstate)

## ✅ Configuración Segura:

### Para ejecutar localmente:
```bash
# Usar AWS CLI
aws configure

# O variables de entorno
export AWS_ACCESS_KEY_ID="tu-key"
export AWS_SECRET_ACCESS_KEY="tu-secret"
```

### Para GitHub Actions:
Configurar en `Settings → Secrets → Actions`:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## 🛡️ El repositorio ya incluye:

- ✅ `.gitignore` configurado correctamente
- ✅ `terraform.tfvars.example` como plantilla
- ✅ Documentación de seguridad
- ✅ Workflow básico para CI/CD

## 📞 Contacto

Este es un proyecto educativo. Para dudas sobre la implementación, contactar al autor del repositorio.

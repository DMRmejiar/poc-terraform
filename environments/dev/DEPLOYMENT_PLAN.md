# INSTRUCCIONES PARA EL SEGUNDO COMMIT

## Pasos a seguir después del primer deploy:

1. **Descommentar el servidor secundario** en instances.tf
2. **Descommentar los outputs** en outputs.tf  
3. **Restaurar el script** del servidor secundario
4. **Actualizar** el total_instances a 2
5. **Commit y push** para trigger del segundo deploy

## Comandos a ejecutar:

```bash
# Restaurar script del servidor secundario
mv user-data-secondary.sh.bak user-data-secondary.sh

# Descomentar código en instances.tf y outputs.tf
# (reemplazar comentarios por código activo)

# Commit del cambio incremental
git add .
git commit -m "feat: Agregar servidor secundario

- Implementación del segundo servidor web
- Configuración con diseño verde diferenciado  
- Balanceo de carga entre dos servidores
- Demostración de cambios incrementales en IaC"

# Push para deploy incremental
git push origin main
```

## Resultado esperado:
- ✅ 2 instancias EC2 (primary + secondary)
- ✅ 1 Security Group (compartido)
- ✅ 2 páginas web con diseños diferentes
- ✅ Deploy incremental sin afectar el servidor existente

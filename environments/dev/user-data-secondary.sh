#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Obtener datos de metadatos
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_TYPE=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Crear página HTML
cat > /var/www/html/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Terraform PoC - Secondary Server</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }
        .container { 
            background: rgba(255,255,255,0.1); 
            padding: 30px; 
            border-radius: 15px; 
            backdrop-filter: blur(10px);
            max-width: 600px;
            margin: 0 auto;
        }
        .info-item {
            background: rgba(255,255,255,0.1);
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .success { color: #4CAF50; font-weight: bold; }
        .secondary { color: #17a2b8; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Terraform PoC - SECONDARY Server</h1>
        <div class="success">✅ Infraestructura desplegada correctamente</div>
        <div class="secondary">🟢 SERVIDOR SECUNDARIO</div>
        
        <h3>📊 Información de la Instancia:</h3>
        <div class="info-item"><strong>Instance ID:</strong> INSTANCE_ID_PLACEHOLDER</div>
        <div class="info-item"><strong>Instance Type:</strong> INSTANCE_TYPE_PLACEHOLDER</div>
        <div class="info-item"><strong>Región:</strong> REGION_PLACEHOLDER</div>
        <div class="info-item"><strong>Zona de Disponibilidad:</strong> AZ_PLACEHOLDER</div>
        <div class="info-item"><strong>Entorno:</strong> ${environment}</div>
        
        <hr style="margin: 20px 0; border: 1px solid rgba(255,255,255,0.3);">
        <p>🎯 <strong>Terraform PoC</strong> - Infrastructure as Code</p>
        <small>Desplegado automáticamente con Terraform + GitHub Actions</small>
    </div>
</body>
</html>
HTML

# Reemplazar placeholders con valores reales
sed -i "s/INSTANCE_ID_PLACEHOLDER/$INSTANCE_ID/g" /var/www/html/index.html
sed -i "s/INSTANCE_TYPE_PLACEHOLDER/$INSTANCE_TYPE/g" /var/www/html/index.html
sed -i "s/REGION_PLACEHOLDER/$REGION/g" /var/www/html/index.html
sed -i "s/AZ_PLACEHOLDER/$AZ/g" /var/www/html/index.html

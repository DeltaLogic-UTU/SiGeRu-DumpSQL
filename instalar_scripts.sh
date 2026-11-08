#!/bin/bash
# Script de instalacion rapida para el examen (1 hora) - Delta Logic 2026
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar con sudo: sudo bash instalar_scripts.sh"
  exit 1
fi

DIR_ORIGEN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== 1. Creando estructura de directorios en /opt/sigeru ==="
mkdir -p /opt/sigeru/scripts
mkdir -p /opt/sigeru/aplicaciones
mkdir -p /opt/sigeru/docker/laravel
mkdir -p /opt/sigeru/docker/frontend
mkdir -p /opt/sigeru/backups/database
mkdir -p /opt/sigeru/backups/archivos

echo "=== 2. Copiando servidor.sh y los 7 sub-scripts ==="
cp "$DIR_ORIGEN/servidor.sh" /opt/sigeru/servidor.sh
cp "$DIR_ORIGEN/scripts/"*.sh /opt/sigeru/scripts/
cp "$DIR_ORIGEN/respaldo-remoto.sh" /opt/sigeru/respaldo-remoto.sh

chmod +x /opt/sigeru/servidor.sh /opt/sigeru/scripts/*.sh
chmod 700 /opt/sigeru/respaldo-remoto.sh

echo "=== 3. Copiando archivos Docker y base de datos SQL ==="
cp "$DIR_ORIGEN/docker/compose.yaml" /opt/sigeru/docker/compose.yaml
cp "$DIR_ORIGEN/docker/laravel/Dockerfile" /opt/sigeru/docker/laravel/Dockerfile
cp "$DIR_ORIGEN/docker/frontend/Dockerfile" /opt/sigeru/docker/frontend/Dockerfile
install -m 600 "$DIR_ORIGEN/sigeru_actualizada.sql" /opt/sigeru/backups/database/sigeru_actualizada.sql

if [[ ! -f /opt/sigeru/docker/.env ]]; then
  cat << 'EOF' > /opt/sigeru/docker/.env
MARIADB_ROOT_PASSWORD=root1234
MARIADB_PASSWORD=1234
EOF
  chmod 600 /opt/sigeru/docker/.env
fi

echo "=== 4. Verificando sintaxis de los scripts (Paso 2.9 del Manual) ==="
for archivo in /opt/sigeru/servidor.sh /opt/sigeru/scripts/*.sh /opt/sigeru/respaldo-remoto.sh; do
  echo "Verificando: $archivo"
  bash -n "$archivo" || echo "ERROR: $archivo"
done

echo "=== LISTO: Scripts, Dockerfiles y SQL instalados en /opt/sigeru ==="

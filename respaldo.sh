#!/bin/bash
mkdir -p respaldos
FECHA=$(date +"%Y%m%d_%H%M%S")
ARCHIVO_SQL="respaldos/sigeru_backup_${FECHA}.sql"
ARCHIVO_TAR="respaldos/respaldo_sigeru_${FECHA}.tar.gz"

echo "1. Exportando base de datos MySQL 8 desde el contenedor sigeru-db..."
docker exec sigeru-db mysqldump -u root -p1234 sigeru > "$ARCHIVO_SQL"

echo "2. Comprimiendo respaldo en formato .tar.gz..."
tar -czvf "$ARCHIVO_TAR" "$ARCHIVO_SQL" docker-compose.yml

rm -f "$ARCHIVO_SQL"

echo "=========================================="
echo "Respaldo generado exitosamente:"
ls -lh "$ARCHIVO_TAR"
echo "=========================================="
echo "Contenido del archivo .tar.gz (Verificacion de integridad):"
tar -ztvf "$ARCHIVO_TAR"

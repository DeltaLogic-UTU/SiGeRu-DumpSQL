#!/bin/bash
set -euo pipefail
umask 077

BASE="/opt/sigeru"
FECHA=$(date +%Y%m%d_%H%M%S)
DESTINO="respaldo@IP_RESPALDO"

mkdir -p "$BASE/backups/archivos"
mkdir -p "$BASE/backups/database"

chmod 700 "$BASE/backups"
chmod 700 "$BASE/backups/archivos"
chmod 700 "$BASE/backups/database"

echo "Respaldando archivos..."
tar -czf "$BASE/backups/archivos/sigeru_$FECHA.tar.gz" \
  -C "$BASE" \
  aplicaciones docker scripts servidor.sh

echo "Respaldando MariaDB..."
cd "$BASE/docker"
docker compose exec -T db sh -c \
  'mariadb-dump -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" --single-transaction --quick --triggers "$MARIADB_DATABASE"' \
  > "$BASE/backups/database/sigeru_$FECHA.sql"

echo "Enviando respaldos..."
rsync -az --chmod=F600,D700 \
  -e "ssh -i /root/.ssh/id_ed25519 -o BatchMode=yes" \
  "$BASE/backups/" \
  "$DESTINO:/srv/sigeru-backups/"

echo "Respaldo completado: $FECHA"

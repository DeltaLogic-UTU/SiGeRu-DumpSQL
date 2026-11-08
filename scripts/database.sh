#!/bin/bash
# SiGeRu - Modulo de gestion de bases de datos
BACKUPS="/opt/sigeru/backups/database"
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
mkdir -p "$BACKUPS"
chmod 700 "$BACKUPS"
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
base_valida() {
  [[ "$1" =~ ^[a-zA-Z0-9_]+$ ]]
}
while true; do
  clear
  echo "======================================"
  echo "         GESTION DE DATABASE"
  echo "======================================"
  echo "1. Consultar estado de MariaDB"
  echo "2. Listar bases de datos"
  echo "3. Crear base de datos"
  echo "4. Realizar backup SQL"
  echo "5. Listar backups SQL"
  echo "6. Restaurar backup SQL"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Estado de MariaDB:"
      systemctl status mariadb --no-pager 2>/dev/null || docker ps --filter "name=db"
      pausar
      ;;
    2)
      echo "Bases de datos disponibles:"
      mariadb -e "SHOW DATABASES;" 2>/dev/null || \
        (cd /opt/sigeru/docker && docker compose exec -T db sh -c 'mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" -e "SHOW DATABASES;"')
      pausar
      ;;
    3)
      read -rp "Nombre de la nueva base: " base
      if ! base_valida "$base"; then
        echo "Nombre de base de datos invalido."
      elif mariadb -e "CREATE DATABASE IF NOT EXISTS \`$base\`;" 2>/dev/null || \
           (cd /opt/sigeru/docker && docker compose exec -T db sh -c "mariadb -uroot -p\"\$MARIADB_ROOT_PASSWORD\" -e \"CREATE DATABASE IF NOT EXISTS \\\`$base\\\`;\""); then
        echo "Base de datos creada o existente."
      else
        echo "No se pudo crear la base de datos."
      fi
      pausar
      ;;
    4)
      read -rp "Base de datos a respaldar: " base
      if ! base_valida "$base"; then
        echo "Nombre invalido."
      else
        fecha=$(date +%Y%m%d_%H%M%S)
        archivo="$BACKUPS/${base}_${fecha}.sql"
        if (mariadb-dump --single-transaction --databases "$base" > "$archivo" 2>/dev/null) || \
           (cd /opt/sigeru/docker && docker compose exec -T db sh -c "mariadb-dump -uroot -p\"\$MARIADB_ROOT_PASSWORD\" --single-transaction --databases \"$base\"" > "$archivo"); then
          chmod 600 "$archivo"
          echo "Backup SQL creado:"
          echo "$archivo"
        else
          echo "Error al crear el backup."
          rm -f "$archivo"
        fi
      fi
      pausar
      ;;
    5)
      echo "Backups SQL disponibles:"
      ls -lh "$BACKUPS"/*.sql 2>/dev/null ||
        echo "No hay backups SQL."
      pausar
      ;;
    6)
      read -rp "Nombre del archivo SQL: " archivo
      if [[ "$archivo" != "$(basename "$archivo")" ||
            "$archivo" != *.sql ]]; then
        echo "Nombre de archivo invalido."
      elif [[ ! -f "$BACKUPS/$archivo" ]]; then
        echo "El backup no existe."
      else
        echo "ADVERTENCIA: La restauracion puede modificar"
        echo "o reemplazar datos de la base de datos."
        read -rp "Escriba RESTAURAR para confirmar: " confirmar
        if [[ "$confirmar" == "RESTAURAR" ]]; then
          if (mariadb < "$BACKUPS/$archivo" 2>/dev/null) || \
             (cd /opt/sigeru/docker && docker compose exec -T db sh -c 'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" "$MARIADB_DATABASE"' < "$BACKUPS/$archivo"); then
            echo "Restauracion SQL completada."
          else
            echo "Error durante la restauracion."
          fi
        else
          echo "Operacion cancelada."
        fi
      fi
      pausar
      ;;
    0)
      exit 0
      ;;
    *)
      echo "Opcion invalida."
      pausar
      ;;
  esac
done

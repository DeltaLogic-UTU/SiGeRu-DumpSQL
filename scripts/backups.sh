#!/bin/bash
# SiGeRu - Modulo de gestion de backups
ORIGEN="/opt/sigeru/aplicaciones"
DESTINO="/opt/sigeru/backups"
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
mkdir -p "$ORIGEN" "$DESTINO"
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
while true; do
  clear
  echo "======================================"
  echo "         GESTION DE BACKUPS"
  echo "======================================"
  echo "1. Crear backup"
  echo "2. Listar backups"
  echo "3. Verificar backup"
  echo "4. Restaurar backup"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      fecha=$(date +%Y%m%d_%H%M%S)
      archivo="sigeru_$fecha.tar.gz"
      if tar -czf "$DESTINO/$archivo" \
        -C /opt/sigeru aplicaciones; then
        echo "Backup creado correctamente:"
        echo "$DESTINO/$archivo"
      else
        echo "Error al crear el backup."
        rm -f "$DESTINO/$archivo"
      fi
      pausar
      ;;
    2)
      echo "Backups disponibles:"
      ls -lh "$DESTINO"/*.tar.gz 2>/dev/null ||
        echo "No hay backups disponibles."
      pausar
      ;;
    3)
      read -rp "Nombre del backup: " archivo
      if [[ "$archivo" != "$(basename "$archivo")" ||
            "$archivo" != *.tar.gz ]]; then
        echo "Nombre de archivo invalido."
      elif [[ ! -f "$DESTINO/$archivo" ]]; then
        echo "El backup no existe."
      elif tar -tzf "$DESTINO/$archivo" >/dev/null; then
        echo "El archivo comprimido se puede leer correctamente."
      else
        echo "El backup esta dañado o no se puede leer."
      fi
      pausar
      ;;
    4)
      read -rp "Nombre del backup: " archivo
      if [[ "$archivo" != "$(basename "$archivo")" ||
            "$archivo" != *.tar.gz ]]; then
        echo "Nombre de archivo invalido."
      elif [[ ! -f "$DESTINO/$archivo" ]]; then
        echo "El backup no existe."
      elif ! tar -tzf "$DESTINO/$archivo" >/dev/null; then
        echo "El backup no se puede leer."
      elif tar -tzf "$DESTINO/$archivo" |
           grep -Eq '(^/|(^|/)\.\.(/|$))'; then
        echo "El backup contiene rutas inseguras."
      elif tar -tvzf "$DESTINO/$archivo" |
           grep -Eq '^l|^h'; then
        echo "No se permite restaurar enlaces desde el backup."
      else
        echo "Se restaurara en una carpeta separada."
        read -rp "Confirmar restauracion (SI/no): " confirmar
        if [[ "$confirmar" == "SI" ]]; then
          restauracion="/opt/sigeru/restauraciones/$(date +%Y%m%d_%H%M%S)_$$"
          mkdir -p "$restauracion"
          if tar -xzf "$DESTINO/$archivo" \
            -C "$restauracion" \
            --no-same-owner; then
            echo "Restauracion completada en:"
            echo "$restauracion"
          else
            echo "Error al restaurar el backup."
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

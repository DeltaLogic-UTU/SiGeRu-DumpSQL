#!/bin/bash
# SiGeRu - Sistema de Administración del Servidor
# Proyecto DeltaLogic - UTU

SCRIPTS="/opt/sigeru/scripts"

# Verificar permisos de administrador
if [[ $EUID -ne 0 ]]; then
  echo "Ejecutar con: sudo /opt/sigeru/servidor.sh"
  exit 1
fi

while true; do
  clear
  echo "======================================"
  echo "        ADMINISTRACION SIGERU"
  echo "======================================"
  echo "1. Gestion de usuarios"
  echo "2. Gestion de grupos"
  echo "3. Gestion de backups"
  echo "4. Gestion de redes"
  echo "5. Gestion de bases de datos"
  echo "6. Gestion de firewall"
  echo "7. Gestion de logs"
  echo "0. Salir"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1) bash "$SCRIPTS/usuarios.sh" ;;
    2) bash "$SCRIPTS/grupos.sh" ;;
    3) bash "$SCRIPTS/backups.sh" ;;
    4) bash "$SCRIPTS/redes.sh" ;;
    5) bash "$SCRIPTS/database.sh" ;;
    6) bash "$SCRIPTS/firewall.sh" ;;
    7) bash "$SCRIPTS/logs.sh" ;;
    0)
      echo "Saliendo de SiGeRu..."
      exit 0
      ;;
    *)
      echo "Opcion no valida."
      ;;
  esac
  echo
  read -rp "Presione ENTER para continuar..."
done

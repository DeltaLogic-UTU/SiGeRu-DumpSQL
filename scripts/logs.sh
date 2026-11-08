#!/bin/bash
# SiGeRu - Modulo de gestion de logs
# Delta Logic - 2026
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
while true; do
  clear
  echo "======================================"
  echo "           GESTION DE LOGS"
  echo "======================================"
  echo "1. Ver ultimos registros del sistema"
  echo "2. Ver errores del sistema"
  echo "3. Ver logs de SSH"
  echo "4. Ver logs de MariaDB"
  echo "5. Ver registros del arranque actual"
  echo "6. Consultar espacio utilizado por logs"
  echo "7. Ver logs de contenedores Docker"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Ultimos 50 registros del sistema:"
      journalctl -n 50 --no-pager
      pausar
      ;;
    2)
      echo "Errores del arranque actual:"
      journalctl -b -p err -n 50 --no-pager
      pausar
      ;;
    3)
      echo "Ultimos registros de SSH:"
      journalctl -u sshd -n 50 --no-pager 2>/dev/null || journalctl -u ssh -n 50 --no-pager
      pausar
      ;;
    4)
      echo "Ultimos registros de MariaDB:"
      journalctl -u mariadb -n 50 --no-pager
      pausar
      ;;
    5)
      echo "Registros del arranque actual:"
      journalctl -b -n 100 --no-pager
      pausar
      ;;
    6)
      echo "Espacio utilizado por el journal:"
      journalctl --disk-usage
      echo
      echo "Espacio utilizado por /var/log:"
      du -sh /var/log
      pausar
      ;;
    7)
      echo "Contenedores Docker disponibles:"
      echo
      if ! command -v docker >/dev/null 2>&1; then
        echo "Docker no esta instalado."
      elif ! docker info >/dev/null 2>&1; then
        echo "Docker no esta funcionando o no se puede acceder al servicio."
      else
        if ! docker ps -a --format \
          "table {{.Names}}\t{{.Status}}"; then
          echo "No se pudo consultar los contenedores."
          pausar
          continue
        fi
        echo
        read -rp "Nombre del contenedor (ENTER para cancelar): " contenedor
        if [[ -z "$contenedor" ]]; then
          echo "Operacion cancelada."
        elif ! docker container inspect "$contenedor" >/dev/null 2>&1; then
          echo "El contenedor no existe."
        else
          echo
          echo "Ultimos 50 registros del contenedor:"
          echo
          if ! docker logs --tail 50 "$contenedor"; then
            echo "No se pudieron consultar los registros."
          fi
        fi
      fi
      pausar
      ;;
    0)
      echo "Volviendo al menu principal..."
      exit 0
      ;;
    *)
      echo "Opcion invalida."
      pausar
      ;;
  esac
done

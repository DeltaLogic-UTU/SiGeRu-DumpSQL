#!/bin/bash
# SiGeRu - Modulo de gestion de redes
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
  echo "          GESTION DE REDES"
  echo "======================================"
  echo "1. Ver interfaces de red"
  echo "2. Consultar direccion IP"
  echo "3. Consultar puerta de enlace"
  echo "4. Consultar servidores DNS"
  echo "5. Comprobar conexion a Internet"
  echo "6. Ver conexiones de NetworkManager"
  echo "7. Consultar estado de SSH"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Interfaces de red:"
      nmcli device status 2>/dev/null || ip link show
      pausar
      ;;
    2)
      echo "Direcciones IPv4:"
      ip -4 addr show
      pausar
      ;;
    3)
      echo "Tabla de rutas:"
      ip route
      pausar
      ;;
    4)
      echo "Servidores DNS:"
      nmcli -f GENERAL.DEVICE,IP4.DNS device show 2>/dev/null || resolvectl status 2>/dev/null || cat /etc/resolv.conf
      pausar
      ;;
    5)
      echo "Comprobando conectividad IP..."
      if ping -c 4 -W 2 8.8.8.8; then
        echo "Conectividad IP correcta."
      else
        echo "No se pudo alcanzar la direccion de prueba."
      fi
      echo
      echo "Comprobando resolucion DNS..."
      if getent ahostsv4 example.com; then
        echo "Resolucion DNS correcta."
      else
        echo "No se pudo resolver el dominio."
      fi
      pausar
      ;;
    6)
      echo "Conexiones configuradas:"
      nmcli connection show 2>/dev/null || networkctl list
      pausar
      ;;
    7)
      echo "Estado del servicio SSH:"
      systemctl is-active sshd 2>/dev/null || systemctl is-active ssh
      echo
      echo "Inicio automatico:"
      systemctl is-enabled sshd 2>/dev/null || systemctl is-enabled ssh
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

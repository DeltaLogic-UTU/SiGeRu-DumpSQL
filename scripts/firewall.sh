#!/bin/bash
# SiGeRu - Modulo de gestion de firewall
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
verificar_firewall() {
  if ! systemctl is-active --quiet firewalld; then
    echo "Firewalld no esta activo."
    return 1
  fi
  return 0
}
puerto_valido() {
  [[ "$1" =~ ^[0-9]+$ ]] &&
  (( 10#$1 >= 1 && 10#$1 <= 65535 ))
}
while true; do
  clear
  echo "======================================"
  echo "         GESTION DE FIREWALL"
  echo "======================================"
  echo "1. Consultar estado del firewall"
  echo "2. Ver reglas actuales"
  echo "3. Permitir servicio"
  echo "4. Quitar servicio permitido"
  echo "5. Abrir puerto"
  echo "6. Cerrar puerto"
  echo "7. Recargar firewall"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Estado de firewalld:"
      systemctl is-active firewalld
      echo "Inicio automatico:"
      systemctl is-enabled firewalld
      pausar
      ;;
    2)
      if verificar_firewall; then
        echo "Zona activa y reglas:"
        firewall-cmd --list-all
        echo
        echo "Reglas permanentes:"
        firewall-cmd --permanent --list-all
      fi
      pausar
      ;;
    3)
      if verificar_firewall; then
        read -rp "Servicio a permitir (http/https): " servicio
        case "$servicio" in
          http|https)
            if firewall-cmd --permanent \
               --add-service="$servicio" &&
               firewall-cmd --reload; then
              echo "Servicio permitido."
            else
              echo "No se pudo aplicar el cambio."
            fi
            ;;
          *)
            echo "Servicio no autorizado en este menu."
            ;;
        esac
      fi
      pausar
      ;;
    4)
      if verificar_firewall; then
        read -rp "Servicio a quitar (http/https): " servicio
        case "$servicio" in
          http|https)
            read -rp "Escriba SI para confirmar: " confirmar
            if [[ "$confirmar" == "SI" ]]; then
              if firewall-cmd --permanent \
                 --remove-service="$servicio" &&
                 firewall-cmd --reload; then
                echo "Servicio quitado."
              else
                echo "No se pudo aplicar el cambio."
              fi
            else
              echo "Operacion cancelada."
            fi
            ;;
          *)
            echo "No se permite quitar ese servicio."
            ;;
        esac
      fi
      pausar
      ;;
    5)
      if verificar_firewall; then
        read -rp "Puerto a abrir: " puerto
        read -rp "Protocolo (tcp/udp): " protocolo
        if ! puerto_valido "$puerto"; then
          echo "Puerto invalido."
        elif [[ "$protocolo" != "tcp" &&
                "$protocolo" != "udp" ]]; then
          echo "Protocolo invalido."
        elif firewall-cmd --permanent \
             --add-port="$puerto/$protocolo" &&
             firewall-cmd --reload; then
          echo "Puerto permitido."
        else
          echo "No se pudo abrir el puerto."
        fi
      fi
      pausar
      ;;
    6)
      if verificar_firewall; then
        read -rp "Puerto a cerrar: " puerto
        read -rp "Protocolo (tcp/udp): " protocolo
        if ! puerto_valido "$puerto"; then
          echo "Puerto invalido."
        elif [[ "$protocolo" != "tcp" &&
                "$protocolo" != "udp" ]]; then
          echo "Protocolo invalido."
        elif [[ "$puerto" == "22" &&
                "$protocolo" == "tcp" ]]; then
          echo "No se permite cerrar SSH desde este menu."
        else
          read -rp "Confirmar cierre (SI/no): " confirmar
          if [[ "$confirmar" == "SI" ]]; then
            if firewall-cmd --permanent \
               --remove-port="$puerto/$protocolo" &&
               firewall-cmd --reload; then
              echo "Regla de puerto eliminada."
            else
              echo "No se pudo aplicar el cambio."
            fi
          else
            echo "Operacion cancelada."
          fi
        fi
      fi
      pausar
      ;;
    7)
      if verificar_firewall; then
        if firewall-cmd --reload; then
          echo "Firewall recargado correctamente."
        else
          echo "Error al recargar firewall."
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

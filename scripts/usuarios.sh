#!/bin/bash
# SiGeRu - Modulo de gestion de usuarios
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
usuario_valido() {
  [[ "$1" =~ ^[a-z_][a-z0-9_-]*$ ]] &&
  [[ ${#1} -le 32 ]]
}
while true; do
  clear
  echo "======================================"
  echo "         GESTION DE USUARIOS"
  echo "======================================"
  echo "1. Listar usuarios"
  echo "2. Crear usuario"
  echo "3. Cambiar contraseña"
  echo "4. Bloquear usuario"
  echo "5. Desbloquear usuario"
  echo "6. Eliminar usuario"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Usuarios locales:"
      getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {
        print "Usuario:", $1, "| UID:", $3
      }'
      pausar
      ;;
    2)
      read -rp "Nombre del nuevo usuario: " usuario
      if ! usuario_valido "$usuario"; then
        echo "Nombre de usuario invalido."
      elif getent passwd "$usuario" >/dev/null; then
        echo "El usuario ya existe."
      elif useradd -m "$usuario"; then
        echo "Usuario creado correctamente."
        passwd "$usuario"
      else
        echo "No se pudo crear el usuario."
      fi
      pausar
      ;;
    3)
      read -rp "Usuario: " usuario
      if id "$usuario" &>/dev/null; then
        passwd "$usuario"
      else
        echo "El usuario no existe."
      fi
      pausar
      ;;
    4)
      read -rp "Usuario a bloquear: " usuario
      if [[ "$usuario" == "root" || "$usuario" == "soporte" ]]; then
        echo "No se permite bloquear usuarios administrativos protegidos."
      elif id "$usuario" &>/dev/null; then
        passwd -l "$usuario"
        echo "Contraseña del usuario bloqueada."
      else
        echo "El usuario no existe."
      fi
      pausar
      ;;
    5)
      read -rp "Usuario a desbloquear: " usuario
      if id "$usuario" &>/dev/null; then
        passwd -u "$usuario"
      else
        echo "El usuario no existe."
      fi
      pausar
      ;;
    6)
      read -rp "Usuario a eliminar: " usuario
      if [[ "$usuario" == "root" || "$usuario" == "soporte" ]]; then
        echo "No se permite eliminar usuarios administrativos protegidos."
      elif ! id "$usuario" &>/dev/null; then
        echo "El usuario no existe."
      elif [[ $(id -u "$usuario") -lt 1000 ]]; then
        echo "No se permite eliminar usuarios del sistema."
      else
        read -rp "Confirmar eliminacion de $usuario (SI/no): " confirmar
        if [[ "$confirmar" == "SI" ]]; then
          if userdel "$usuario"; then
            echo "Usuario eliminado."
            echo "Su directorio personal no fue eliminado."
          else
            echo "No se pudo eliminar el usuario."
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

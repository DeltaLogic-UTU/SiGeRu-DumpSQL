#!/bin/bash
# SiGeRu - Modulo de gestion de grupos
if [[ $EUID -ne 0 ]]; then
  echo "Este modulo requiere permisos de administrador."
  exit 1
fi
pausar() {
  echo
  read -rp "Presione ENTER para continuar..."
}
grupo_valido() {
  [[ "$1" =~ ^[a-z_][a-z0-9_-]*$ ]] &&
  [[ ${#1} -le 32 ]]
}
grupo_protegido() {
  local grupo="$1"
  local gid
  gid=$(getent group "$grupo" | cut -d: -f3)
  [[ "$grupo" == "wheel" ||
     "$grupo" == "root" ||
     "$grupo" == "soporte" ||
     "$gid" -lt 1000 ]]
}
while true; do
  clear
  echo "======================================"
  echo "          GESTION DE GRUPOS"
  echo "======================================"
  echo "1. Listar grupos"
  echo "2. Crear grupo"
  echo "3. Ver integrantes de un grupo"
  echo "4. Agregar usuario a un grupo"
  echo "5. Quitar usuario de un grupo"
  echo "6. Eliminar grupo"
  echo "0. Volver al menu principal"
  echo "======================================"
  read -rp "Seleccione una opcion: " opcion
  case "$opcion" in
    1)
      echo "Grupos locales:"
      getent group | awk -F: '
      $3 >= 1000 && $3 < 65534 {
        print "Grupo:", $1, "| GID:", $3
      }'
      pausar
      ;;
    2)
      read -rp "Nombre del nuevo grupo: " grupo
      if ! grupo_valido "$grupo"; then
        echo "Nombre de grupo invalido."
      elif getent group "$grupo" >/dev/null; then
        echo "El grupo ya existe."
      elif groupadd "$grupo"; then
        echo "Grupo creado correctamente."
      else
        echo "No se pudo crear el grupo."
      fi
      pausar
      ;;
    3)
      read -rp "Nombre del grupo: " grupo
      if getent group "$grupo" >/dev/null; then
        echo
        echo "Informacion del grupo:"
        getent group "$grupo"
        echo
        echo "Usuarios que pertenecen al grupo:"
        getent passwd | cut -d: -f1 |
        while read -r usuario; do
          if id -nG "$usuario" 2>/dev/null |
             tr ' ' '\n' | grep -Fxq "$grupo"; then
            echo "- $usuario"
          fi
        done
      else
        echo "El grupo no existe."
      fi
      pausar
      ;;
    4)
      read -rp "Usuario: " usuario
      read -rp "Grupo: " grupo
      if ! id "$usuario" &>/dev/null; then
        echo "El usuario no existe."
      elif ! getent group "$grupo" >/dev/null; then
        echo "El grupo no existe."
      elif grupo_protegido "$grupo"; then
        echo "No se permite modificar este grupo protegido."
      elif usermod -aG "$grupo" "$usuario"; then
        echo "Usuario agregado correctamente."
      else
        echo "No se pudo agregar el usuario."
      fi
      pausar
      ;;
    5)
      read -rp "Usuario: " usuario
      read -rp "Grupo: " grupo
      if ! id "$usuario" &>/dev/null; then
        echo "El usuario no existe."
      elif ! getent group "$grupo" >/dev/null; then
        echo "El grupo no existe."
      elif grupo_protegido "$grupo"; then
        echo "No se permite modificar este grupo protegido."
      elif [[ "$(id -gn "$usuario")" == "$grupo" ]]; then
        echo "No se puede quitar el grupo principal del usuario."
      elif gpasswd -d "$usuario" "$grupo"; then
        echo "Usuario quitado del grupo."
      else
        echo "No se pudo quitar el usuario."
      fi
      pausar
      ;;
    6)
      read -rp "Grupo a eliminar: " grupo
      if ! getent group "$grupo" >/dev/null; then
        echo "El grupo no existe."
      elif grupo_protegido "$grupo"; then
        echo "No se permite eliminar grupos protegidos."
      else
        read -rp "Confirmar eliminacion de $grupo (SI/no): " confirmar
        if [[ "$confirmar" == "SI" ]]; then
          if groupdel "$grupo"; then
            echo "Grupo eliminado correctamente."
          else
            echo "No se pudo eliminar el grupo."
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

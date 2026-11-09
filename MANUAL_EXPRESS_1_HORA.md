# 🚀 MANUAL EXPRESS DE INSTALACIÓN (1 HORA) — DELTA LOGIC (SiGeRu)

Esta guía resume las **46 páginas del Manual de Instalación** en pasos rápidos y exactos para completar toda la prueba en **menos de 20 minutos**.

---

## PASO 0: Reenvío de Puertos en VirtualBox y Conexión SSH

1. **En VirtualBox** (`Máquina -> Configuración -> Red -> Adaptador 1 (NAT) -> Avanzadas -> Reenvío de puertos`), verificar que estén estas reglas:
   - `SSH`: TCP | Anfitrión `2222` -> Invitado `22`
   - `Web-8080`: TCP | Anfitrión `8080` -> Invitado `8080`
   - `Web`: TCP | Anfitrión `80` -> Invitado `80`
   - `API-Usuarios`: TCP | Anfitrión `8000` -> Invitado `8000`
   - `API-Gestion`: TCP | Anfitrión `8001` -> Invitado `8001`
   - `API-Recoleccion`: TCP | Anfitrión `8002` -> Invitado `8002`

2. **Entrar por SSH desde PowerShell (Windows)**:
   - Si usás **NAT con reenvío de puertos** (2222 -> 22):
     ```powershell
     ssh -p 2222 sigeru@127.0.0.1
     ```
   - Si usás **Adaptador Puente / Red NAT** con IP directa:
     ```powershell
     ssh sigeru@IP_SERVIDOR
     ```

---

## PASO 1: Verificar / Instalar Git, Docker, Firewalld y Cron (3 min)

### En Ubuntu Server:
```bash
sudo apt update && sudo apt install -y git curl rsync cron firewalld
curl -fsSL https://get.docker.com | sudo sh
sudo systemctl enable --now docker ssh cron firewalld
```

### En AlmaLinux 9:
```bash
sudo dnf install -y git curl rsync cronie openssh-server openssh-clients firewalld
curl -fsSL https://get.docker.com | sudo sh
sudo systemctl enable --now docker sshd crond firewalld
```

**Verificar versiones (3.1 del Manual):**
```bash
sudo systemctl is-active docker
sudo docker --version
sudo docker compose version
```

---

## PASO 2: Instalar los 7 Scripts + Estructura `/opt/sigeru` + Archivos Docker (1 min)

Clonamos el repositorio `SiGeRu-DumpSQL` que ya tiene **el menú principal (`servidor.sh`), los 7 sub-scripts (`scripts/*.sh`), el script de respaldo SSH (`respaldo-remoto.sh`), los `Dockerfile`, `compose.yaml` y la base `sigeru_actualizada.sql`**:

```bash
git clone https://github.com/DeltaLogic-UTU/SiGeRu-DumpSQL.git /tmp/dump
sudo bash /tmp/dump/instalar_scripts.sh
```

**Verificar que los 7 scripts funcionan:**
```bash
for archivo in /opt/sigeru/servidor.sh /opt/sigeru/scripts/*.sh; do
  echo "Verificando: $archivo"
  sudo bash -n "$archivo" || echo "ERROR: $archivo"
done
```
*(Para mostrar el menú al tribunal: `sudo /opt/sigeru/servidor.sh`)*

---

## PASO 3: Clonar las 4 Aplicaciones y Configurar `.env` (2 min)

```bash
cd /opt/sigeru/aplicaciones

sudo git clone https://github.com/DeltaLogic-UTU/SiGeRu-Website.git
sudo git clone https://github.com/DeltaLogic-UTU/SiGeRu-API-Usuarios.git
sudo git clone https://github.com/DeltaLogic-UTU/SiGeRu-API-Gestion.git
sudo git clone https://github.com/DeltaLogic-UTU/SiGeRU-API-Recoleccion.git
```

**Crear y proteger los `.env` de las 3 APIs (ya traen `DB_PASSWORD=1234`, `JWT_SECRET` y el correo SMTP de Gmail configurado):**
```bash
sudo cp /opt/sigeru/aplicaciones/SiGeRu-API-Usuarios/.env.example /opt/sigeru/aplicaciones/SiGeRu-API-Usuarios/.env
sudo cp /opt/sigeru/aplicaciones/SiGeRu-API-Gestion/.env.example /opt/sigeru/aplicaciones/SiGeRu-API-Gestion/.env
sudo cp /opt/sigeru/aplicaciones/SiGeRU-API-Recoleccion/.env.example /opt/sigeru/aplicaciones/SiGeRU-API-Recoleccion/.env

sudo sed -i 's/DB_USERNAME=root/DB_USERNAME=sigeru_app/' /opt/sigeru/aplicaciones/SiGeRu-API-*/.env
sudo chmod 600 /opt/sigeru/aplicaciones/SiGeRu-API-*/.env
```
*(Nota: Si el directorio de Recolección se clonó con `RU` mayúscula `SiGeRU-API-Recoleccion`, creamos un enlace simbólico para que coincida con `SiGeRu-API-Recoleccion` del `compose.yaml`):*
```bash
sudo ln -sfn /opt/sigeru/aplicaciones/SiGeRU-API-Recoleccion /opt/sigeru/aplicaciones/SiGeRu-API-Recoleccion
sudo chmod 600 /opt/sigeru/aplicaciones/SiGeRU-API-Recoleccion/.env
```

---

## PASO 4: Construir Contenedores, Iniciar MariaDB e Importar SQL (5 min)

```bash
cd /opt/sigeru/docker

# 1. Validar configuración de Docker Compose (3.10)
sudo docker compose config --quiet

# 2. Construir imágenes (3.11)
sudo docker compose build

# 3. Iniciar MariaDB y esperar a que esté healthy (3.14)
sudo docker compose up -d db
sudo docker compose ps
```

*(Esperar 10 segundos a que `db` diga `(healthy)` en `sudo docker compose ps`)*

```bash
# 4. Copiar e importar la base de datos (3.15)
sudo docker compose cp /opt/sigeru/backups/database/sigeru_actualizada.sql db:/tmp/sigeru_actualizada.sql

sudo docker compose exec -T db sh -c 'mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE" < /tmp/sigeru_actualizada.sql'

# 5. Comprobar que están las 23 tablas
sudo docker compose exec -T db sh -c 'mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE" -e "SHOW TABLES;"'

# 6. Iniciar todas las aplicaciones (3.16)
sudo docker compose up -d
sudo docker compose ps
```

---

## PASO 5: Configurar Firewall y Verificar Web/APIs (1 min)

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=8000-8002/tcp
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --reload
sudo systemctl restart docker
sudo firewall-cmd --list-ports
```

**Probar respuesta local (3.19):**
```bash
curl -I http://127.0.0.1:8080/landing-page/index.html
curl http://127.0.0.1:8001/api/health
```

---

## PASO 6: Configuración SSH y Servidor de Respaldo (Sección 4 del Manual)

### A) En el Servidor de Respaldo (`sigeru-respaldo` — 2da VM)
*(O en la misma VM con `IP_RESPALDO=127.0.0.1` si hacen prueba local de respaldo)*

```bash
# 4.1 Nombre del host y ver IP
sudo hostnamectl set-hostname sigeru-respaldo
hostname -I

# 4.3 Crear usuario 'respaldo' y carpeta protegida
sudo useradd -m -s /bin/bash respaldo
sudo passwd respaldo
sudo mkdir -p /srv/sigeru-backups
sudo chown respaldo:respaldo /srv/sigeru-backups
sudo chmod 700 /srv/sigeru-backups
```

### B) En el Servidor Principal (Configurar Clave SSH sin contraseña + Cron)

Reemplazá `IP_RESPALDO` por la IP del servidor secundario (o `127.0.0.1` si probás en el mismo servidor):

```bash
# 4.5 Generar clave SSH ed25519 para root y copiarla al servidor de respaldo
sudo mkdir -p /root/.ssh
sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ""
sudo ssh-copy-id -i /root/.ssh/id_ed25519.pub respaldo@IP_RESPALDO

# Comprobar que entra sin pedir contraseña:
sudo ssh -i /root/.ssh/id_ed25519 respaldo@IP_RESPALDO "ls -ld /srv/sigeru-backups"

# 4.6 Configurar la IP en /opt/sigeru/respaldo-remoto.sh
sudo sed -i 's/IP_RESPALDO/127.0.0.1/g' /opt/sigeru/respaldo-remoto.sh   # <-- Cambiar 127.0.0.1 por la IP_RESPALDO real

# 4.7 Ejecutar prueba manual de respaldo
sudo bash /opt/sigeru/respaldo-remoto.sh

# Verificar archivos creados localmente y en el destino:
sudo ls -lh /opt/sigeru/backups/archivos
sudo ls -lh /opt/sigeru/backups/database
sudo ls -lh /srv/sigeru-backups/archivos
sudo ls -lh /srv/sigeru-backups/database

# 4.8 Programar tarea automática en Cron (todos los días 02:00 AM)
(sudo crontab -l 2>/dev/null; echo "0 2 * * * /opt/sigeru/respaldo-remoto.sh >> /var/log/sigeru-respaldo.log 2>&1") | sudo crontab -
sudo crontab -l
```

---

## PASO 7: Comandos de Demostración Final para el Tribunal (Sección 5)

```bash
# 1. Mostrar contenedores corriendo y saludables
cd /opt/sigeru/docker && sudo docker compose ps

# 2. Abrir menú de administración con los 7 módulos
sudo bash /opt/sigeru/servidor.sh

# 3. Mostrar respaldos generados y tarea Cron
sudo ls -lh /opt/sigeru/backups/archivos
sudo ls -lh /opt/sigeru/backups/database
sudo crontab -l
```

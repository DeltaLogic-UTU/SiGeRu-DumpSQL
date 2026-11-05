# SiGeRu — Base de Datos

**Sistema de Gestión de Residuos Urbanos | Delta-Logic — 2026**

Este repositorio contiene el respaldo SQL de la base de datos utilizada por **SiGeRu**, un sistema web para administrar y supervisar la gestión de residuos urbanos.

La base de datos centraliza la información de los usuarios, recursos operativos, recorridos, reclamos, incidencias y demás funcionalidades del sistema.

## 1. Contenido del repositorio

Archivo principal:

` s i g e r u _ a c t u a l i z a d a . s q l `

**Nombre real del archivo:** `sigeru_actualizada.sql`

El respaldo fue generado desde MySQL/MariaDB e incluye la estructura y los datos presentes al momento de la exportación.

El archivo reemplaza al anterior `SQL_SiGeRU.sql`.

## 2. Tecnologías utilizadas

- **MariaDB/MySQL:** sistema gestor de base de datos.
- **SQL:** definición y manipulación de datos.
- **Laravel:** integración con las APIs del proyecto.
- **XAMPP:** entorno local de desarrollo.

## 3. Información almacenada

La base de datos contempla:

- **Usuarios y roles:** cuentas, perfiles y autenticación.
- **Solicitudes de acceso:** registro y aprobación de usuarios.
- **Recuperación de contraseñas:** solicitudes y códigos temporales.
- **Camiones:** vehículos, choferes, ubicaciones y asignaciones.
- **Cuadrillas:** integrantes, responsables, circuitos y tareas.
- **Contenedores:** características, ubicación, estados e historial.
- **Circuitos y rutas:** organización y planificación de recorridos.
- **Despachos:** rutas asignadas a camiones y choferes.
- **Recolecciones:** recorridos, progreso y contenedores procesados.
- **Reclamos:** reportes realizados por vecinos.
- **Incidencias:** problemas relacionados con contenedores y camiones.
- **Instalaciones:** depósitos, centros de acopio y vertederos.
- **Inventario:** insumos asociados a instalaciones.
- **Estadísticas:** información utilizada para calcular indicadores del sistema.
- **Notificaciones:** cambios de estado de reclamos.
- **Mensajería interna:** comunicaciones entre Administración y personal operativo.

Las tablas se relacionan mediante identificadores y claves para permitir la integración de los distintos módulos.

## 4. Importar la base de datos

### Requisitos

- MySQL o MariaDB.
- XAMPP o un entorno equivalente.
- Acceso a la consola de MySQL.

### Paso 1. Iniciar MySQL

Abrir XAMPP e iniciar el servicio MySQL.

### Paso 2. Descargar el repositorio

```powershell
git clone https://github.com/DeltaLogic-UTU/SiGeRu-DumpSQL.git
cd SiGeRu-DumpSQL
```

### Paso 3. Importar el respaldo

Desde la terminal, con MySQL disponible en el PATH:

```powershell
mysql -u root < sigeru_actualizada.sql
```

Este comando funciona cuando el respaldo incluye la creación y selección de la base de datos.

Si tu instalación utiliza contraseña, agregá `-p` después de `root`.

**Importante:** la importación puede reemplazar tablas o registros existentes. Se recomienda realizar una copia de seguridad antes de importar.

## 5. Conexión desde Laravel

Las APIs utilizan la base compartida:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sigeru
DB_USERNAME=root
DB_PASSWORD=
```

Esta configuración corresponde a un entorno local de XAMPP con el usuario `root` sin contraseña.

Cada instalación debe configurar sus propias credenciales en el archivo `.env`.

## 6. Integración con SiGeRu

La base de datos es utilizada por los siguientes repositorios:

- [SiGeRu-Website](https://github.com/DeltaLogic-UTU/SiGeRu-Website) — Interfaz web.
- [SiGeRu-API-Usuarios](https://github.com/DeltaLogic-UTU/SiGeRu-API-Usuarios) — Autenticación y usuarios.
- [SiGeRu-API-Gestion](https://github.com/DeltaLogic-UTU/SiGeRu-API-Gestion) — Administración operativa.
- [SiGeRu-API-Recoleccion](https://github.com/DeltaLogic-UTU/SiGeRu-API-Recoleccion) — Recolecciones y recorridos.

Las tres APIs Laravel utilizan la información almacenada para consultar y actualizar los diferentes módulos del sistema.

---

## Proyecto académico 2026

**SiGeRu — Sistema de Gestión de Residuos Urbanos**

Desarrollado por **Delta-Logic**

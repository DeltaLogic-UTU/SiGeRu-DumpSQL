CREATE DATABASE IF NOT EXISTS sigeru
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE sigeru;

-- 1. Roles y Usuarios

CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Datos (
    id_datos INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    documento VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    email VARCHAR(150) NOT NULL UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Rec_Password (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',
    codigo VARCHAR(100) NOT NULL,
    fecha_solicitud DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

-- 2. Solicitudes enviadas desde registro

CREATE TABLE Solicitudes_Acceso (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento VARCHAR(30) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password VARCHAR(255) NOT NULL,
    perfil VARCHAR(50) NOT NULL,
    licencia VARCHAR(50),
    motivo TEXT NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',
    fecha_solicitud DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion DATETIME,
    id_supervisor_resuelve INT,
    FOREIGN KEY (id_supervisor_resuelve) REFERENCES Usuarios(id_usuario)
);

-- 3. Perfiles y tipos de usuario


CREATE TABLE Supervisor (
    id_usuario INT PRIMARY KEY,
    fecha_aprobacion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Chofer (
    id_usuario INT PRIMARY KEY,
    fecha_aprobacion DATETIME,
    licencia VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Barrendero (
    id_usuario INT PRIMARY KEY,
    fecha_aprobacion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Operario (
    id_usuario INT PRIMARY KEY,
    fecha_aprobacion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Vecino (
    id_usuario INT PRIMARY KEY,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Admin_Backoffice (
    id_usuario INT PRIMARY KEY,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

-- 4. Ubicaciones

CREATE TABLE Ubicacion (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(150),
    esquina_1 VARCHAR(150),
    esquina_2 VARCHAR(150),
    municipio VARCHAR(100),
    barrio VARCHAR(100),
    descripcion TEXT,
    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8)
);

-- 5. Cuadrillas y Personal

CREATE TABLE Cuadrilla (
    id_cuadrilla VARCHAR(20) PRIMARY KEY,
    id_responsable INT,
    turno VARCHAR(30),
    estado VARCHAR(30),
    ubicacion_actual VARCHAR(100),
    FOREIGN KEY (id_responsable) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Cuadrilla_Integrantes (
    id_cuadrilla VARCHAR(20),
    id_usuario INT,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME,
    PRIMARY KEY (id_cuadrilla, id_usuario, fecha_asignacion),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla)
        ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE CASCADE
);

-- 6. Rutas y Circuitos

CREATE TABLE Rutas (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    circuito VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(100),
    municipio VARCHAR(100) NOT NULL,
    zona VARCHAR(100),
    descripcion TEXT,
    frecuencia VARCHAR(50),
    estado VARCHAR(30) NOT NULL DEFAULT 'Asignada'
);

-- 7. Historial de circuitos asignados a cuadrillas

CREATE TABLE Cuadrilla_Rutas (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_cuadrilla VARCHAR(20) NOT NULL,
    id_ruta INT NOT NULL,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME,
    estado VARCHAR(30) NOT NULL DEFAULT 'Asignada',
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta)
);

-- 8. Camiones

CREATE TABLE Camiones (
    id_camion INT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    tipo VARCHAR(30) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    chasis VARCHAR(100) UNIQUE,
    km_total DECIMAL(12,2) DEFAULT 0,
    ult_carga_combustible DATETIME,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    km_en_turno DECIMAL(10,2) DEFAULT 0,
    tiempo_activo TIME DEFAULT '00:00:00',
    gps VARCHAR(255),
    capacidad_kg DECIMAL(10,2),
    peso_recolectado_kg DECIMAL(10,2) DEFAULT 0,
    contenedores_asignados INT DEFAULT 0,
    contenedores_recolectados INT DEFAULT 0,
    turno VARCHAR(30),
    id_chofer INT,
    id_cuadrilla VARCHAR(20),
    id_ruta INT,
    FOREIGN KEY (id_chofer) REFERENCES Chofer(id_usuario),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta)
);

-- 9. Guarda cambios de asignaciones del camión

CREATE TABLE Camion_Asignaciones (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_camion INT NOT NULL,
    id_chofer INT,
    id_cuadrilla VARCHAR(20),
    id_ruta INT,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME,
    estado VARCHAR(30),
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
        ON DELETE CASCADE,
    FOREIGN KEY (id_chofer) REFERENCES Chofer(id_usuario),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta)
);

-- 10. Contenedores

CREATE TABLE Contenedores (
    id_contenedor INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    modelo VARCHAR(100),
    tipo VARCHAR(30) NOT NULL,
    capacidad DECIMAL(10,2),
    estado VARCHAR(30) NOT NULL,
    dias_sin_recoleccion INT DEFAULT 0,
    id_ubicacion INT,
    circuito VARCHAR(30),
    ultimo_registro DATE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Historial_Contenedores (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_contenedor INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_anterior VARCHAR(30),
    estado_nuevo VARCHAR(30),
    id_ubicacion_anterior INT,
    id_ubicacion_nueva INT,
    motivo VARCHAR(255),
    FOREIGN KEY (id_contenedor) REFERENCES Contenedores(id_contenedor)
        ON DELETE CASCADE,
    FOREIGN KEY (id_ubicacion_anterior) REFERENCES Ubicacion(id_ubicacion),
    FOREIGN KEY (id_ubicacion_nueva) REFERENCES Ubicacion(id_ubicacion)
);

-- 11. Incidencias

CREATE TABLE Incidencias (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    tipo_recurso VARCHAR(30) NOT NULL,
    id_camion INT,
    id_contenedor INT,
    tipo VARCHAR(100) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Abierta',
    fecha_reporte DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion DATETIME,
    descripcion TEXT,
    responsable VARCHAR(150),
    resolucion TEXT,
    id_cuadrilla VARCHAR(20),
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion),
    FOREIGN KEY (id_contenedor) REFERENCES Contenedores(id_contenedor),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla)
);

-- 12. Reclamos Vecinos

CREATE TABLE Reclamos (
    id_reclamo VARCHAR(30) PRIMARY KEY,
    id_usuario INT,
    reclamante VARCHAR(200),
    contacto VARCHAR(100),
    categoria VARCHAR(100) NOT NULL,
    tipo VARCHAR(100),
    zona VARCHAR(150),
    referencia VARCHAR(200),
    ubicacion VARCHAR(255),
    descripcion TEXT,
    foto VARCHAR(255),
    estado VARCHAR(30) NOT NULL DEFAULT 'sin_asignar',
    id_cuadrilla VARCHAR(20),
    id_contenedor INT,
    fecha_reporte DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla),
    FOREIGN KEY (id_contenedor) REFERENCES Contenedores(id_contenedor)
);


-- 13. Instalaciones

CREATE TABLE Instalaciones (
    id_instalacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidad DECIMAL(10,2),
    capacidad_actual VARCHAR(50),
    estado VARCHAR(30) NOT NULL,
    id_ubicacion INT,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Instalacion_Operario (
    id_usuario INT,
    id_instalacion INT,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_instalacion),
    FOREIGN KEY (id_usuario) REFERENCES Operario(id_usuario),
    FOREIGN KEY (id_instalacion) REFERENCES Instalaciones(id_instalacion)
        ON DELETE CASCADE
);

-- 14. Inventario

CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_instalacion INT NOT NULL,
    nombre_item VARCHAR(100) NOT NULL,
    estado VARCHAR(30),
    tipo VARCHAR(50),
    cantidad INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_instalacion) REFERENCES Instalaciones(id_instalacion)
        ON DELETE CASCADE
);

-- 15. Tareas

CREATE TABLE Tareas (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',
    fecha_asignacion DATETIME,
    fecha_finalizacion DATETIME,
    id_cuadrilla VARCHAR(20),
    id_supervisor INT,
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla),
    FOREIGN KEY (id_supervisor) REFERENCES Supervisor(id_usuario)
);

-- 16. Recolecciones

CREATE TABLE Recolecciones (
    id_recoleccion INT AUTO_INCREMENT PRIMARY KEY,
    id_camion INT NOT NULL,
    id_ruta INT,
    id_cuadrilla VARCHAR(20),
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    volumen_recolectado DECIMAL(10,2),
    peso_recolectado_kg DECIMAL(10,2),
    contenedores_recolectados INT DEFAULT 0,
    estado VARCHAR(30),
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta),
    FOREIGN KEY (id_cuadrilla) REFERENCES Cuadrilla(id_cuadrilla)
);

CREATE TABLE Recoleccion_Contenedor (
    id_recoleccion INT,
    id_contenedor INT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_recoleccion, id_contenedor),
    FOREIGN KEY (id_recoleccion) REFERENCES Recolecciones(id_recoleccion)
        ON DELETE CASCADE,
    FOREIGN KEY (id_contenedor) REFERENCES Contenedores(id_contenedor)
);

-- 17. Mantenimiento de camiones

CREATE TABLE Mantenimientos (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_camion INT NOT NULL,
    estado VARCHAR(30),
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    descripcion TEXT,
    tipo VARCHAR(50),
    costo DECIMAL(10,2),
    responsable VARCHAR(150),
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
        ON DELETE CASCADE
);

-- 18. Insertar roles básicos de la página

INSERT INTO Rol (nombre, descripcion) VALUES
('administrador', 'Administración y supervisión general del sistema'),
('supervisor', 'Supervisión de operaciones'),
('chofer', 'Conducción de camiones de recolección'),
('cuadrilla', 'Personal de recolección y limpieza'),
('barrendero', 'Personal de limpieza urbana'),
('operario', 'Operación de instalaciones'),
('vecino', 'Usuario vecino del sistema');

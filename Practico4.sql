-- Tabla para los tipos de activos (Computadoras, Impresoras, Video Vigilancia, Control de Acceso)
CREATE TABLE Tipo_Activo (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla principal de activos que incluye todos los tipos
CREATE TABLE Activos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255), -- Nombre del activo
    tipo_activo_id INT NOT NULL, -- Referencia al tipo de activo
    descripcion TEXT,
    fecha_adquisicion DATE NOT NULL,
    estado VARCHAR(50),
    ubicacion VARCHAR(255),
    usuario_asignado VARCHAR(255),
    numero_serie VARCHAR(100),
    proveedor VARCHAR(255),
    valor_estimado DECIMAL(10, 2),
    fecha_ultimo_mantenimiento DATE,
    asignacion_proyecto_departamento VARCHAR(255),
    direccion_ip VARCHAR(15), -- Dirección IP (solo para Estaciones de trabajo)
    direccion_mac VARCHAR(17) -- Dirección MAC (solo para Estaciones de trabajo)
);

-- Crear tabla de Configuración de Hardware
CREATE TABLE ConfiguracionHardware (
    id INT PRIMARY KEY,
    activo_id INT UNIQUE,
    cpu_marca VARCHAR(50),
    cpu_cores INT,
    cpu_velocidad VARCHAR(20),
    ram_marca VARCHAR(50),
    ram_cantidad INT,
    ram_velocidad VARCHAR(20),
    FOREIGN KEY (activo_id) REFERENCES Activos(id)
);

-- Crear tabla de Configuración de Software
CREATE TABLE ConfiguracionSoftware (
    id INT PRIMARY KEY,
    activo_id INT UNIQUE,
    sistema_operativo VARCHAR(50),
    antivirus VARCHAR(50),
    otros_software TEXT,
    FOREIGN KEY (activo_id) REFERENCES Activos(id)
);

-- Tabla para el software instalado
CREATE TABLE Software (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    version VARCHAR(50),
    fabricante VARCHAR(100)
);

-- Tabla de relación N a N entre Computadoras y Software
CREATE TABLE EstacionesTrabajo_Software (
    estacion_trabajo_id INT,
    software_id INT,
    fecha_instalacion DATE, -- Fecha de instalación del software en la estación de trabajo
    licencia VARCHAR(100),  -- Licencia asociada a esta instalación
    PRIMARY KEY (estacion_trabajo_id, software_id),
    FOREIGN KEY (estacion_trabajo_id) REFERENCES ConfiguracionHardware(id),
    FOREIGN KEY (software_id) REFERENCES Software(id)
);

-- Tabla para las licencias que pueden asignarse a usuarios
CREATE TABLE Licencias (
    id INT PRIMARY KEY,
    software_id INT,
    nombre_software VARCHAR(255),
    licencia VARCHAR(100),
    uso_comercial BOOLEAN,
    fecha_caducidad_licencia DATE, -- Fecha de caducidad de la licencia (si aplica)
    FOREIGN KEY (software_id) REFERENCES Software(id)
);

-- Tabla para los usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo_electronico VARCHAR(255) UNIQUE -- Dirección de correo electrónico del usuario
);

-- Tabla de relación N a N entre Usuarios y Licencias
CREATE TABLE Asignaciones_Licencias (
    usuario_id INT,
    licencia_id INT,
    PRIMARY KEY (usuario_id, licencia_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (licencia_id) REFERENCES Licencias(id)
);

-- Tabla para sistemas de video vigilancia
CREATE TABLE Video_Vigilancia (
    activo_id INT PRIMARY KEY,
    modelo_camara VARCHAR(100),
    resolucion VARCHAR(50),
    FOREIGN KEY (activo_id) REFERENCES Activos(id)
);

-- Tabla para sistemas de control de acceso
CREATE TABLE Control_Acceso (
    activo_id INT PRIMARY KEY,
    modelo_dispositivo VARCHAR(100),
    tecnologia VARCHAR(50),
    FOREIGN KEY (activo_id) REFERENCES Activos(id)
);

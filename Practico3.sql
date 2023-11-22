Estructura de las Tablas:
--Practico 3 (Sistema de Tickets)
--Estructura de las Tablas:

-- Tabla de Roles
CREATE TABLE Roles (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    -- Agrega otros campos de usuario según sea necesario
    FOREIGN KEY (rol_id) REFERENCES Roles(id)
);

-- Tabla de Departamentos
CREATE TABLE Departamentos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de Proyectos
CREATE TABLE Proyectos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha_contrato DATE NOT NULL,
    -- Agrega otros campos de proyecto según sea necesario
);

-- Tabla de Tickets
CREATE TABLE Tickets (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(50) NOT NULL,
    prioridad INT NOT NULL,
    usuario_solicitante_id INT NOT NULL,
    departamento_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responsable_id INT,
    -- Agrega otros campos de ticket según sea necesario
    FOREIGN KEY (usuario_solicitante_id) REFERENCES Usuarios(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id)
);

-- Tabla de Comentarios de Tickets
CREATE TABLE Comentarios (
    id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    usuario_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Agrega otros campos de comentario según sea necesario
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla de Activos
CREATE TABLE Activos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_adquisicion DATE NOT NULL,
    responsable_id INT NOT NULL,
    usuario_id INT,
    -- Agrega otros campos de activos según sea necesario
    FOREIGN KEY (responsable_id) REFERENCES Usuarios(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

--Tabla Tickets
CREATE TABLE Tickets (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado_id INT NOT NULL,
    prioridad INT NOT NULL,
    usuario_solicitante_id INT NOT NULL,
    departamento_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    activo_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responsable_id INT,
    FOREIGN KEY (usuario_solicitante_id) REFERENCES Usuarios(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id),
    FOREIGN KEY (activo_id) REFERENCES Activos(id),
    FOREIGN KEY (estado_id) REFERENCES Estados(id) -- Referencia al estado actual
);

--Tabla "Estados":
CREATE TABLE Estados (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de Estaciones de Trabajo
CREATE TABLE Estaciones_de_Trabajo (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    sistema_operativo VARCHAR(100) NOT NULL,
    direccion_ip VARCHAR(15) NOT NULL,
    fecha_adquisicion DATE NOT NULL,
    activo_id INT NOT NULL,
    usuario_id INT,
    -- Agrega otros campos de estaciones de trabajo según sea necesario
    FOREIGN KEY (activo_id) REFERENCES Activos(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla de Formularios de Satisfacción
CREATE TABLE Formularios_de_Satisfaccion (
    id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    calificacion_id INT NOT NULL,
    comentario TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Agrega otros campos de formularios según sea necesario
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id),
    FOREIGN KEY (calificacion_id) REFERENCES Calificaciones_Predeterminadas(id)
);

-- Tabla de Calificaciones Predeterminadas
CREATE TABLE Calificaciones_Predeterminadas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    valor INT NOT NULL
);

-- Tabla de Tiempos de Respuesta Predefinidos (para SLA)
CREATE TABLE Tiempos_SLA (
    id INT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    tiempo_respuesta INT NOT NULL -- Tiempo de respuesta en minutos
);

--Procedimiento Almacenado para cambiar el estado del ticket de acuerdo al procedimiento almacenado
CREATE PROCEDURE ActualizarTicketsSLA
AS
BEGIN
    DECLARE @FechaActual DATETIME = GETDATE();

    -- Actualiza los tickets que no han sido cerrados y están vencidos para categoría normal
    UPDATE Tickets
    SET estado = 'Vencido'
    WHERE estado <> 'Cerrado'
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'normal') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL; -- Considerar solo los tickets asociados a un proyecto

    -- Escala los tickets no atendidos en el tiempo preestablecido para categoría crítica
    UPDATE Tickets
    SET estado = 'Escalado',
        responsable_id = (SELECT usuario_id FROM Departamentos WHERE id = Tickets.departamento_id) -- Asigna el responsable del departamento como escalación
    WHERE estado <> 'Cerrado'
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'critica') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL; -- Considerar solo los tickets asociados a un proyecto

    -- Lógica de actualización según los SLA definidos

    -- Puedes agregar más condiciones y acciones según tus necesidades

--Con esta estructura, puedes definir los estados en la tabla "Estados" y luego asignar el estado apropiado a cada ticket mediante el campo "estado_id" en la tabla "Tickets."Asegúrate de agregar los registros de estados necesarios en la tabla "Estados" (por ejemplo, "Abierto," "En Proceso," "En Pausa" y "Cerrado").

--Tabla "Proyectos":
CREATE TABLE Proyectos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha_contrato DATE NOT NULL,
    -- Agrega otros campos de proyecto según sea necesario
);
--Tabla "Tickets":
CREATE TABLE Tickets (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado_id INT NOT NULL,
    prioridad INT NOT NULL,
    usuario_solicitante_id INT NOT NULL,
    departamento_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    activo_id INT, -- Referencia al activo asignado
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responsable_id INT,
    -- Agrega otros campos de ticket según sea necesario
    FOREIGN KEY (usuario_solicitante_id) REFERENCES Usuarios(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id),
    FOREIGN KEY (activo_id) REFERENCES Activos(id),
    FOREIGN KEY (estado_id) REFERENCES Estados(id) -- Referencia al estado actual
);
--Tabla "Estados":
CREATE TABLE Estados (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
--Tabla "Activos":
CREATE TABLE Activos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_adquisicion DATE NOT NULL,
    ticket_id INT NOT NULL, -- Referencia al ticket al que está asignado
    -- Agrega otros campos de activos según sea necesario
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id)
);
--Tabla "Tiempos_SLA":
CREATE TABLE Tiempos_SLA (
    id INT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    tiempo_respuesta INT NOT NULL -- Tiempo de respuesta en minutos
);
-- Procedimiento Almacenado para tener en cuenta los tiempos de SLA según la categoría del proyecto y los estados de los tickets.

CREATE PROCEDURE ActualizarTicketsSLA
AS
BEGIN
    DECLARE @FechaActual DATETIME = GETDATE();

    -- Actualiza los tickets que no han sido cerrados y están vencidos para categoría normal
    UPDATE Tickets
    SET estado_id = (SELECT id FROM Estados WHERE nombre = 'Vencido')
    WHERE estado_id <> (SELECT id FROM Estados WHERE nombre = 'Cerrado')
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'normal') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL; -- Considerar solo los tickets asociados a un proyecto

    -- Escala los tickets no atendidos en el tiempo preestablecido para categoría crítica
    UPDATE Tickets
    SET estado_id = (SELECT id FROM Estados WHERE nombre = 'Escalado'),
        responsable_id = (SELECT usuario_id FROM Departamentos WHERE id = Tickets.departamento_id) -- Asigna el responsable del departamento como escalación
    WHERE estado_id <> (SELECT id FROM Estados WHERE nombre = 'Cerrado')
        AND (SELECT tiempo_respuesta FROM Tiempos_SLA WHERE categoria = 'critica') < DATEDIFF(MINUTE, Tickets.fecha_creacion, @FechaActual)
        AND Tickets.proyecto_id IS NOT NULL; -- Considerar solo los tickets asociados a un proyecto
END
-- Crear un trigger que se active cuando un ticket cambia su estado a "Cerrado" y que inserte un registro en la tabla "Formularios_Enviados" y realice cualquier otra acción que necesites para enviar el formulario de satisfacción:
CREATE TRIGGER EnviarFormularioSatisfaccion
ON Tickets
AFTER UPDATE
AS
BEGIN
    IF UPDATE(estado_id) -- Se asegura de que el estado haya sido actualizado
    BEGIN
        DECLARE @TicketID INT;
        SELECT @TicketID = id FROM inserted; -- Obtiene el ID del ticket actualizado

        IF (SELECT estado_id FROM Tickets WHERE id = @TicketID) = (SELECT id FROM Estados WHERE nombre = 'Cerrado')
        BEGIN
            -- Inserta un registro en la tabla "Formularios_Enviados" para indicar que se envió el formulario
            INSERT INTO Formularios_Enviados (ticket_id) VALUES (@TicketID);

            -- Envía el formulario de satisfacción al cliente (aquí debes agregar la lógica específica para enviar el formulario)
            -- Esto puede implicar el envío de un correo electrónico o la activación de alguna otra funcionalidad de tu aplicación.

            -- Puedes agregar la lógica de envío del formulario aquí.

        END;
    END;
END;

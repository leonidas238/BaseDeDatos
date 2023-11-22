# TABLAS Para el Parcial 1
# Fecha de entrega 12/10
## Subir DER y SQL de la base de datos generada

## :warning: Advertencia

**¡Este Markdown lo generé con ChatGPT y puede contener errores o inexactitudes!**

Lo revisé por encima y parece que esta bien pero por las duda si lo usan revisenlo.


### USUARIOS

| ATRIBUTOS         | TIPO         | RESTRICCIONES              | DESCRIPCIÓN              |
|-------------------|--------------|---------------------------|--------------------------|
| Cedula            | VARCHAR(8)   | Clave Primaria            | Identificador de Usuario |
| Nombre            | VARCHAR(255) | No vacío                  |                          |
| Apellido           | VARCHAR      |                           |                          |
| Email             | VARCHAR(255) | No vacío                  |                          |
| Email_de_Usuario   | VARCHAR(255)| No vacío                  | Tipo String no vacío     |
| Tipo de usuario    | INT          |                           |                          |

### PROFESOR

| ATRIBUTOS   | TIPO      | RESTRICCIONES              | DESCRIPCIÓN                      |
|-------------|---------- |---------------------------|---------------------------------|
| Cedula      | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Usuario        |
| IdProfesor  | INT      | Clave Primaria            | Identificador débil de Profesor |
| Grado       | VARCHAR  | Vacío                     | Grado de Profesor               |

### ALUMNOS

| ATRIBUTOS    | TIPO     | RESTRICCIONES              | DESCRIPCIÓN                  |
|--------------|--------- |---------------------------|-----------------------------|
| Cedula       | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Usuario    |
| IdAlumnos    | INT     | Clave Primaria            | Identificador débil de Alumno |

### BEDELÍAS

| ATRIBUTOS   | TIPO      | RESTRICCIONES              | DESCRIPCIÓN              |
|-------------|---------- |---------------------------|--------------------------|
| Cedula      | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Usuario |
| IdBedelia   | INT      | Clave Primaria            | Identificador débil de Bedelía |
| Cargo       | VARCHAR  | Vacío                     | Grado del cargo           |

### MATERIAS

| ATRIBUTOS   | TIPO        | RESTRICCIONES              | DESCRIPCIÓN                  |
|------------ |------------ |---------------------------|-----------------------------|
| IdMateria   | INT       | Autoincremental, Clave Primaria | Identificador de Materia   |
| Nombre     | VARCHAR(255)| No vacío                  | Nombre de Materia           |

### GRUPOS

| ATRIBUTOS   | TIPO        | RESTRICCIONES              | DESCRIPCIÓN                         |
|------------ |------------ |---------------------------|------------------------------------|
| idGrupo     | VARCHAR(10)| Clave Primaria            | Identificador de Grupo por Acrónimo |
| Nombre      | VARCHAR    | No vacío                  | Nombre completo del grupo           |
| Año electivo | INT       | No vacío                  | Año electivo del grupo              |
| Fecha_Creacion | INT     | No vacío                  | Fecha de creación del grupo         |

### FORO

| ATRIBUTOS | TIPO       | RESTRICCIONES              | DESCRIPCIÓN             |
|---------- |-----------  |---------------------------|-------------------------|
| IdForo   | INT       | Autoincremental, Clave Primaria | Identificador de Foro |
| Información | VARCHAR(MAX)| Vacío                     | Información de Foro    |
| Data     | VARBINARY(MAX)| Vacío                     | Archivos de Foro       |

### TAREAS

| ATRIBUTOS   | TIPO        | RESTRICCIONES              | DESCRIPCIÓN                  |
|------------ |------------ |---------------------------|-----------------------------|
| IdTareas   | INT       | Autoincremental, Clave Primaria | Identificador de Tarea    |
| Descripción | VARCHAR(MAX)| No vacío                  | Descripción de Tarea       |
| Fecha de Vencimiento | VARCHAR(255)| No vacío               | Fecha de Vencimiento de la Tarea |
| Archivo   | VARBINARY(MAX)| Vacío                     | Archivos de Tarea          |
| Fecha de Creación | DATE | No vacío                  | Fecha de Creación de la Tarea |

### DATOS-FORO

| ATRIBUTOS | TIPO     | RESTRICCIONES              | DESCRIPCIÓN              |
|---------- |--------- |---------------------------|--------------------------|
| IdDatos  | INT     | Autoincremental, Clave Primaria | Identificador del dato ingresado |
| IdForo   | BIGINT   | Foreign Key                | Identificador de Foro    |
| idUsuario | VARCHAR(8)| Foreign Key              | Identificador de Usuario |
| mensaje   | VARCHAR(MAX)| No vacío                | Mensaje enviado          |
| archivo   | VARBINARY(MAX)| Vacío                   | Archivo                 |

### HISTORIAL REGISTRO

| ATRIBUTOS | TIPO     | RESTRICCIONES              | DESCRIPCIÓN              |
|---------- |--------- |---------------------------|--------------------------|
| ID      | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Usuario |
| app     | VARCHAR(255)|                        |                          |
| acción  | VARCHAR(255)|                        |                          |
| Mensaje | VARCHAR(255)|                        |                          |

### MATERIAL PUBLICO

| ATRIBUTOS | TIPO       | RESTRICCIONES              | DESCRIPCIÓN              |
|---------- |-----------  |---------------------------|--------------------------|
| ID       | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Usuario |
| titulo   | VARCHAR(255)|                        |                          |
| Mensaje  | VARCHAR(MAX)|                        |                          |

### CARRERA

| ATRIBUTOS | TIPO        | RESTRICCIONES              | DESCRIPCIÓN             |
|---------- |------------ |---------------------------|-------------------------|
| Id       | INT        | Autoincremental, Clave Primaria | Identificador         |
| nombre   | VARCHAR(255)| No vacío                  | Nombre                 |
| categoria | VARCHAR(10)| No vacío                 | Categoría               |
| plan    | VARCHAR(8)| No vacío                  | Plan                    |

### GRADO

| ATRIBUTOS | TIPO        | RESTRICCIONES              | DESCRIPCIÓN           |
|---------- |------------ |---------------------------|-----------------------|
| Id       | INT        | Autoincremental, Clave Primaria | Identificador       |
| nombre   | VARCHAR(255)| No vacío                  | Nombre               |
| carrera_id | VARCHAR(10)| Foreign Key              | Identificador de Carrera |

### DICTA



| ATRIBUTOS   | TIPO    | RESTRICCIONES              | DESCRIPCIÓN                 |
|------------ |-------- |---------------------------|----------------------------|
| IdMateria   | BIGINT | Clave Primaria, Foreign Key | Identificador de Materia   |
| idProfesor  | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Profesor |

### PERTENECEN

| ATRIBUTOS  | TIPO    | RESTRICCIONES              | DESCRIPCIÓN              |
|----------- |-------- |---------------------------|--------------------------|
| IdAlumno  | VARCHAR(8)| Clave Primaria, Foreign Key | Identificador de Alumno |
| idGrupo   | VARCHAR(10)| Foreign Key               | Identificador de Grupo  |

### TIENEN

| ATRIBUTOS  | TIPO     | RESTRICCIONES | DESCRIPCIÓN              |
|----------- |--------- |--------------  |--------------------------|
| IdMateria  | BIGINT  | Foreign Key  | Identificador de Materia |
| idGrupo   | VARCHAR(10)| Clave Primaria, Foreign Key | Identificador de Grupo |
| idProfesor | VARCHAR(8)| Foreign Key  | Identificador de Profesor |

### CREA

| ATRIBUTOS   | TIPO    | RESTRICCIONES | DESCRIPCIÓN              |
|------------ |-------- |--------------  |--------------------------|
| IdMateria   | BIGINT | Foreign Key  | Identificador de Materia |
| IdTareas   | INT     | Clave Primaria, Foreign Key | Identificador de Tarea   |
| idGrupo    | VARCHAR(10)| Clave Primaria, Foreign Key | Identificador de Grupo   |
| idProfesor | VARCHAR(8)| Foreign Key  | Identificador de Profesor |

### ENTREGA

| ATRIBUTOS   | TIPO   | RESTRICCIONES | DESCRIPCIÓN             |
|------------ |------- |--------------  |-------------------------|
| IdAlumno   | INT   | Clave Primaria, Foreign Key | Identificador de Alumno |
| IdTareas  | INT     | Clave Primaria, Foreign Key | Identificador de Tarea   |
| Archivo   | VARBINARY(MAX)| Vacío         | Archivos de Tarea       |
| Calificación | INT  | Vacío         | Calificación de la tarea |
| Fecha entrega | INT | No vacío      | Entrega de la tarea     |

### ESTAN

| ATRIBUTOS   | TIPO    | RESTRICCIONES | DESCRIPCIÓN             |
|------------ |-------- |--------------  |-------------------------|
| IdForo     | BIGINT | Clave Primaria, Foreign Key | Identificador de Foro   |
| IdMateria  | BIGINT  | Foreign Key  | Identificador de Materia |
| idGrupo   | VARCHAR(10)| Foreign Key  | Identificador de Grupo   |
| idProfesor | VARCHAR(8)| Foreign Key  | Identificador de Profesor |

### RE-HACER-TAREA

| ATRIBUTOS     | TIPO    | RESTRICCIONES | DESCRIPCIÓN                  |
|-------------- |-------- |--------------  |-----------------------------|
| IdTareasNueva | BIGINT | Clave Primaria, Foreign Key | Identificador de Tarea Nueva |
| IdTareas     | INT     | Clave Primaria, Foreign Key | Identificador de Tarea   |
| Calificación | INT     | Vacío         | Calificación de la tarea |
| Fecha entrega | INT     | No vacío      | Entrega de la tarea     |
| Archivo      | VARBINARY(MAX)| Vacío         | Archivos de Tarea       |

### CARRERA MATERIA

| ATRIBUTOS  | TIPO   | RESTRICCIONES | DESCRIPCIÓN             |
|----------- |------- |--------------  |-------------------------|
| IdMateria  | BIGINT | Clave Primaria, Foreign Key | Identificador de Materia |
| IdCarrera  | BIGINT | Clave Primaria, Foreign Key | Identificador de Carrera |
| Id Grado   | BIGINT | Clave Primaria, Foreign Key | Identificador de Grado   |

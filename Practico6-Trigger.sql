-- Crear un trigger para consultar nuevas vulnerabilidades (CVE) al agregar un incidente de seguridad
CREATE TRIGGER trg_AgregarIncidente
ON Incidentes_Seguridad
AFTER INSERT
AS
BEGIN
    DECLARE @incidente_id INT;

    -- Obtener el ID del incidente recién agregado
    SELECT @incidente_id = id
    FROM inserted;

    -- Ejecutar el procedimiento almacenado para actualizar detalles de CVE
    EXEC sp_ActualizarCVEDesdeAPI;

    -- Puedes hacer más operaciones aquí, como asociar las nuevas CVE al incidente si es necesario
    -- Por ejemplo, puedes agregar registros a la tabla DetallesCVECWE con las CVE recién obtenidas.

    -- Ejemplo de asociar las nuevas CVE al incidente
    INSERT INTO DetallesCVECWE (incidente_id, cve, cwe, descripcion)
    SELECT @incidente_id, cve, cwe, descripcion
    FROM DetallesCVECWE
    WHERE incidente_id = @incidente_id;
END;

-- Crear un procedimiento almacenado para obtener y almacenar nuevas CVE desde una API de terceros
CREATE PROCEDURE sp_ActualizarCVEDesdeAPI
AS
BEGIN
    DECLARE @url VARCHAR(255) = 'https://api.tucve.com/v1/cve-data'; -- Reemplaza con la URL de la API
    DECLARE @response NVARCHAR(MAX);

    -- Realizar una solicitud HTTP GET a la API
    EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @response OUTPUT;
    EXEC sp_OAMethod @response, 'open', NULL, 'GET', @url, false;
    EXEC sp_OAMethod @response, 'setRequestHeader', NULL, 'Content-Type', 'application/json';
    EXEC sp_OAMethod @response, 'send';

    -- Analizar la respuesta JSON
    DECLARE @json VARCHAR(MAX);
    EXEC sp_OAGetProperty @response, 'responseText', @json OUTPUT;

    -- Procesar la respuesta JSON y almacenar las CVE en la base de datos
    INSERT INTO DetallesCVECWE (incidente_id, cve, cwe, descripcion)
    SELECT incidente_id, cve, cwe, descripcion
    FROM OPENJSON(@json)
    WITH (
        incidente_id INT '$.incidente_id',
        cve VARCHAR(20) '$.cve',
        cwe VARCHAR(20) '$.cwe',
        descripcion NVARCHAR(MAX) '$.descripcion'
    );
    EXEC sp_OADestroy @response;
END;

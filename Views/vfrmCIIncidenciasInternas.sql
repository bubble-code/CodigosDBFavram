-- Se crea una funcion para obtener mediante el id del operario obtener su DescOperario de la tabla tbMaestroOperario
-- Se Activa el campo de Gravedad
-- Vista que se usa en la Pantalla Incidencias(Visto Bueno Calidad y Administracion)
-- Original
SELECT dbo.tbIncidenciaInterna.IDIncidencia, dbo.tbIncidenciaInterna.DescIncidencia, dbo.tbIncidenciaInterna.Texto, dbo.tbIncidenciaInterna.IDCliente, dbo.tbIncidenciaInterna.IDAlbaran, dbo.tbIncidenciaInterna.IDArticulo,
    dbo.tbIncidenciaInterna.IDOrden, dbo.tbIncidenciaInterna.IDLocalizacion, dbo.tbIncidenciaInterna.IDCausa, dbo.tbIncidenciaInterna.IDCuenta, dbo.tbIncidenciaInterna.Cerrada, dbo.tbIncidenciaInterna.FechaCierre,
    dbo.tbMaestroArticulo.DescArticulo, dbo.tbMaestroCausaNoCalidad.DescCausa, dbo.tbMaestroLocalizacion.DescLocalizacion, dbo.tbMaestroCliente.DescCliente, dbo.tbMaestroCuentaNoCalidad.DescCuenta,
    dbo.tbMaestroArticulo.IDTipo, dbo.tbMaestroArticulo.IDFamilia, dbo.tbMaestroArticulo.IDSubfamilia, dbo.tbMaestroArticulo.FechaAlta, dbo.tbIncidenciaInterna.ControladoCalidad, dbo.tbIncidenciaInterna.ControladoAdmon,
    dbo.tbOrdenFabricacion.NOrden, dbo.tbIncidenciaInterna.ImporteAbono, dbo.tbIncidenciaInterna.Lote, dbo.tbIncidenciaInterna.FechaIncidencia, dbo.tbIncidenciaInterna.IDOperario, dbo.tbIncidenciaInterna.IDCentro,
    dbo.tbIncidenciaInterna.QRecuperada, dbo.tbIncidenciaInterna.OtrosCostes, dbo.tbIncidenciaInterna.PrecioPieza, dbo.tbIncidenciaInterna.QRechazada, dbo.tbIncidenciaInterna.QPieza,
    (dbo.tbIncidenciaInterna.QTiempoSeleccion * dbo.tbIncidenciaInterna.PrecioSeleccion + dbo.tbIncidenciaInterna.QTiempoRecuperacion * dbo.tbIncidenciaInterna.PrecioRecuperacion + dbo.tbIncidenciaInterna.OtrosCostes + dbo.tbIncidenciaInterna.CosteTransporte)
                          + dbo.tbIncidenciaInterna.QPieza * dbo.tbIncidenciaInterna.PrecioPieza AS CosteTotal, MONTH(dbo.tbIncidenciaInterna.FechaIncidencia) AS MES, YEAR(dbo.tbIncidenciaInterna.FechaIncidencia) AS AÑO,
    (SELECT STRING_AGG(IDOperario, ',') AS Operarios
    FROM dbo.tbOperarioIncidenciaInterna
    WHERE        (IDIncidencia = dbo.tbIncidenciaInterna.IDIncidencia)) AS Operarios, dbo.tbMaestroSeccion.IDSeccion, dbo.tbMaestroSeccion.DescSeccion, dbo.tbIncidenciaInterna.QTiempoRecuperacion
FROM dbo.tbMaestroArticulo RIGHT OUTER JOIN
    dbo.tbOrdenFabricacion RIGHT OUTER JOIN
    dbo.tbIncidenciaInterna ON dbo.tbOrdenFabricacion.IDOrden = dbo.tbIncidenciaInterna.IDOrden LEFT OUTER JOIN
    dbo.tbMaestroCuentaNoCalidad ON dbo.tbIncidenciaInterna.IDCuenta = dbo.tbMaestroCuentaNoCalidad.IDCuenta ON dbo.tbMaestroArticulo.IDArticulo = dbo.tbIncidenciaInterna.IDArticulo LEFT OUTER JOIN
    dbo.tbMaestroCausaNoCalidad ON dbo.tbIncidenciaInterna.IDCausa = dbo.tbMaestroCausaNoCalidad.IDCausa LEFT OUTER JOIN
    dbo.tbMaestroLocalizacion ON dbo.tbIncidenciaInterna.IDLocalizacion = dbo.tbMaestroLocalizacion.IDLocalizacion LEFT OUTER JOIN
    dbo.tbMaestroCliente ON dbo.tbIncidenciaInterna.IDCliente = dbo.tbMaestroCliente.IDCliente LEFT OUTER JOIN
    dbo.tbMaestroCentro INNER JOIN
    dbo.tbMaestroSeccion ON dbo.tbMaestroCentro.IDSeccion = dbo.tbMaestroSeccion.IDSeccion ON dbo.tbIncidenciaInterna.IDCentro = dbo.tbMaestroCentro.IDCentro


-- Se crea una funcion para obtener mediante el id del operario obtener su DescOperario de la tabla tbMaestroOperario
ALTER FUNCTION [dbo].[ConvertToDescOperario] 
(	
@IDIncidencia nvarchar(25)
)
RETURNS TABLE
RETURN 
(
   SELECT STRING_AGG(tbo.DescOperario, ', ')
   WITHIN GROUP (ORDER BY toi.IDOperario) AS operarios
FROM dbo.tbOperarioIncidenciaInterna AS toi
    INNER JOIN dbo.tbMaestroOperario AS tbo ON toi.IDOperario = tbo.IDOperario
WHERE toi.IDIncidencia = @IDIncidencia
)


-- Se le crea un nuevo campo llamado NameOperario que es la ejecucion de la funcion ConvertToDescOperario(@IDIncidencia nvarchar(25))  
SELECT dbo.tbIncidenciaInterna.IDIncidencia, dbo.tbIncidenciaInterna.DescIncidencia, dbo.tbIncidenciaInterna.Texto, dbo.tbIncidenciaInterna.IDCliente, dbo.tbIncidenciaInterna.IDAlbaran, dbo.tbIncidenciaInterna.IDArticulo,
    dbo.tbIncidenciaInterna.IDOrden, dbo.tbIncidenciaInterna.IDLocalizacion, dbo.tbIncidenciaInterna.IDCausa, dbo.tbIncidenciaInterna.IDCuenta, dbo.tbIncidenciaInterna.Cerrada, dbo.tbIncidenciaInterna.FechaCierre,
    dbo.tbMaestroArticulo.DescArticulo, dbo.tbMaestroCausaNoCalidad.DescCausa, dbo.tbMaestroLocalizacion.DescLocalizacion, dbo.tbMaestroCliente.DescCliente, dbo.tbMaestroCuentaNoCalidad.DescCuenta,
    dbo.tbMaestroArticulo.IDTipo, dbo.tbMaestroArticulo.IDFamilia, dbo.tbMaestroArticulo.IDSubfamilia, dbo.tbMaestroArticulo.FechaAlta, dbo.tbIncidenciaInterna.ControladoCalidad, dbo.tbIncidenciaInterna.ControladoAdmon,
    dbo.tbOrdenFabricacion.NOrden, dbo.tbIncidenciaInterna.ImporteAbono, dbo.tbIncidenciaInterna.Lote, dbo.tbIncidenciaInterna.FechaIncidencia, dbo.tbIncidenciaInterna.IDOperario, dbo.tbIncidenciaInterna.IDCentro,
    dbo.tbIncidenciaInterna.QRecuperada, dbo.tbIncidenciaInterna.OtrosCostes, dbo.tbIncidenciaInterna.PrecioPieza, dbo.tbIncidenciaInterna.QRechazada, dbo.tbIncidenciaInterna.QPieza,
    (dbo.tbIncidenciaInterna.QTiempoSeleccion * dbo.tbIncidenciaInterna.PrecioSeleccion + dbo.tbIncidenciaInterna.QTiempoRecuperacion * dbo.tbIncidenciaInterna.PrecioRecuperacion + dbo.tbIncidenciaInterna.OtrosCostes + dbo.tbIncidenciaInterna.CosteTransporte)
                          + dbo.tbIncidenciaInterna.QPieza * dbo.tbIncidenciaInterna.PrecioPieza AS CosteTotal, MONTH(dbo.tbIncidenciaInterna.FechaIncidencia) AS MES, YEAR(dbo.tbIncidenciaInterna.FechaIncidencia) AS AÑO,
    (SELECT STRING_AGG(IDOperario, ',') AS Operarios
    FROM dbo.tbOperarioIncidenciaInterna
    WHERE        (IDIncidencia = dbo.tbIncidenciaInterna.IDIncidencia)) AS Operarios, dbo.tbMaestroSeccion.IDSeccion, dbo.tbMaestroSeccion.DescSeccion, dbo.tbIncidenciaInterna.QTiempoRecuperacion,
    (SELECT operarios
    FROM dbo.ConvertToDescOperario(dbo.tbIncidenciaInterna.IDIncidencia) AS operarios) AS NameOperarios
FROM dbo.tbMaestroArticulo RIGHT OUTER JOIN
    dbo.tbOrdenFabricacion RIGHT OUTER JOIN
    dbo.tbIncidenciaInterna ON dbo.tbOrdenFabricacion.IDOrden = dbo.tbIncidenciaInterna.IDOrden LEFT OUTER JOIN
    dbo.tbMaestroCuentaNoCalidad ON dbo.tbIncidenciaInterna.IDCuenta = dbo.tbMaestroCuentaNoCalidad.IDCuenta ON dbo.tbMaestroArticulo.IDArticulo = dbo.tbIncidenciaInterna.IDArticulo LEFT OUTER JOIN
    dbo.tbMaestroCausaNoCalidad ON dbo.tbIncidenciaInterna.IDCausa = dbo.tbMaestroCausaNoCalidad.IDCausa LEFT OUTER JOIN
    dbo.tbMaestroLocalizacion ON dbo.tbIncidenciaInterna.IDLocalizacion = dbo.tbMaestroLocalizacion.IDLocalizacion LEFT OUTER JOIN
    dbo.tbMaestroCliente ON dbo.tbIncidenciaInterna.IDCliente = dbo.tbMaestroCliente.IDCliente LEFT OUTER JOIN
    dbo.tbMaestroCentro INNER JOIN
    dbo.tbMaestroSeccion ON dbo.tbMaestroCentro.IDSeccion = dbo.tbMaestroSeccion.IDSeccion ON dbo.tbIncidenciaInterna.IDCentro = dbo.tbMaestroCentro.IDCentro
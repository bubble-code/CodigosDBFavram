-- Se ha creado una nueva vista que es una copia de la vista vfrmCIIncidenciasInternas, esta se ha cambiado para que 
-- muestre los operarios con incidencias y no las incidencias agrupadas
-- dbo.vfrmCIIncidenciasInternasAgrupada source

-- dbo.vfrmCIIncidenciasInternasAgrupada source

CREATE VIEW dbo.vfrmCIIncidenciasInternasAgrupada
AS
SELECT        dbo.tbIncidenciaInterna.IDIncidencia, dbo.tbIncidenciaInterna.DescIncidencia, dbo.tbIncidenciaInterna.Texto, dbo.tbIncidenciaInterna.IDCliente, dbo.tbIncidenciaInterna.IDAlbaran, dbo.tbIncidenciaInterna.IDArticulo, 
                         dbo.tbIncidenciaInterna.IDOrden, dbo.tbIncidenciaInterna.IDLocalizacion, dbo.tbIncidenciaInterna.IDCausa, dbo.tbIncidenciaInterna.IDCuenta, dbo.tbIncidenciaInterna.Cerrada, dbo.tbIncidenciaInterna.FechaCierre, 
                         dbo.tbMaestroArticulo.DescArticulo, dbo.tbMaestroCausaNoCalidad.DescCausa, dbo.tbMaestroLocalizacion.DescLocalizacion, dbo.tbMaestroCliente.DescCliente, dbo.tbMaestroCuentaNoCalidad.DescCuenta, 
                         dbo.tbMaestroArticulo.IDTipo, dbo.tbMaestroArticulo.IDFamilia, dbo.tbMaestroArticulo.IDSubfamilia, dbo.tbMaestroArticulo.FechaAlta, dbo.tbIncidenciaInterna.ControladoCalidad, dbo.tbIncidenciaInterna.ControladoAdmon, 
                         dbo.tbOrdenFabricacion.NOrden, dbo.tbIncidenciaInterna.ImporteAbono, dbo.tbIncidenciaInterna.Lote, dbo.tbIncidenciaInterna.FechaIncidencia, dbo.tbIncidenciaInterna.IDOperario, dbo.tbIncidenciaInterna.IDCentro, 
                         dbo.tbIncidenciaInterna.QRecuperada, dbo.tbIncidenciaInterna.OtrosCostes, dbo.tbIncidenciaInterna.PrecioPieza, dbo.tbIncidenciaInterna.QRechazada, dbo.tbIncidenciaInterna.QPieza, 
                         (dbo.tbIncidenciaInterna.QTiempoSeleccion * dbo.tbIncidenciaInterna.PrecioSeleccion + dbo.tbIncidenciaInterna.QTiempoRecuperacion * dbo.tbIncidenciaInterna.PrecioRecuperacion + dbo.tbIncidenciaInterna.OtrosCostes + dbo.tbIncidenciaInterna.CosteTransporte)
                          + dbo.tbIncidenciaInterna.QPieza * dbo.tbIncidenciaInterna.PrecioPieza AS CosteTotal, MONTH(dbo.tbIncidenciaInterna.FechaIncidencia) AS MES, YEAR(dbo.tbIncidenciaInterna.FechaIncidencia) AS AÑO, 
                         dbo.tbMaestroSeccion.IDSeccion, dbo.tbMaestroSeccion.DescSeccion, dbo.tbIncidenciaInterna.QTiempoRecuperacion,
                             (SELECT        operarios
                               FROM            dbo.ConvertToDescOperario(dbo.tbIncidenciaInterna.IDIncidencia) AS operarios) AS NameOperarios, dbo.tbIncidenciaInterna.Gravedad, tbOperarioIncidenciaInterna_1.IDOperario AS Operario, 
                         dbo.tbIncidenciaInterna.TextoRecuperacion, dbo.tbMaestroCentro.DescCentro,
                             (SELECT        OperarioCount
                               FROM            dbo.GetOperarioDataForIncidencia(dbo.tbIncidenciaInterna.IDIncidencia) AS GetOperarioDataForIncidencia_1) AS CantOperarios,
                             (SELECT        IncidenciaValue
                               FROM            dbo.GetOperarioDataForIncidencia(dbo.tbIncidenciaInterna.IDIncidencia) AS GetOperarioDataForIncidencia_1) AS Coste_Operario
FROM            dbo.tbMaestroCuentaNoCalidad RIGHT OUTER JOIN
                         dbo.tbOperarioIncidenciaInterna AS tbOperarioIncidenciaInterna_1 RIGHT OUTER JOIN
                         dbo.tbIncidenciaInterna ON tbOperarioIncidenciaInterna_1.IDIncidencia = dbo.tbIncidenciaInterna.IDIncidencia LEFT OUTER JOIN
                         dbo.tbOrdenFabricacion ON dbo.tbIncidenciaInterna.IDOrden = dbo.tbOrdenFabricacion.IDOrden ON dbo.tbMaestroCuentaNoCalidad.IDCuenta = dbo.tbIncidenciaInterna.IDCuenta LEFT OUTER JOIN
                         dbo.tbMaestroArticulo ON dbo.tbIncidenciaInterna.IDArticulo = dbo.tbMaestroArticulo.IDArticulo LEFT OUTER JOIN
                         dbo.tbMaestroCausaNoCalidad ON dbo.tbIncidenciaInterna.IDCausa = dbo.tbMaestroCausaNoCalidad.IDCausa LEFT OUTER JOIN
                         dbo.tbMaestroLocalizacion ON dbo.tbIncidenciaInterna.IDLocalizacion = dbo.tbMaestroLocalizacion.IDLocalizacion LEFT OUTER JOIN
                         dbo.tbMaestroCliente ON dbo.tbIncidenciaInterna.IDCliente = dbo.tbMaestroCliente.IDCliente LEFT OUTER JOIN
                         dbo.tbMaestroCentro INNER JOIN
                         dbo.tbMaestroSeccion ON dbo.tbMaestroCentro.IDSeccion = dbo.tbMaestroSeccion.IDSeccion ON dbo.tbIncidenciaInterna.IDCentro = dbo.tbMaestroCentro.IDCentro;




-- Se crea una funcion Table-Valued para obtener Cantidad de operarios por incidencias y el valor de la incidencia
-- divido por la cantidad de operarios
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GetOperarioDataForIncidencia]
(    
    @IDIncidencia nvarchar(25)
)
RETURNS @TableResult TABLE (OperarioCount int, IncidenciaValue decimal(10,4)) 
AS
BEGIN
	--Operario nvarchar(25),
    --DECLARE @Operario nvarchar(25)
    DECLARE @OperarioCount int
    DECLARE @IncidenciaValue decimal(10,4)

   -- SELECT @Operario = CASE WHEN tbO.IDOperario IS NULL THEN 'No Definido' ELSE tbO.IDOperario END
   -- FROM tbOperarioIncidenciaInterna as tbO 
   -- RIGHT OUTER JOIN dbo.tbIncidenciaInterna ON tbO.IDIncidencia = dbo.tbIncidenciaInterna.IDIncidencia 
   -- WHERE tbO.IDIncidencia = @IDIncidencia

    SELECT @OperarioCount = COUNT(*) 
    FROM tbOperarioIncidenciaInterna as tbO 
    RIGHT OUTER JOIN dbo.tbIncidenciaInterna ON tbO.IDIncidencia = dbo.tbIncidenciaInterna.IDIncidencia 
    WHERE tbO.IDIncidencia = @IDIncidencia

    SELECT @IncidenciaValue = (tii.QTiempoSeleccion * tii.PrecioSeleccion + tii.QTiempoRecuperacion * tii.PrecioRecuperacion + tii.OtrosCostes + tii.CosteTransporte) + tii.QPieza * tii.PrecioPieza 
    FROM dbo.tbIncidenciaInterna as tii
    WHERE tii.IDIncidencia = @IDIncidencia

    INSERT INTO @TableResult (OperarioCount, IncidenciaValue)
    VALUES (@OperarioCount, case 
	when @OperarioCount is null or @OperarioCount = 0 then @IncidenciaValue else @IncidenciaValue / @OperarioCount end 
	)

    RETURN
END



-- Original
SELECT DISTINCT
    dbo.tbOrdenFabricacion.IDOrden, dbo.tbOrdenFabricacion.IDArticulo, dbo.tbMaestroArticulo.DescArticulo, dbo.tbOrdenFabricacion.NOrden, dbo.tbOrdenFabricacion.QFabricar - dbo.tbOrdenFabricacion.QFabricada AS QPendiente,
    dbo.tbOrdenFabricacion.Estado, dbo.tbOrdenFabricacion.FechaInicio, dbo.tbOrdenFabricacion.FechaFin, dbo.tbOrdenFabricacion.FechaCreacion, dbo.tbOrdenFabricacion.IDCentroGestion, dbo.tbOrdenFabricacion.IDAlmacen,
    NULLIF (dbo.tbOrdenFabricacion.IDEstructura, dbo.tbOrdenFabricacion.IDEstructura) AS IDCentro_old, dbo.tbMaestroArticulo.IDTipo, dbo.tbOrdenFabricacion.IDCentroCritico, dbo.tbOrdenFabricacion.QFabricar AS Fabricar,
    dbo.tbOrdenFabricacion.QFabricada AS Fabricada, dbo.xPrintingAuxiliarTable.IdProcess, dbo.xPrintingAuxiliarTable.NumberOfCopies, dbo.tbMaestroArticulo.NivelPlano, dbo.tbOrdenFabricacion.IDLineaPedidoOrigen,
    CAST(dbo.tbPedidoVentaCabecera.NPedido AS nvarchar) + '/' + CAST(dbo.tbPedidoVentaLinea.IdOrdenLinea AS nvarchar) AS PedidoOrigenDesc,
    (SELECT STRING_AGG(LEFT(dbo.tbMaestroCentro.DescCentro, 3), ',') AS Expr1
    FROM dbo.tbOrdenRuta INNER JOIN
        dbo.tbMaestroCentro ON dbo.tbOrdenRuta.IDCentro = dbo.tbMaestroCentro.IDCentro
    WHERE        (dbo.tbOrdenRuta.NOrden = dbo.tbOrdenFabricacion.NOrden) AND (dbo.tbOrdenRuta.Estado = 0)) AS CFases, dbo.tbOrdenFabricacion.Reproceso
FROM dbo.tbOrdenFabricacion LEFT OUTER JOIN
    dbo.xPrintingAuxiliarTable ON dbo.tbOrdenFabricacion.IDOrden = dbo.xPrintingAuxiliarTable.NumericLink LEFT OUTER JOIN
    dbo.tbMaestroArticulo ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticulo.IDArticulo LEFT OUTER JOIN
    dbo.tbPedidoVentaLinea ON dbo.tbPedidoVentaLinea.IDLineaPedido = dbo.tbOrdenFabricacion.IDLineaPedidoOrigen LEFT OUTER JOIN
    dbo.tbPedidoVentaCabecera ON dbo.tbPedidoVentaCabecera.IDPedido = dbo.tbPedidoVentaLinea.IDPedido

-- Cambios para Obtener el origen de cada OF y cuando se tenga el pedido de venta obtener la fecha mas reciente para poder hacer el calculo de "Fecha Requerida Seccion"


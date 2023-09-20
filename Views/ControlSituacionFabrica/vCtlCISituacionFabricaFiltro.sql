--Original

SELECT        dbo.tbOrdenFabricacion.IDOrden, dbo.tbOrdenFabricacion.IDArticulo, dbo.tbMaestroArticulo.DescArticulo, dbo.tbPedidoVentaCabecera.IDCliente, dbo.tbOrdenFabricacion.NOrden, 
                         CASE dbo.tbOrdenFabricacionOrigen.TipoOrigen WHEN 2 THEN dbo.tbOrdenFabricacionOrigen.NOrigen ELSE NULL END AS NOrdenPadre, dbo.tbOrdenFabricacion.QFabricar - dbo.tbOrdenFabricacion.QFabricada AS QPendiente, 
                         CASE dbo.tbOrdenFabricacionOrigen.TipoOrigen WHEN 0 THEN dbo.tbOrdenFabricacionOrigen.NOrigen ELSE NULL END AS IdPedido, dbo.tbOrdenFabricacion.Estado, dbo.tbOrdenFabricacion.FechaInicio, 
                         dbo.tbOrdenFabricacion.FechaFin, dbo.tbOrdenFabricacionOrigen.TipoOrigen, dbo.tbOrdenFabricacion.FechaCreacion, dbo.tbOrdenFabricacion.IDCentroGestion, dbo.tbOrdenFabricacion.IDAlmacen, 
                         dbo.xPrintingAuxiliarTable.IdProcess, dbo.xPrintingAuxiliarTable.NumberOfCopies, dbo.tbOrdenFabricacion.IDLineaPedidoOrigen, CAST(dbo.tbPedidoVentaCabecera.NPedido AS nvarchar) 
                         + '/' + CAST(dbo.tbPedidoVentaLinea.IdOrdenLinea AS nvarchar) AS PedidoOrigenDesc
FROM            dbo.xPrintingAuxiliarTable RIGHT OUTER JOIN
                         dbo.tbOrdenFabricacion ON dbo.xPrintingAuxiliarTable.NumericLink = dbo.tbOrdenFabricacion.IDOrden LEFT OUTER JOIN
                         dbo.tbOrdenFabricacionOrigen ON dbo.tbOrdenFabricacion.IDOrden = dbo.tbOrdenFabricacionOrigen.IDOrden LEFT OUTER JOIN
                         dbo.tbMaestroArticulo ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticulo.IDArticulo LEFT OUTER JOIN
                         dbo.tbPedidoVentaCabecera ON dbo.tbOrdenFabricacionOrigen.NOrigen = dbo.tbPedidoVentaCabecera.NPedido LEFT OUTER JOIN
                         dbo.tbPedidoVentaLinea ON dbo.tbOrdenFabricacion.IDLineaPedidoOrigen = dbo.tbPedidoVentaLinea.IDLineaPedido
WHERE        (dbo.tbOrdenFabricacionOrigen.TipoOrigen = 0)

-- Con los cambios
SELECT        dbo.tbOrdenFabricacion.IDOrden, dbo.tbOrdenFabricacion.IDArticulo, dbo.tbMaestroArticulo.DescArticulo, dbo.tbPedidoVentaCabecera.IDCliente, dbo.tbOrdenFabricacion.NOrden, 
                         CASE dbo.tbOrdenFabricacionOrigen.TipoOrigen WHEN 2 THEN dbo.tbOrdenFabricacionOrigen.NOrigen ELSE NULL END AS NOrdenPadre, dbo.tbOrdenFabricacion.QFabricar - dbo.tbOrdenFabricacion.QFabricada AS QPendiente, 
                         CASE dbo.tbOrdenFabricacionOrigen.TipoOrigen WHEN 0 THEN dbo.tbOrdenFabricacionOrigen.NOrigen ELSE NULL END AS IdPedido, dbo.tbOrdenFabricacion.Estado, dbo.tbOrdenFabricacion.FechaInicio, 
                         dbo.tbOrdenFabricacion.FechaFin, dbo.tbOrdenFabricacionOrigen.TipoOrigen, dbo.tbOrdenFabricacion.FechaCreacion, dbo.tbOrdenFabricacion.IDCentroGestion, dbo.tbOrdenFabricacion.IDAlmacen, 
                         dbo.xPrintingAuxiliarTable.IdProcess, dbo.xPrintingAuxiliarTable.NumberOfCopies, dbo.tbOrdenFabricacion.IDLineaPedidoOrigen, CAST(dbo.tbPedidoVentaCabecera.NPedido AS nvarchar) 
                         + '/' + CAST(dbo.tbPedidoVentaLinea.IdOrdenLinea AS nvarchar) AS PedidoOrigenDesc,
                             (SELECT        STRING_AGG(LEFT(dbo.tbMaestroCentro.DescCentro, 3), ',') AS Expr1
                               FROM            dbo.tbOrdenRuta INNER JOIN
                                                         dbo.tbMaestroCentro ON dbo.tbOrdenRuta.IDCentro = dbo.tbMaestroCentro.IDCentro
                               WHERE        (dbo.tbOrdenRuta.NOrden = dbo.tbOrdenFabricacion.NOrden) AND (dbo.tbOrdenRuta.Cerrada = 0)) AS CFases, dbo.tbOrdenFabricacion.Reproceso,
                             (SELECT        TOP (1) CONVERT(varchar, FechaEntrega, 103) AS Expr1
                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1
                               ORDER BY FechaEntrega) AS [Fecha Req Cliente],
                             (SELECT        TOP (1) NPedido AS Expr1
                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1
                               ORDER BY FechaEntrega) AS [Pedido Origen],
                             (SELECT        CONVERT(varchar, DATEADD(DAY, - (2 *
                                                             (SELECT        CantOperaciones
                                                               FROM            dbo.GetSecCantOrderBySec(dbo.tbOrdenFabricacion.NOrden) AS GetSecCantOrderBySec_1)), CONVERT(DATE,
                                                             (SELECT        TOP (1) CONVERT(varchar, FechaEntrega, 103) AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1
                                                               ORDER BY FechaEntrega), 103)), 103) AS 'FechaCalculada;') AS [F Requerida Seccion],
                             (SELECT        CASE WHEN
                                                             (SELECT        COUNT(DescCliente) AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1) > 1 THEN 'Varios' ELSE
                                                             (SELECT        TOP (1) DescCliente AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1
                                                               ORDER BY FechaEntrega) END AS Expr1) AS Cliente, dbo.tbMaestroArticuloAlmacen.StockFisico,
                             (SELECT        TOP (1) TotalTiempo
                               FROM            dbo.GetSecCantOrderBySec(dbo.tbOrdenFabricacion.NOrden) AS GetSecCantOrderBySec_2) AS TiempoPrevisto, dbo.tbOrdenFabricacion.QFabricar AS Fabricar
FROM            dbo.tbMaestroArticuloAlmacen RIGHT OUTER JOIN
                         dbo.tbMaestroArticulo ON dbo.tbMaestroArticuloAlmacen.IDArticulo = dbo.tbMaestroArticulo.IDArticulo RIGHT OUTER JOIN
                         dbo.xPrintingAuxiliarTable RIGHT OUTER JOIN
                         dbo.tbOrdenFabricacion ON dbo.xPrintingAuxiliarTable.NumericLink = dbo.tbOrdenFabricacion.IDOrden LEFT OUTER JOIN
                         dbo.tbOrdenFabricacionOrigen ON dbo.tbOrdenFabricacion.IDOrden = dbo.tbOrdenFabricacionOrigen.IDOrden ON dbo.tbMaestroArticulo.IDArticulo = dbo.tbOrdenFabricacion.IDArticulo LEFT OUTER JOIN
                         dbo.tbPedidoVentaCabecera ON dbo.tbOrdenFabricacionOrigen.NOrigen = dbo.tbPedidoVentaCabecera.NPedido LEFT OUTER JOIN
                         dbo.tbPedidoVentaLinea ON dbo.tbOrdenFabricacion.IDLineaPedidoOrigen = dbo.tbPedidoVentaLinea.IDLineaPedido
WHERE        (dbo.tbOrdenFabricacionOrigen.TipoOrigen = 0)

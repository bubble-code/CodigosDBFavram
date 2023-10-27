--Vista Creada para la nueva pantalla de Situacion Fabrica Centro
-- Original
SELECT DISTINCT 
                         0 AS Estado, 1 AS QPendiente, tbOrdenRuta_1.IDCentro, dbo.tbMaestroCentro.DescCentro, dbo.CapTeoricaDiariaPorCentro(tbOrdenRuta_1.IDCentro) AS CapacidadTeoricaDiaria, SUM(tbOrdenRuta_1.TiempoEjecUnit) 
                         AS [Carga de Trabajo], SUM(tbOrdenRuta_1.TiempoEjecUnit) * 100.0 / NULLIF
                             ((SELECT        SUM(TiempoEjecUnit) AS Expr1
                                 FROM            dbo.tbOrdenRuta AS tbOrdenRuta_2
                                 WHERE        (Desglosado = 0)), 0) AS [%]
FROM            dbo.tbOrdenFabricacion AS tbOrdenFabricacion_2 RIGHT OUTER JOIN
                             (SELECT        IDOrden, CAST(COALESCE (OFOrigen, IDOrden) AS INT) AS OFOrigen
                               FROM            dbo.tbOrdenFabricacion AS tbOrdenFabricacion_1) AS Origen ON tbOrdenFabricacion_2.IDOrden = Origen.OFOrigen RIGHT OUTER JOIN
                         dbo.tbOrdenRuta AS tbOrdenRuta_1 INNER JOIN
                         dbo.tbOrdenFabricacion ON tbOrdenRuta_1.IDOrden = dbo.tbOrdenFabricacion.IDOrden INNER JOIN
                         dbo.tbMaestroCentro ON tbOrdenRuta_1.IDCentro = dbo.tbMaestroCentro.IDCentro INNER JOIN
                         dbo.tbMaestroArticulo ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticulo.IDArticulo ON Origen.IDOrden = dbo.tbOrdenFabricacion.IDOrden LEFT OUTER JOIN
                         dbo.tbMaestroArticuloAlmacen ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticuloAlmacen.IDArticulo AND dbo.tbOrdenFabricacion.IDAlmacen = dbo.tbMaestroArticuloAlmacen.IDAlmacen
WHERE        (tbOrdenRuta_1.Desglosado = 0)
GROUP BY tbOrdenRuta_1.IDCentro, dbo.tbMaestroCentro.DescCentro






SELECT DISTINCT 
                         dbo.tbOrdenFabricacion.IDOrden, dbo.tbOrdenFabricacion.IDArticulo, dbo.tbOrdenFabricacion.NOrden, CASE WHEN (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) 
                         < 0 THEN 0 ELSE (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) END AS QPendiente, dbo.tbOrdenFabricacion.Estado, CONVERT(varchar, dbo.tbOrdenRuta.FechaInicio, 103) AS FechaInicio, CONVERT(varchar, 
                         dbo.tbOrdenRuta.FechaFin, 103) AS FechaFin, dbo.tbOrdenFabricacion.FechaCreacion, dbo.tbOrdenFabricacion.IDAlmacen, dbo.tbOrdenRuta.DescOperacion, dbo.tbOrdenRuta.IDCentro, dbo.tbMaestroCentro.DescCentro, 
                         dbo.tbOrdenRuta.Desglosado, dbo.tbOrdenRuta.QFabricar AS Fabricar, dbo.tbOrdenRuta.QBuena AS Fabricada, dbo.tbMaestroArticuloAlmacen.StockFisico, dbo.tbMaestroArticulo.DescArticulo, dbo.tbOrdenRuta.TiempoEjecUnit, 
                         dbo.tbOrdenRuta.UdTiempoEjec, CASE WHEN (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) < 0 THEN 0 ELSE (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) 
                         END * dbo.tbOrdenRuta.TiempoEjecUnit AS Tiempo, dbo.fUnidadTiempo(dbo.tbOrdenRuta.UdTiempoEjec) AS UnidadTiempo, dbo.tbOrdenRuta.IDOrdenRuta, dbo.tbOrdenRuta.UdTiempoPrep, dbo.tbOrdenRuta.TiempoPrep, 
                         CASE WHEN dbo.tbMaestroArticuloAlmacen.LoteMinimo = 0 THEN 1 ELSE dbo.tbMaestroArticuloAlmacen.LoteMinimo END AS Lote, CASE WHEN (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) 
                         < 0 THEN 0 ELSE (dbo.tbOrdenRuta.QFabricar - dbo.tbOrdenRuta.QBuena) / (CASE WHEN dbo.tbMaestroArticuloAlmacen.LoteMinimo = 0 THEN 1 ELSE dbo.tbMaestroArticuloAlmacen.LoteMinimo END) 
                         END * dbo.tbOrdenRuta.TiempoPrep AS TiempoPreparacion, dbo.fUnidadTiempo(dbo.tbOrdenRuta.UdTiempoPrep) AS UnidadTiempoPreparacion, tbOrdenFabricacion_2.NOrden AS NOrdenOrigen, dbo.tbOrdenRuta.Secuencia,
                             (SELECT        TOP (1) IDOperacion
                               FROM            dbo.tbOrdenRuta AS tbor1
                               WHERE        (IDOrden = dbo.tbOrdenRuta.IDOrden) AND (Secuencia < dbo.tbOrdenRuta.Secuencia)
                               ORDER BY Secuencia DESC) AS SecAnterior,
                             (SELECT        SUM(QBuena) AS Expr1
                               FROM            dbo.tbOFControl
                               WHERE        (IdOrdenRuta =
                                                             (SELECT        TOP (1) IDOrdenRuta
                                                               FROM            dbo.tbOrdenRuta AS tbor2
                                                               WHERE        (IDOrden = dbo.tbOrdenRuta.IDOrden) AND (Secuencia < dbo.tbOrdenRuta.Secuencia)
                                                               ORDER BY Secuencia DESC))) AS QSecAnterior,
                             (SELECT        CASE WHEN
                                                             (SELECT        TOP (1) DescCliente AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1) IS NULL THEN 'No Cliente' WHEN
                                                             (SELECT        COUNT(DescCliente) AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1) > 1 THEN 'Varios' ELSE
                                                             (SELECT        TOP (1) DescCliente AS Expr1
                                                               FROM            dbo.GetNOrigenFechaDeOFabri(dbo.tbOrdenFabricacion.IDOrden) AS GetNOrigenFechaDeOFabri_1
                                                               ORDER BY FechaEntrega) END AS Expr1) AS Cliente, dbo.tbMaestroArticuloAlmacen.StockSeguridad,
                             (SELECT        TOP (1) FechaEntrega
                               FROM            dbo.al_fecha_entrega_y_nota_linea_pedido(dbo.tbOrdenFabricacion.IDArticulo, dbo.tbOrdenFabricacion.IDOrden) AS FechaEntrega) AS [Fecha Req Cliente],
                             (SELECT        CONVERT(varchar,
                                                             (SELECT        TOP (1) Texto
                                                               FROM            dbo.al_fecha_entrega_y_nota_linea_pedido(dbo.tbOrdenFabricacion.IDArticulo, dbo.tbOrdenFabricacion.IDOrden) AS al_fecha_entrega_y_nota_linea_pedido_1)) AS nn) AS NotaLinea, 
                         dbo.fALTAIGetOperacion(dbo.tbOrdenFabricacion.NOrden) AS CFases
FROM            dbo.tbOrdenFabricacion AS tbOrdenFabricacion_2 RIGHT OUTER JOIN
                             (SELECT        IDOrden, CAST(COALESCE (OFOrigen, IDOrden) AS INT) AS OFOrigen
                               FROM            dbo.tbOrdenFabricacion AS tbOrdenFabricacion_1) AS Origen ON tbOrdenFabricacion_2.IDOrden = Origen.OFOrigen RIGHT OUTER JOIN
                         dbo.tbOrdenRuta INNER JOIN
                         dbo.tbOrdenFabricacion ON dbo.tbOrdenRuta.IDOrden = dbo.tbOrdenFabricacion.IDOrden INNER JOIN
                         dbo.tbMaestroCentro ON dbo.tbOrdenRuta.IDCentro = dbo.tbMaestroCentro.IDCentro INNER JOIN
                         dbo.tbMaestroArticulo ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticulo.IDArticulo ON Origen.IDOrden = dbo.tbOrdenFabricacion.IDOrden LEFT OUTER JOIN
                         dbo.tbMaestroArticuloAlmacen ON dbo.tbOrdenFabricacion.IDArticulo = dbo.tbMaestroArticuloAlmacen.IDArticulo AND dbo.tbOrdenFabricacion.IDAlmacen = dbo.tbMaestroArticuloAlmacen.IDAlmacen
WHERE        (dbo.tbOrdenRuta.Desglosado = 0)

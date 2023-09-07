USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  UserDefinedFunction [dbo].[GetNOrigenFechaDeOFabri]    Script Date: 07/09/2023 13:46:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon, Alejandro
-- Create date: 05/09/2023
-- Description:	Funcion que obtiene el o los origenes de la orden de fabricacion en la pantalla control situacion fabrica
--				y pora hacer los test tambien se obtienen los origenes
-- =============================================
ALTER FUNCTION [dbo].[GetNOrigenFechaDeOFabri](@IDOrdenInicial INT)
RETURNS TABLE 
AS
RETURN 
(
	with
    recursiva
    as
    (
        /*select IDOrdenOrigen, IDOrden, TipoOrigen, NOrigen,IDOrigen from tbOrdenFabricacionOrigen where IDOrden = @IDOrdenInicial
	Union all
	select tbOrigen.IDOrdenOrigen,tbOrigen.IDOrden,tbOrigen.TipoOrigen, tbOrigen.NOrigen,tbOrigen.IDOrigen from tbOrdenFabricacionOrigen as tbOrigen
	inner join recursiva as r on r.IDOrigen=tbOrigen.IDOrden
	where r.TipoOrigen<>0
	*/
                    select IDOrden, TipoOrigen, NOrigen
            from tbOrdenFabricacionOrigen
            where (TipoOrigen = 0) and IDOrden = @IDOrdenInicial
        union all
            select o.IDOrden, o2.TipoOrigen, o2.NOrigen
            from tbOrdenFabricacionOrigen as o INNER JOIN
                tbOrdenFabricacionOrigen as o2 on o.IDOrigen = o2.IDOrden
            where o.IDOrden = @IDOrdenInicial
    )
	select pc.FechaEntrega, pc.NPedido, c.DescCliente
from tbPedidoVentaCabecera as pc
    inner join
    tbMaestroCliente c ON pc.IDCliente = c.IDCliente
where pc.NPedido in (
	select NOrigen
from recursiva
    )
)


USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSecCantOrderBySec]    Script Date: 07/09/2023 13:46:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon,Alejandro
-- Create date: 07-09-2023
-- Description:	Funcion para Obtener un FSecuenciad, CantOperaciones,TotalTiempo todo con la condicion de que no este cerrada o que la cantidad de buenas = o > que la cantidad a fabricar
-- =============================================
ALTER FUNCTION [dbo].[GetSecCantOrderBySec] (@NOrden nvarchar(25))
RETURNS TABLE 
AS
RETURN 
(
	SELECT STRING_AGG(LEFT (c.DescCentro, 3), ',') AS Secuencias, COUNT(*) AS CantOperaciones,
	SUM
	(
	case when r.CantidadTiempo<>9999 then round(r.TiempoEjecUnit*r.QFabricar,1,0)
	else 0
	end
	)
	as TotalTiempo
	FROM dbo.tbOrdenRuta AS r INNER JOIN dbo.tbMaestroCentro AS c ON r.IDCentro = c.IDCentro WHERE (r.NOrden = @NOrden) AND (r.Cerrada = 0 or r.QBuena >= r.QFabricar)
)

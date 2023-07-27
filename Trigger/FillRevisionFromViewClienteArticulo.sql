USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  Trigger [dbo].[UpPF2]    Script Date: 7/27/2023 9:22:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon, Alejandro
-- Create date: 27/07/2023
-- Description:	Al actualizar la vista ViewClienteArticulo se rellena el campo revision desde las lineas de articulos que se obtienen de la vista 
--               la entidad es ViewClienteArticulo
-- =============================================
ALTER TRIGGER   [dbo].[UpPF2]
   ON  [dbo].[ViewClienteArticulo]
   instead of insert, update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
    -- Insert statements for trigger here
	UPDATE tbMaestroArticulo SET NivelModificacionPlan = (SELECT Revision from tbArticuloCliente)

END

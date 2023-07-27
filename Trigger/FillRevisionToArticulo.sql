USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  Trigger [dbo].[UpPF]    Script Date: 7/27/2023 9:13:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon, Alejandro
-- Create date: 27/07/2023
-- Description:	Al crear o actualizar un articulo-cliente se rellena el campo revision que viene de los datos insertados 
--               la entidad es tbArticuloCliente
-- =============================================
ALTER TRIGGER [dbo].[UpPF] 
   ON  [dbo].[tbArticuloCliente]
   AFTER INSERT, UPDATE 
   	
AS 


    -- Insert statements for trigger here
	UPDATE tbMaestroArticulo SET NivelModificacionPlan = (SELECT Revision from inserted)

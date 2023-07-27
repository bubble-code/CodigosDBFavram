USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  Trigger [dbo].[CopyTextToObservaciones]    Script Date: 7/27/2023 9:31:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon, Alejandro
-- Create date: 27/07/2023
-- Description:	Al insertar, actualizar, borrar se copiara en la tabla tbOrdenRuta el texto que biene de tbAlbaranCompraLinea.Texto
-- =============================================
ALTER TRIGGER [dbo].[CopyTextToObservaciones] 
   ON  [dbo].[tbAlbaranCompraLinea]
   AFTER  INSERT,DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--UPDATE into tbOrdenRuta set Observaciones (select text from tbAlbaranCompraLinea)
    -- Insert statements for trigger here
	UPDATE       tbOrdenRuta
SET     Observaciones = tbAlbaranCompraLinea.Texto
FROM            tbAlbaranCompraLinea INNER JOIN
                         tbOrdenRuta ON tbAlbaranCompraLinea.IDOrdenRuta = tbOrdenRuta.IDOrdenRuta
WHERE        (tbAlbaranCompraLinea.Texto IS NOT NULL)

END

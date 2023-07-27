USE [SolmicroERP6_PruebasSub]
GO
/****** Object:  Trigger [dbo].[FillRevision]    Script Date: 7/27/2023 8:09:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Obregon, Alejandro
-- Create date: 27/07/2023
-- Description:	Al crear un nuevo Pedido de compra, tanto desde MRP Compra o de forma manual se ejecutará este TRIGGER para rellenar el campo REVISION
--              que se captura desde la entidad tbArticuloCliente, por lo tanto, el artículo debe tener un cliente con una REVISION asignada, Se creará un Cliente FAVRAM para
--              los artículos materias primas, subcontratación, trabajos externos para poder asignarle una REVISION
-- =============================================
ALTER TRIGGER [dbo].[FillRevision]
   ON [dbo].[tbPedidoCompraLinea]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE tbPedidoCompraLinea
    SET tbPedidoCompraLinea.Revision = tbArticuloCliente.Revision
    FROM tbPedidoCompraLinea
    INNER JOIN tbArticuloCliente ON tbPedidoCompraLinea.IDArticulo = tbArticuloCliente.IDArticulo
    WHERE tbPedidoCompraLinea.IDLineaPedido = (SELECT IDLineaPedido FROM inserted);

    -- Insert statements for trigger here

END

-- Se crea un campo nuevo llamado Gravedad para guardar en el el tipo de gravedad de la incidencia que se hidrata de una nueva tabla 
-- creada llamada tbGravedadTipo con dos campos idTipoGravedad, TipoGravedad
USE [SolmicroERP6_PruebasSub]
GO

 

/****** Object:  Table [dbo].[tbIncidenciaInterna]    Script Date: 30/08/2023 8:39:57 ******/
SET ANSI_NULLS ON
GO

 

SET QUOTED_IDENTIFIER ON
GO

 

CREATE TABLE [dbo].[tbIncidenciaInterna](
    [IDIncidencia] [nvarchar](25) NOT NULL,
    [IDContador] [nvarchar](10) NULL,
    [DescIncidencia] [nvarchar](2000) NULL,
    [FechaIncidencia] [datetime] NULL,
    [IDResponsable] [nvarchar](10) NULL,
    [Texto] [nvarchar](2000) NULL,
    [IDCliente] [nvarchar](25) NULL,
    [IDAlbaran] [int] NULL,
    [IDArticulo] [nvarchar](25) NOT NULL,
    [IDOrden] [int] NULL,
    [IDLocalizacion] [nvarchar](10) NOT NULL,
    [QRecepcionada] [numeric](23, 8) NOT NULL,
    [QRecuperada] [numeric](23, 8) NOT NULL,
    [QRechazada] [numeric](23, 8) NOT NULL,
    [QPieza] [numeric](23, 8) NOT NULL,
    [PrecioPieza] [numeric](23, 8) NOT NULL,
    [QTiempoSeleccion] [numeric](23, 8) NOT NULL,
    [PrecioSeleccion] [numeric](23, 8) NOT NULL,
    [QTiempoRecuperacion] [numeric](23, 8) NOT NULL,
    [PrecioRecuperacion] [numeric](23, 8) NOT NULL,
    [CosteTransporte] [numeric](23, 8) NOT NULL,
    [OtrosCostes] [numeric](23, 8) NOT NULL,
    [TextoRecuperacion] [nvarchar](1000) NULL,
    [IDCausa] [nvarchar](10) NULL,
    [IDCuenta] [nvarchar](10) NULL,
    [ControladoCalidad] [bit] NOT NULL,
    [ControladoAdmon] [bit] NOT NULL,
    [ImporteAbono] [numeric](23, 8) NOT NULL,
    [Cerrada] [bit] NOT NULL,
    [TextoCierre] [nvarchar](1000) NULL,
    [FechaCierre] [datetime] NULL,
    [IDOrdenRuta] [int] NULL,
    [IDIncidenciaProveedor] [nvarchar](25) NULL,
    [FechaCreacionAudi] [datetime] NULL,
    [FechaModificacionAudi] [datetime] NULL,
    [UsuarioAudi] [nvarchar](75) NULL,
    [Lote] [nvarchar](25) NULL,
    [IDCentro] [nvarchar](25) NULL,
    [IDOperario] [nvarchar](10) NULL,
    [IDAlbaranDevolucion] [int] NULL,
    [SuReclamacion] [nvarchar](25) NULL,
    [Ubicacion] [nvarchar](25) NULL,
    [IDLineaAlbaran] [int] NULL,
    [IDCausaRechazo] [nvarchar](10) NULL,
    [IDOrdenReproceso] [int] NULL,
    [UsuarioCreacionAudi] [nvarchar](75) NULL,
    [Gravedad] [nvarchar](75) NULL,
CONSTRAINT [PK_tbIncidenciaInterna] PRIMARY KEY CLUSTERED 
(
    [IDIncidencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QRecepcionada]  DEFAULT ((0)) FOR [QRecepcionada]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QRecuperada]  DEFAULT ((0)) FOR [QRecuperada]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QRechazada]  DEFAULT ((0)) FOR [QRechazada]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QPieza]  DEFAULT ((0)) FOR [QPieza]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_PrecioPieza]  DEFAULT ((0)) FOR [PrecioPieza]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QTiempoSeleccion]  DEFAULT ((0)) FOR [QTiempoSeleccion]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_PrecioSeleccion]  DEFAULT ((0)) FOR [PrecioSeleccion]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_QTiempoRecuperacion]  DEFAULT ((0)) FOR [QTiempoRecuperacion]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_PrecioRecuperacion]  DEFAULT ((0)) FOR [PrecioRecuperacion]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_CosteTransporte]  DEFAULT ((0)) FOR [CosteTransporte]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_OtrosCostes]  DEFAULT ((0)) FOR [OtrosCostes]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_ControladoCalidad]  DEFAULT ((0)) FOR [ControladoCalidad]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_ControladoAdmon]  DEFAULT ((0)) FOR [ControladoAdmon]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_ImporteAbono]  DEFAULT ((0)) FOR [ImporteAbono]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] ADD  CONSTRAINT [DF_tbIncidenciaInterna_Cerrada]  DEFAULT ((0)) FOR [Cerrada]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbAlbaranVentaCabecera] FOREIGN KEY([IDAlbaran])
REFERENCES [dbo].[tbAlbaranVentaCabecera] ([IDAlbaran])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbAlbaranVentaCabecera]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbAlbaranVentaCabecera1] FOREIGN KEY([IDAlbaranDevolucion])
REFERENCES [dbo].[tbAlbaranVentaCabecera] ([IDAlbaran])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbAlbaranVentaCabecera1]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroArticulo] FOREIGN KEY([IDArticulo])
REFERENCES [dbo].[tbMaestroArticulo] ([IDArticulo])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroArticulo]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCausaNoCalidad] FOREIGN KEY([IDCausa])
REFERENCES [dbo].[tbMaestroCausaNoCalidad] ([IDCausa])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCausaNoCalidad]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCentro] FOREIGN KEY([IDCentro])
REFERENCES [dbo].[tbMaestroCentro] ([IDCentro])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCentro]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCliente] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[tbMaestroCliente] ([IDCliente])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCliente]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCuentaNoCalidad] FOREIGN KEY([IDCuenta])
REFERENCES [dbo].[tbMaestroCuentaNoCalidad] ([IDCuenta])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroCuentaNoCalidad]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroLocalizacion] FOREIGN KEY([IDLocalizacion])
REFERENCES [dbo].[tbMaestroLocalizacion] ([IDLocalizacion])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroLocalizacion]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroOperario] FOREIGN KEY([IDOperario])
REFERENCES [dbo].[tbMaestroOperario] ([IDOperario])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroOperario]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroResponsable] FOREIGN KEY([IDResponsable])
REFERENCES [dbo].[tbMaestroResponsable] ([IDResponsable])
NOT FOR REPLICATION 
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbMaestroResponsable]
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna]  WITH NOCHECK ADD  CONSTRAINT [FK_tbIncidenciaInterna_tbOrdenFabricacion] FOREIGN KEY([IDOrden])
REFERENCES [dbo].[tbOrdenFabricacion] ([IDOrden])
GO

 

ALTER TABLE [dbo].[tbIncidenciaInterna] CHECK CONSTRAINT [FK_tbIncidenciaInterna_tbOrdenFabricacion]
GO
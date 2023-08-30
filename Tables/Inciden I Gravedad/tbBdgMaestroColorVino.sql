-- Se adiciona un campo "TipoGravedad" para usar esta entidad en el formulario de Incidencia Interna en el campo de busqueda
-- donde se seleccionara el tipo de gravedad que luego se guardara en la tabla tbIncidenciaInterna

USE [SolmicroERP6_PruebasSub]
GO

 

/****** Object:  Table [dbo].[tbBdgMaestroColorVino]    Script Date: 30/08/2023 9:57:52 ******/
SET ANSI_NULLS ON
GO

 

SET QUOTED_IDENTIFIER ON
GO

 

CREATE TABLE [dbo].[tbBdgMaestroColorVino](
    [IDColorVino] [nvarchar](10) NOT NULL,
    [DescColorVino] [nvarchar](300) NOT NULL,
    [IDConfig] [nvarchar](10) NULL,
    [DescConfig] [nvarchar](300) NULL,
    [TipoVariedad] [int] NOT NULL,
    [FechaCreacionAudi] [datetime] NULL,
    [FechaModificacionAudi] [datetime] NULL,
    [UsuarioAudi] [nvarchar](75) NULL,
    [Color] [int] NULL,
    [UsuarioCreacionAudi] [nvarchar](75) NULL,
    [TipoGravedad] [nvarchar](75) NULL,
CONSTRAINT [PK_tbBdgMaestroColorVino] PRIMARY KEY CLUSTERED 
(
    [IDColorVino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

 

ALTER TABLE [dbo].[tbBdgMaestroColorVino] ADD  CONSTRAINT [DF_tbBdgMaestroColorVino_TipoVariedad]  DEFAULT ((0)) FOR [TipoVariedad]
GO
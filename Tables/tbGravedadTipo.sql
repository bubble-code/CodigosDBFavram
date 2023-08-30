-- Tabla creada para guardar el tipo de gravedad de cada incidencia, que luego hidratara la tabla tbIncidenciaInterna
--  el campo Gravedad

Create Tabla [dbo].[tbGravedadTipo](
    [idTipoGravedad] [dbo].[Autonumerico] NOT NULL,
    [TipoGravedad] [nvarchar](75) NOT NULL
) ON [PRIMARY]

GO
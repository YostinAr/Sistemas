USE [master]
GO
/****** Object:  Database [BDJN]    Script Date: 4/9/2024 13:50:08 ******/
CREATE DATABASE [BDJN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BDJN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BDJN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BDJN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BDJN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BDJN] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BDJN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BDJN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BDJN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BDJN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BDJN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BDJN] SET ARITHABORT OFF 
GO
ALTER DATABASE [BDJN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BDJN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BDJN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BDJN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BDJN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BDJN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BDJN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BDJN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BDJN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BDJN] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BDJN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BDJN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BDJN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BDJN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BDJN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BDJN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BDJN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BDJN] SET RECOVERY FULL 
GO
ALTER DATABASE [BDJN] SET  MULTI_USER 
GO
ALTER DATABASE [BDJN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BDJN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BDJN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BDJN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BDJN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BDJN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BDJN', N'ON'
GO
ALTER DATABASE [BDJN] SET QUERY_STORE = ON
GO
ALTER DATABASE [BDJN] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BDJN]
GO
/****** Object:  Table [dbo].[TArticulo]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TArticulo](
	[IdArticulo] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](250) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_TArticulo] PRIMARY KEY CLUSTERED 
(
	[IdArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCarrito](
	[IdCarrito] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_TCarrito] PRIMARY KEY CLUSTERED 
(
	[IdCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TDetalle]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TDetalle](
	[IdDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdFactura] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Impuesto] [decimal](18, 2) NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TDetalle] PRIMARY KEY CLUSTERED 
(
	[IdDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TEncabezado]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEncabezado](
	[IdFactura] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[TotalPago] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TEncabezado] PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TProducto]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProducto](
	[IdProducto] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](250) NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_TProducto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TProvincia]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProvincia](
	[ConProvincia] [bigint] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TProvincia] PRIMARY KEY CLUSTERED 
(
	[ConProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRol]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRol](
	[ConRol] [bigint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TRol] PRIMARY KEY CLUSTERED 
(
	[ConRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TUsuario]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUsuario](
	[IdUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[identificacion] [varchar](20) NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[usuario] [varchar](25) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[contrasenna] [varchar](25) NOT NULL,
	[estado] [bit] NOT NULL,
	[esClaveTemp] [bit] NOT NULL,
	[vencimientoClaveTemp] [datetime] NOT NULL,
	[ConRol] [bigint] NOT NULL,
	[ConProvincia] [bigint] NOT NULL,
 CONSTRAINT [PK_TUsuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TCarrito] ON 

INSERT [dbo].[TCarrito] ([IdCarrito], [IdUsuario], [IdProducto], [Cantidad], [Fecha]) VALUES (10002, 6, 31, 1, CAST(N'2024-06-26T14:13:05.437' AS DateTime))
INSERT [dbo].[TCarrito] ([IdCarrito], [IdUsuario], [IdProducto], [Cantidad], [Fecha]) VALUES (20003, 2, 31, 3, CAST(N'2024-09-04T12:46:12.363' AS DateTime))
SET IDENTITY_INSERT [dbo].[TCarrito] OFF
GO
SET IDENTITY_INSERT [dbo].[TDetalle] ON 

INSERT [dbo].[TDetalle] ([IdDetalle], [IdFactura], [IdProducto], [Cantidad], [Impuesto], [Precio]) VALUES (10012, 13, 31, 10, CAST(26000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[TDetalle] ([IdDetalle], [IdFactura], [IdProducto], [Cantidad], [Impuesto], [Precio]) VALUES (10013, 14, 31, 0, CAST(26000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[TDetalle] ([IdDetalle], [IdFactura], [IdProducto], [Cantidad], [Impuesto], [Precio]) VALUES (10014, 14, 30, 1, CAST(19500.00 AS Decimal(18, 2)), CAST(150000.00 AS Decimal(18, 2)))
INSERT [dbo].[TDetalle] ([IdDetalle], [IdFactura], [IdProducto], [Cantidad], [Impuesto], [Precio]) VALUES (10015, 15, 30, 1, CAST(19500.00 AS Decimal(18, 2)), CAST(150000.00 AS Decimal(18, 2)))
INSERT [dbo].[TDetalle] ([IdDetalle], [IdFactura], [IdProducto], [Cantidad], [Impuesto], [Precio]) VALUES (10016, 15, 31, 2, CAST(26000.00 AS Decimal(18, 2)), CAST(200000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TDetalle] OFF
GO
SET IDENTITY_INSERT [dbo].[TEncabezado] ON 

INSERT [dbo].[TEncabezado] ([IdFactura], [IdUsuario], [FechaPago], [TotalPago]) VALUES (13, 7, CAST(N'2023-12-07T21:07:58.327' AS DateTime), CAST(2260000.00 AS Decimal(18, 2)))
INSERT [dbo].[TEncabezado] ([IdFactura], [IdUsuario], [FechaPago], [TotalPago]) VALUES (14, 6, CAST(N'2024-06-14T10:10:47.423' AS DateTime), CAST(169500.00 AS Decimal(18, 2)))
INSERT [dbo].[TEncabezado] ([IdFactura], [IdUsuario], [FechaPago], [TotalPago]) VALUES (15, 6, CAST(N'2024-06-14T10:12:41.450' AS DateTime), CAST(621500.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TEncabezado] OFF
GO
SET IDENTITY_INSERT [dbo].[TProducto] ON 

INSERT [dbo].[TProducto] ([IdProducto], [Nombre], [Descripcion], [Precio], [Cantidad], [Estado]) VALUES (30, N'PC Lenovo', N'256 RAM ', CAST(150000.00 AS Decimal(18, 2)), 4, 1)
INSERT [dbo].[TProducto] ([IdProducto], [Nombre], [Descripcion], [Precio], [Cantidad], [Estado]) VALUES (31, N'PC DELL', N'512 RAM ', CAST(200000.00 AS Decimal(18, 2)), 13, 1)
SET IDENTITY_INSERT [dbo].[TProducto] OFF
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (0, N'Seleccione')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (1, N'San José')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (2, N'Alajuela')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (3, N'Cartago')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (4, N'Heredia')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (5, N'Guanacaste')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (6, N'Puntarenas')
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (7, N'Limón')
GO
SET IDENTITY_INSERT [dbo].[TRol] ON 

INSERT [dbo].[TRol] ([ConRol], [Descripcion]) VALUES (1, N'Administrador')
INSERT [dbo].[TRol] ([ConRol], [Descripcion]) VALUES (2, N'Usuario')
SET IDENTITY_INSERT [dbo].[TRol] OFF
GO
SET IDENTITY_INSERT [dbo].[TUsuario] ON 

INSERT [dbo].[TUsuario] ([IdUsuario], [identificacion], [nombre], [usuario], [correo], [contrasenna], [estado], [esClaveTemp], [vencimientoClaveTemp], [ConRol], [ConProvincia]) VALUES (2, N'118030130', N'RAMIREZ ALVAREZ HENRY SANTIAGO', N'hramirez', N'hramirez30130@ufide.ac.cr', N'30130', 1, 0, CAST(N'2023-10-19T19:01:19.203' AS DateTime), 1, 6)
INSERT [dbo].[TUsuario] ([IdUsuario], [identificacion], [nombre], [usuario], [correo], [contrasenna], [estado], [esClaveTemp], [vencimientoClaveTemp], [ConRol], [ConProvincia]) VALUES (6, N'304590415', N'CALVO CASTILLO EDUARDO JOSE', N'ecalvo90415', N'ecalvo90415@ufide.ac.cr', N'90415', 1, 0, CAST(N'2023-11-02T20:11:43.237' AS DateTime), 2, 7)
INSERT [dbo].[TUsuario] ([IdUsuario], [identificacion], [nombre], [usuario], [correo], [contrasenna], [estado], [esClaveTemp], [vencimientoClaveTemp], [ConRol], [ConProvincia]) VALUES (7, N'116240337', N'PEREZ SANCHEZ LUIS DANIEL', N'lperez', N'lperez40337@ufide.ac.cr', N'40337', 1, 0, CAST(N'2023-11-16T18:13:02.380' AS DateTime), 2, 0)
SET IDENTITY_INSERT [dbo].[TUsuario] OFF
GO
ALTER TABLE [dbo].[TCarrito]  WITH CHECK ADD  CONSTRAINT [FK_TCarrito_TProducto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[TProducto] ([IdProducto])
GO
ALTER TABLE [dbo].[TCarrito] CHECK CONSTRAINT [FK_TCarrito_TProducto]
GO
ALTER TABLE [dbo].[TCarrito]  WITH CHECK ADD  CONSTRAINT [FK_TCarrito_TUsuario1] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[TUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[TCarrito] CHECK CONSTRAINT [FK_TCarrito_TUsuario1]
GO
ALTER TABLE [dbo].[TDetalle]  WITH CHECK ADD  CONSTRAINT [FK_TDetalle_TDetalle] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[TEncabezado] ([IdFactura])
GO
ALTER TABLE [dbo].[TDetalle] CHECK CONSTRAINT [FK_TDetalle_TDetalle]
GO
ALTER TABLE [dbo].[TDetalle]  WITH CHECK ADD  CONSTRAINT [FK_TDetalle_TProducto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[TProducto] ([IdProducto])
GO
ALTER TABLE [dbo].[TDetalle] CHECK CONSTRAINT [FK_TDetalle_TProducto]
GO
ALTER TABLE [dbo].[TEncabezado]  WITH CHECK ADD  CONSTRAINT [FK_TEncabezado_TUsuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[TUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[TEncabezado] CHECK CONSTRAINT [FK_TEncabezado_TUsuario]
GO
ALTER TABLE [dbo].[TUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TUsuario_TProvincia] FOREIGN KEY([ConProvincia])
REFERENCES [dbo].[TProvincia] ([ConProvincia])
GO
ALTER TABLE [dbo].[TUsuario] CHECK CONSTRAINT [FK_TUsuario_TProvincia]
GO
ALTER TABLE [dbo].[TUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TUsuario_TRol] FOREIGN KEY([ConRol])
REFERENCES [dbo].[TRol] ([ConRol])
GO
ALTER TABLE [dbo].[TUsuario] CHECK CONSTRAINT [FK_TUsuario_TRol]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarClaveTemporal]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarClaveTemporal]
	@IdUsuario				bigint,
	@contrasennaTemporal	varchar(4)
AS
BEGIN

	UPDATE dbo.TUsuario
	SET contrasenna = @contrasennaTemporal,
		esClaveTemp = 1,
        vencimientoClaveTemp = DATEADD(mi,30,GETDATE())
	WHERE IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCuenta]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarCuenta]
	@identificacion varchar(20),
	@nombre varchar(200),
	@usuario varchar(25),
	@correo varchar(50),
	@ConProvincia bigint,
	@IdUsuario bigint
AS
BEGIN
	
	UPDATE	TUsuario
	   SET	identificacion = @identificacion,
			nombre = @nombre,
			usuario = @usuario,
			correo = @correo,
			ConProvincia = @ConProvincia
	 WHERE	IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEstadoArticulo]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarEstadoArticulo]
	@IdArticulo BIGINT
AS
BEGIN

	UPDATE	TArticulo
	SET		Estado = (CASE WHEN Estado = 1 THEN 0 ELSE 1 END)
	WHERE	IdArticulo = @IdArticulo

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEstadoProducto]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarEstadoProducto]
	@IdProducto BIGINT
AS
BEGIN

	UPDATE	TProducto
	SET		Estado = (CASE WHEN Estado = 1 THEN 0 ELSE 1 END)
	WHERE	IdProducto = @IdProducto

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEstadoUsuario]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarEstadoUsuario]
	@IdUsuario BIGINT
AS
BEGIN

	UPDATE	TUsuario
	SET		estado = (CASE WHEN estado = 1 THEN 0 ELSE 1 END)
	WHERE	IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarProducto]
	@Nombre varchar(50),
	@Descripcion varchar(250),
	@Precio decimal(18,2),
	@Cantidad int,
	@IdProducto bigint
AS
BEGIN
	
	UPDATE	dbo.TProducto
	   SET	Nombre = @Nombre,
		  	Descripcion = @Descripcion,
		  	Precio = @Precio,
		  	Cantidad = @Cantidad
	 WHERE	IdProducto = @IdProducto

END
GO
/****** Object:  StoredProcedure [dbo].[CambiarClave]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CambiarClave]
	@IdUsuario				bigint,
	@contrasennaAnterior	varchar(25),
	@contrasenna			varchar(25)
AS
BEGIN

	IF EXISTS(SELECT IdUsuario
			  FROM	 dbo.TUsuario
			  WHERE	IdUsuario = @IdUsuario
				AND contrasenna = @contrasennaAnterior)
	BEGIN

		UPDATE dbo.TUsuario
		SET contrasenna = @contrasenna
		WHERE IdUsuario = @IdUsuario

	END

END
GO
/****** Object:  StoredProcedure [dbo].[CambiarClaveCuenta]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CambiarClaveCuenta]
	@IdUsuario				bigint,
	@contrasennaTemporal	varchar(4),
	@contrasenna			varchar(25)
AS
BEGIN

	IF EXISTS(SELECT IdUsuario
			  FROM	 dbo.TUsuario
			  WHERE	IdUsuario = @IdUsuario
				AND contrasenna = @contrasennaTemporal
				AND esClaveTemp = 1
				AND vencimientoClaveTemp >= GETDATE())
	BEGIN

		UPDATE dbo.TUsuario
		SET contrasenna = @contrasenna,
			esClaveTemp = 0,
			vencimientoClaveTemp = GETDATE()
		WHERE IdUsuario = @IdUsuario

	END

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarCarrito]
	@IdUsuario	bigint
AS
BEGIN

	SELECT	IdCarrito,
			IdUsuario,
			C.IdProducto,
			C.Cantidad,
			Fecha,
			P.Precio,
			P.Precio * C.Cantidad 'SubTotal',
			(P.Precio * C.Cantidad) * 0.13 'Impuesto',
			P.Precio * C.Cantidad + (P.Precio * C.Cantidad) * 0.13 'Total',
			P.Nombre
	FROM	dbo.TCarrito C
	INNER JOIN dbo.TProducto P ON C.IdProducto = P.IdProducto
	WHERE	IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarDetalleFactura]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarDetalleFactura]
	@IdFactura	bigint
AS
BEGIN

	SELECT	D.IdFactura,
			D.Cantidad,
			D.Precio,
			D.Impuesto,
			D.Precio * D.Cantidad	'SubTotal',
			(D.Impuesto * D.Cantidad) 'ImpuestoTotal',
			(D.Precio * D.Cantidad) + (D.Impuesto * D.Cantidad) 'Total',
			P.Nombre
	FROM	dbo.TDetalle D
	INNER JOIN dbo.TProducto P ON D.IdProducto = P.IdProducto
	WHERE	IdFactura = @IdFactura

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarFacturas]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarFacturas]
	@IdUsuario	bigint
AS
BEGIN

	SELECT	IdFactura,
			FechaPago,
			TotalPago
	FROM	dbo.TEncabezado
	WHERE	IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProductos]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarProductos]
	
AS
BEGIN
	
	SELECT  IdProducto,
			Nombre,
			Descripcion,
			Precio,
			Cantidad,
			Estado,
			'\images\' + convert(varchar,IdProducto) + '.png' 'Imagen'
	FROM	dbo.TProducto

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarProvincias]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarProvincias]
	
AS
BEGIN

	SELECT	ConProvincia 'Value',
			Descripcion 'Text'
	FROM	dbo.TProvincia

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuario]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarUsuario]
	@IdUsuario BIGINT
AS
BEGIN
	
	SELECT IdUsuario,
		   identificacion,
		   nombre,
		   usuario,
		   correo,
		   estado,
		   ConRol,
		   ConProvincia
	  FROM dbo.TUsuario
	  WHERE IdUsuario = @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarios]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarUsuarios]
	@IdUsuario BIGINT
AS
BEGIN
	
	SELECT IdUsuario,
		   identificacion,
		   nombre,
		   usuario,
		   correo,
		   estado,
		   ConRol,
		   ConProvincia
	  FROM dbo.TUsuario
	  WHERE IdUsuario != @IdUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarArticuloCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarArticuloCarrito]
	@IdCarrito AS BIGINT
AS
BEGIN
	
	DELETE FROM TCarrito
	WHERE IdCarrito = @IdCarrito

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarProductoCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarProductoCarrito]
	@IdCarrito AS BIGINT
AS
BEGIN
	
	DELETE FROM TCarrito
	WHERE IdCarrito = @IdCarrito

END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@usuario		VARCHAR(25),
	@contrasenna	VARCHAR(25)
AS
BEGIN

	SELECT	IdUsuario, nombre, identificacion, correo, usuario, estado, ConRol
	FROM	TUsuario
	WHERE	(usuario = @usuario OR correo = @usuario)
		AND contrasenna = @contrasenna
		AND estado		= 1
		AND esClaveTemp = 0

END
GO
/****** Object:  StoredProcedure [dbo].[PagarCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PagarCarrito]
	@IdUsuario AS BIGINT
AS
BEGIN
	BEGIN TRY	

		BEGIN TRANSACTION

		IF(	SELECT TOP 1 P.Cantidad - C.Cantidad
			FROM TCarrito	C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario ) < 0
		BEGIN

			DELETE	C
			FROM	TCarrito C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario
			AND		P.Cantidad = 0

			UPDATE	C
			SET		C.Cantidad = P.Cantidad
			FROM	TCarrito C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario
			AND    (P.Cantidad - C.Cantidad) < 0 

			SELECT 'No se pudo realizar la transacción, verifique las unidades de su carrito' 'Mensaje'

		END
		ELSE
		BEGIN

			DECLARE @TotalPago DECIMAL(18,2)
			DECLARE @CodigoFactura BIGINT

			SELECT	@TotalPago = SUM(P.Precio * C.Cantidad) + (SUM(P.Precio * C.Cantidad) * 0.13)
			FROM	TCarrito	C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario

			INSERT	INTO dbo.TEncabezado(IdUsuario,FechaPago,TotalPago)
			VALUES	(@IdUsuario,GETDATE(),@TotalPago)

			SET @CodigoFactura = @@IDENTITY

			INSERT	INTO dbo.TDetalle(IdFactura,IdProducto,Cantidad,Impuesto,Precio)
			SELECT	@CodigoFactura, C.IdProducto, C.Cantidad, (P.Precio * 0.13), P.Precio 
			FROM	TCarrito	C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario

			UPDATE	P
			SET		P.Cantidad -= C.Cantidad
			FROM	TCarrito	C
			INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
			WHERE	IdUsuario = @IdUsuario

			DELETE FROM TCarrito
			WHERE IdUsuario = @IdUsuario

			SELECT 'Transacción realizada correctamente' 'Mensaje'

		END

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'No se pudo realizar la transacción, verifique las unidades de su carrito' 'Mensaje'
		END
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[RecuperarCuenta]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RecuperarCuenta]
	@usuario		VARCHAR(25)
AS
BEGIN
	
	SELECT	IdUsuario, nombre, correo
	FROM	TUsuario
	WHERE	(usuario = @usuario OR correo = @usuario)
		AND estado		= 1

END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarCarrito]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RegistrarCarrito]
	@IdUsuario	bigint,
    @IdProducto	bigint,
    @Cantidad	int
AS
BEGIN
	
	IF EXISTS(SELECT 1 FROM TCarrito WHERE IdUsuario = @IdUsuario AND IdProducto = @IdProducto )
	BEGIN
		
		UPDATE dbo.TCarrito
		   SET Cantidad = @Cantidad
		 WHERE IdUsuario = @IdUsuario AND IdProducto = @IdProducto

	END
	ELSE
	BEGIN

		INSERT INTO dbo.TCarrito(IdUsuario,IdProducto,Cantidad,Fecha)
		VALUES (@IdUsuario,@IdProducto,@Cantidad,GETDATE())

	END
END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarCuenta]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RegistrarCuenta]
	@identificacion varchar(20),
	@nombre			varchar(200),
	@usuario		varchar(25),
	@correo			varchar(50),
	@contrasenna	varchar(25)
AS
BEGIN
	
	INSERT INTO TUsuario (identificacion,nombre,usuario,correo,contrasenna,estado,esClaveTemp,vencimientoClaveTemp,ConRol,ConProvincia)
    VALUES (@identificacion,@nombre,@usuario,@correo,@contrasenna,1,0,GETDATE(),2,0)

END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarProducto]    Script Date: 4/9/2024 13:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RegistrarProducto]
	@Nombre			VARCHAR(50),
    @Descripcion	VARCHAR(250),
    @Precio			DECIMAL(18,2),
    @Cantidad		INT
AS
BEGIN
	
	INSERT INTO dbo.TProducto(Nombre,Descripcion,Precio,Cantidad,Estado)
    VALUES (@Nombre,@Descripcion,@Precio,@Cantidad,1)

	SELECT @@IDENTITY 'IdProducto'

END
GO
USE [master]
GO
ALTER DATABASE [BDJN] SET  READ_WRITE 
GO

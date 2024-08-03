USE [master]
GO
/****** Object:  Database [DBEmpleado]    Script Date: 02/08/2024 20:31:10 ******/
CREATE DATABASE [DBEmpleado]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBEmpleado', FILENAME = N'L:\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBEmpleado.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBEmpleado_log', FILENAME = N'L:\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBEmpleado_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBEmpleado] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBEmpleado].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBEmpleado] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBEmpleado] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBEmpleado] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBEmpleado] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBEmpleado] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBEmpleado] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBEmpleado] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBEmpleado] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBEmpleado] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBEmpleado] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBEmpleado] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBEmpleado] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBEmpleado] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBEmpleado] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBEmpleado] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBEmpleado] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBEmpleado] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBEmpleado] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBEmpleado] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBEmpleado] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBEmpleado] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBEmpleado] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBEmpleado] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBEmpleado] SET  MULTI_USER 
GO
ALTER DATABASE [DBEmpleado] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBEmpleado] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBEmpleado] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBEmpleado] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBEmpleado] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBEmpleado] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBEmpleado] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBEmpleado] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBEmpleado]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 02/08/2024 20:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[idEmpledo] [int] IDENTITY(1,1) NOT NULL,
	[nombreCompleto] [varchar](50) NULL,
	[idDepartamento] [int] NULL,
	[sueldo] [int] NULL,
	[fechaContrato] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmpledo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (1, N'Administrador')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (2, N'Marketing')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (3, N'Ventas')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (4, N'Comercio')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
GO
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([idEmpledo], [nombreCompleto], [idDepartamento], [sueldo], [fechaContrato]) VALUES (1, N'Leo steven', 1, 1500, CAST(N'2024-07-25' AS Date))
SET IDENTITY_INSERT [dbo].[Empleado] OFF
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamento] ([idDepartamento])
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarEmpleado]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_EditarEmpleado](
@idEmpledo int,
@nombreCompleto varchar(50),
@idDepartamento int,
@sueldo int,
@fechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	update Empleado set
	nombreCompleto = @nombreCompleto,
	idDepartamento = @idDepartamento,
	sueldo = @sueldo,
	fechaContrato = convert(date,@fechaContrato)
	where idEmpledo = @idEmpledo
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarEmpleado]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_EliminarEmpleado](
@idEmpledo int)
as
begin
	delete from Empleado where idEmpledo  = @idEmpledo
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GuardarEmpleado]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GuardarEmpleado](
@nombreCompleto varchar(50),
@idDepartamento int,
@sueldo int,
@fechaContrato varchar(10)
)
as
begin
	set dateformat dmy
	insert into Empleado(nombreCompleto, idDepartamento,sueldo, fechaContrato)
	values
	(@nombreCompleto, @idDepartamento, @sueldo, convert(date,@fechaContrato))
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaDepartamentos]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListaDepartamentos]
as
begin
	select idDepartamento, nombre from Departamento
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListadoEmpleados]    Script Date: 02/08/2024 20:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListadoEmpleados]
as
begin
	set dateformat dmy
	select e.idEmpledo,
	e.nombreCompleto,
	d.idDepartamento,
	d.nombre,
	e.sueldo,
	convert(char(10), e.fechaContrato,103) as 'fechaContrato'
	from Empleado as e
	inner join Departamento as d
	on e.idDepartamento = d.idDepartamento
end
GO
USE [master]
GO
ALTER DATABASE [DBEmpleado] SET  READ_WRITE 
GO

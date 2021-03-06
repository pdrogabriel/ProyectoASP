USE [master]
GO
/****** Object:  Database [BancoDB]    Script Date: 22/01/2018 10:14:59 a.m. ******/
CREATE DATABASE [BancoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BancoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLSERVER2014\MSSQL\DATA\BancoDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BancoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLSERVER2014\MSSQL\DATA\BancoDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BancoDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BancoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BancoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BancoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BancoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BancoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BancoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BancoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BancoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BancoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BancoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BancoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BancoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BancoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BancoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BancoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BancoDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BancoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BancoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BancoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BancoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BancoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BancoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BancoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BancoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [BancoDB] SET  MULTI_USER 
GO
ALTER DATABASE [BancoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BancoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BancoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BancoDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BancoDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BancoDB', N'ON'
GO
USE [BancoDB]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NULL,
	[Direccion] [varchar](50) NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
	[FechaEliminacion] [datetime] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spActualizarCliente]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spActualizarCliente]
(
	@IdCliente INT,
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Direccion VARCHAR(50)
)

AS
BEGIN
	BEGIN TRY
		UPDATE Cliente SET
			Nombre = @Nombre,
			Apellido = @Apellido,
			Direccion = @Direccion,
			FechaActualizacion = GETDATE()
		WHERE 
			IdCliente = @IdCliente
	END TRY
	BEGIN CATCH
		PRINT 'Imposible actualizar el cliente'
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[spEliminarCliente]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spEliminarCliente]
(
	@IdCliente INT
)

AS
BEGIN
	BEGIN TRY
		DELETE Cliente
		WHERE 
			IdCliente = @IdCliente
	END TRY
	BEGIN CATCH
		PRINT 'Imposible actualizar el cliente'
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertarCliente]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spInsertarCliente]
(
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Direccion VARCHAR(50)
)

AS
BEGIN
	BEGIN TRY
		INSERT INTO Cliente
		(
			Nombre,
			Apellido,
			Direccion,
			FechaCreacion,
			FechaActualizacion,
			FechaEliminacion
		)
		SELECT
			@Nombre,
			@Apellido,
			@Direccion,
			GETDATE(),
			NULL,
			NULL
	END TRY
	BEGIN CATCH
		PRINT 'Imposible insertar el cliente'
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[spObtenerCliente]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerCliente]
(
	@IdCliente INT
)
AS
BEGIN
	BEGIN TRY
		SELECT * FROM Cliente WHERE IdCliente = @IdCliente
	END TRY
	BEGIN CATCH
		PRINT 'Imposible realizar la consulta'
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[spObtenerClientes]    Script Date: 22/01/2018 10:15:01 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerClientes]

AS
BEGIN
	BEGIN TRY
		SELECT * FROM Cliente
	END TRY
	BEGIN CATCH
		PRINT 'Imposible realizar la consulta'
	END CATCH
END

GO
USE [master]
GO
ALTER DATABASE [BancoDB] SET  READ_WRITE 
GO


-- Insertar clientes por defecto
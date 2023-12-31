USE [master]
GO
/****** Object:  Database [CfOder]    Script Date: 11/30/2023 11:18:34 PM ******/
CREATE DATABASE [CfOder]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CfOder', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CfOder.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CfOder_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CfOder_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CfOder] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CfOder].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CfOder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CfOder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CfOder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CfOder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CfOder] SET ARITHABORT OFF 
GO
ALTER DATABASE [CfOder] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CfOder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CfOder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CfOder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CfOder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CfOder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CfOder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CfOder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CfOder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CfOder] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CfOder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CfOder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CfOder] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CfOder] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CfOder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CfOder] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CfOder] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CfOder] SET RECOVERY FULL 
GO
ALTER DATABASE [CfOder] SET  MULTI_USER 
GO
ALTER DATABASE [CfOder] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CfOder] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CfOder] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CfOder] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CfOder] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CfOder] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CfOder', N'ON'
GO
ALTER DATABASE [CfOder] SET QUERY_STORE = OFF
GO
USE [CfOder]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [varchar](12) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Salt] [nchar](10) NULL,
	[Active] [bit] NOT NULL,
	[Fullname] [nvarchar](max) NULL,
	[RoleID] [int] NULL,
	[Lastlogin] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[AttributesId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[AttributesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributesPrices]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributesPrices](
	[AttributesPricesId] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[ProductId] [int] NULL,
	[Price] [float] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_AttributesPrices] PRIMARY KEY CLUSTERED 
(
	[AttributesPricesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CardId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[ImageUrl] [varchar](max) NULL,
	[IsAtive] [bit] NULL,
	[CreateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](255) NULL,
	[Birthday] [datetime] NULL,
	[Avartar] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](12) NULL,
	[LocationID] [int] NULL,
	[District] [nvarchar](255) NULL,
	[Ward] [nvarchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[Password] [nvarchar](50) NULL,
	[Salt] [nchar](10) NULL,
	[LastLogin] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[Location] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Type] [nvarchar](20) NULL,
	[Slug] [nvarchar](100) NULL,
	[NameWithType] [nvarchar](255) NULL,
	[PathWithType] [nvarchar](255) NULL,
	[ParentCode] [int] NULL,
	[Levels] [int] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[OrderDate] [datetime] NULL,
	[ShipDate] [datetime] NULL,
	[TranSacStatusId] [int] NULL,
	[Deleted] [bit] NULL,
	[Paid] [bit] NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentId] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[TotalMoney] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OderDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[OrderNumber] [int] NULL,
	[Quantity] [int] NULL,
	[Discount] [int] NULL,
	[Total] [int] NULL,
	[ShipDate] [datetime] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OderDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[PageId] [int] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](250) NULL,
	[Contents] [nvarchar](max) NULL,
	[Thumb] [nvarchar](250) NULL,
	[Published] [bit] NOT NULL,
	[Title] [nvarchar](250) NULL,
	[MetaDesc] [nvarchar](250) NULL,
	[MetaKey] [nvarchar](250) NULL,
	[Alias] [nvarchar](250) NULL,
	[CreateAt] [datetime] NULL,
	[Ordering] [int] NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](250) NULL,
	[ShortDDesc] [nvarchar](250) NULL,
	[Descriptioon] [nvarchar](max) NULL,
	[CategoryId] [int] NULL,
	[Price] [int] NULL,
	[Discount] [int] NULL,
	[Thumb] [nvarchar](250) NULL,
	[Video] [nvarchar](250) NULL,
	[DateCreate] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[BestSellers] [bit] NOT NULL,
	[HomeFlag] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Tags] [nvarchar](max) NULL,
	[Title] [nvarchar](250) NULL,
	[Alias] [nvarchar](250) NULL,
	[MetaDesc] [nvarchar](250) NULL,
	[MetaKey] [nvarchar](250) NULL,
	[UnitslnStock] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[ShipperId] [int] NULL,
	[ShipperName] [nvarchar](150) NULL,
	[Phone] [nchar](12) NULL,
	[Company] [nvarchar](250) NULL,
	[ShipDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tintuc]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tintuc](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Scontents] [nvarchar](250) NULL,
	[Contents] [nvarchar](max) NULL,
	[Thumb] [nvarchar](250) NULL,
	[Published] [bit] NOT NULL,
	[Alias] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[Author] [nvarchar](250) NULL,
	[AccountId] [int] NULL,
	[Tags] [nvarchar](max) NULL,
	[CategoryId] [int] NULL,
	[isHot] [bit] NULL,
	[isNewFeed] [bit] NULL,
	[MetaKey] [nvarchar](250) NULL,
	[MetaDesc] [nvarchar](250) NULL,
	[Views] [int] NULL,
 CONSTRAINT [PK_Tintuc] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactStatus]    Script Date: 11/30/2023 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactStatus](
	[TransacstatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_TransactStatus] PRIMARY KEY CLUSTERED 
(
	[TransacstatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Phone], [Email], [Password], [Salt], [Active], [Fullname], [RoleID], [Lastlogin], [CreateDate]) VALUES (2, N'0123456789', N'example@email.com', N'123', N'123       ', 0, N'John Doe', 1, CAST(N'2023-10-09T00:00:00.000' AS DateTime), CAST(N'2023-10-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Account] ([Id], [Phone], [Email], [Password], [Salt], [Active], [Fullname], [RoleID], [Lastlogin], [CreateDate]) VALUES (1002, N'0924855331', N'doantoan2308@gmail.com', N'123', N'1         ', 1, N'DOAN TRAN QUOC TOAN', 1, CAST(N'2023-10-11T04:19:00.000' AS DateTime), CAST(N'2023-10-11T04:19:00.000' AS DateTime))
INSERT [dbo].[Account] ([Id], [Phone], [Email], [Password], [Salt], [Active], [Fullname], [RoleID], [Lastlogin], [CreateDate]) VALUES (1004, N'123456789', N'admin@gmail.com', N'f71799a286161aed6c0d0c8b7708d23a', N'YCNuy     ', 1, N'admin', 4, NULL, CAST(N'2023-11-30T21:40:03.233' AS DateTime))
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Attributes] ON 

INSERT [dbo].[Attributes] ([AttributesId], [Name]) VALUES (1, N'Attribute 1')
INSERT [dbo].[Attributes] ([AttributesId], [Name]) VALUES (2, N'Attribute 2')
INSERT [dbo].[Attributes] ([AttributesId], [Name]) VALUES (3, N'Attribute 3')
SET IDENTITY_INSERT [dbo].[Attributes] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CardId], [Name], [ImageUrl], [IsAtive], [CreateDate]) VALUES (7, N'Cafe Ông Bầu.', N'cafe-ong-bau.png', 1, CAST(N'2023-11-26T11:37:56.000' AS DateTime))
INSERT [dbo].[Categories] ([CardId], [Name], [ImageUrl], [IsAtive], [CreateDate]) VALUES (8, N'Đá xay', N'da-xay.jpg', 1, CAST(N'2023-11-26T11:41:35.000' AS DateTime))
INSERT [dbo].[Categories] ([CardId], [Name], [ImageUrl], [IsAtive], [CreateDate]) VALUES (9, N'Sữa chua', N'sua-chua.png', 1, CAST(N'2023-11-26T11:43:11.297' AS DateTime))
INSERT [dbo].[Categories] ([CardId], [Name], [ImageUrl], [IsAtive], [CreateDate]) VALUES (10, N'Trà', N'tra.png', 1, CAST(N'2023-11-26T11:44:18.203' AS DateTime))
INSERT [dbo].[Categories] ([CardId], [Name], [ImageUrl], [IsAtive], [CreateDate]) VALUES (11, N'Món đặt biệt.', N'mon-dat-biet.png', 1, CAST(N'2023-11-26T11:47:04.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerId], [Fullname], [Birthday], [Avartar], [Address], [Email], [Phone], [LocationID], [District], [Ward], [CreateDate], [Password], [Salt], [LastLogin], [Active], [Location]) VALUES (2, N'John Doe', CAST(N'1990-01-15T00:00:00.000' AS DateTime), N'avatar1.jpg', N'123 Main St', N'john.doe@email.com', N'1234567890', 1, N'1', N'1', CAST(N'2023-10-11T00:00:00.000' AS DateTime), N'password123', N'salt123   ', CAST(N'2023-10-11T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[Customer] ([CustomerId], [Fullname], [Birthday], [Avartar], [Address], [Email], [Phone], [LocationID], [District], [Ward], [CreateDate], [Password], [Salt], [LastLogin], [Active], [Location]) VALUES (3, N'Jane Smith', CAST(N'1985-05-20T00:00:00.000' AS DateTime), N'avatar2.jpg', N'456 Elm St', N'jane.smith@email.com', N'9876543210', 2, N'2', N'2', CAST(N'2023-10-11T00:00:00.000' AS DateTime), N'password456', N'salt456   ', CAST(N'2023-10-11T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[Customer] ([CustomerId], [Fullname], [Birthday], [Avartar], [Address], [Email], [Phone], [LocationID], [District], [Ward], [CreateDate], [Password], [Salt], [LastLogin], [Active], [Location]) VALUES (1006, N'DOAN TRAN QUOC TOAN', NULL, NULL, N'b', N'doantoan2308@gmail.com', N'0924855331', 1, N'a', N'a', CAST(N'2023-11-29T09:03:03.817' AS DateTime), N'1ead38714c748425d281ed1853e82532', N'Z6BTI     ', NULL, 1, NULL)
INSERT [dbo].[Customer] ([CustomerId], [Fullname], [Birthday], [Avartar], [Address], [Email], [Phone], [LocationID], [District], [Ward], [CreateDate], [Password], [Salt], [LastLogin], [Active], [Location]) VALUES (1021, N'Loi', NULL, NULL, N'a', N'qloi@gmail.com', N'099999999', NULL, NULL, NULL, CAST(N'2023-11-30T17:28:18.530' AS DateTime), N'17e68578e7d9a9a302df7f7cffcea709', N'PsLfb     ', NULL, 1, NULL)
INSERT [dbo].[Customer] ([CustomerId], [Fullname], [Birthday], [Avartar], [Address], [Email], [Phone], [LocationID], [District], [Ward], [CreateDate], [Password], [Salt], [LastLogin], [Active], [Location]) VALUES (1022, N'Loi', NULL, NULL, N'Lê Thúc Hoạch', NULL, N'09999999', NULL, N'a', N'a', NULL, NULL, NULL, NULL, 0, N'a')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([LocationId], [Name], [Type], [Slug], [NameWithType], [PathWithType], [ParentCode], [Levels]) VALUES (1, N'Location 1', N'Type 1', N'location-slug-1', N'Name with Type 1', N'Path with Type 1', 0, 1)
INSERT [dbo].[Location] ([LocationId], [Name], [Type], [Slug], [NameWithType], [PathWithType], [ParentCode], [Levels]) VALUES (2, N'Location 2', N'Type 2', N'location-slug-2', N'Name with Type 2', N'Path with Type 2', 0, 1)
INSERT [dbo].[Location] ([LocationId], [Name], [Type], [Slug], [NameWithType], [PathWithType], [ParentCode], [Levels]) VALUES (3, N'Location 3', N'Type 3', N'location-slug-3', N'Name with Type 3', N'Path with Type 3', 0, 1)
SET IDENTITY_INSERT [dbo].[Location] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [CustomerId], [OrderDate], [ShipDate], [TranSacStatusId], [Deleted], [Paid], [PaymentDate], [PaymentId], [Note], [TotalMoney]) VALUES (17, 1021, CAST(N'2023-11-30T17:29:22.000' AS DateTime), CAST(N'2023-12-01T18:51:00.000' AS DateTime), 5, 1, 0, NULL, NULL, NULL, CAST(87000 AS Decimal(18, 0)))
INSERT [dbo].[Order] ([OrderId], [CustomerId], [OrderDate], [ShipDate], [TranSacStatusId], [Deleted], [Paid], [PaymentDate], [PaymentId], [Note], [TotalMoney]) VALUES (18, 1021, CAST(N'2023-11-30T17:31:41.283' AS DateTime), NULL, 1, 1, 0, NULL, NULL, NULL, CAST(35000 AS Decimal(18, 0)))
INSERT [dbo].[Order] ([OrderId], [CustomerId], [OrderDate], [ShipDate], [TranSacStatusId], [Deleted], [Paid], [PaymentDate], [PaymentId], [Note], [TotalMoney]) VALUES (19, 1022, CAST(N'2023-11-30T17:46:26.323' AS DateTime), NULL, 1, 0, 0, NULL, NULL, NULL, CAST(64000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OderDetailsId], [OrderId], [ProductId], [OrderNumber], [Quantity], [Discount], [Total], [ShipDate]) VALUES (13, 17, 3016, NULL, 2, NULL, 87000, CAST(N'2023-11-30T17:29:22.083' AS DateTime))
INSERT [dbo].[OrderDetails] ([OderDetailsId], [OrderId], [ProductId], [OrderNumber], [Quantity], [Discount], [Total], [ShipDate]) VALUES (14, 17, 3014, NULL, 1, NULL, 87000, CAST(N'2023-11-30T17:29:22.083' AS DateTime))
INSERT [dbo].[OrderDetails] ([OderDetailsId], [OrderId], [ProductId], [OrderNumber], [Quantity], [Discount], [Total], [ShipDate]) VALUES (15, 18, 3014, NULL, 1, NULL, 35000, CAST(N'2023-11-30T17:31:41.380' AS DateTime))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Pages] ON 

INSERT [dbo].[Pages] ([PageId], [PageName], [Contents], [Thumb], [Published], [Title], [MetaDesc], [MetaKey], [Alias], [CreateAt], [Ordering]) VALUES (4, N'acx', N'acx', N'acx.png', 1, N'as', N'a', N'a', N'acx', CAST(N'2023-11-25T11:27:36.000' AS DateTime), NULL)
INSERT [dbo].[Pages] ([PageId], [PageName], [Contents], [Thumb], [Published], [Title], [MetaDesc], [MetaKey], [Alias], [CreateAt], [Ordering]) VALUES (5, N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'huong-dan-mua-hang.png', 1, N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'hng-dn-mua-hng', CAST(N'2023-11-27T20:18:07.037' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Pages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3013, N'Cappuccino', N'Giá dao động: 28.000đ - 36.000đ', N'Sự kết hợp của Espresso nồng nàn hòa quyện cùng sữa nóng thơm dịu, lớp bọt sữa bồng bềnh tạo nên tách Cappuccino truyền thống thơm ngon, sánh mịn. ', 7, 32000, 0, N'cappuccino.png', NULL, CAST(N'2023-11-28T11:51:22.947' AS DateTime), CAST(N'2023-11-28T11:51:22.947' AS DateTime), 0, 1, 1, NULL, N'Cappuccino', N'cappuccino', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3014, N'Cà phê trứng nóng', N'Giá dao động: 31.000đ - 39.000đ', N'Không chỉ là một tách cà phê, mà còn là bản sắc, sự sáng tạo đầy độc đáo để tạo nên tách cà phê sánh mịn thơm béo với hương vị rất đặc trưng của kem trứng và vị đắng của cà phê', 7, 35000, NULL, N'ca-phe-trung-nong.png', NULL, CAST(N'2023-11-28T11:52:22.393' AS DateTime), CAST(N'2023-11-28T11:52:22.393' AS DateTime), 0, 1, 1, NULL, N'Cà phê trứng nóng', N'ca-phe-trung-nong', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3016, N'Đen Đá Milk Foam', N' Giá dao động: 22.000đ - 30.000đ', N'Cà phê đen truyền thống, đúng điệu của người Việt được tuyển chọn, pha chế từ những hạt cà phê Robusta tốt nhất tại nông trường CADA với lịch sử gần 100 năm tuổi. Hương thơm mộc mạc của cà phê thật bao giờ cũng khiến chúng ta say đắm.', 7, 26000, NULL, N'den-da-milk-foam.png', NULL, CAST(N'2023-11-28T11:56:48.380' AS DateTime), CAST(N'2023-11-28T11:56:48.380' AS DateTime), 0, 1, 1, NULL, N'Đen Đá Milk Foam', N'den-da-milk-foam', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3017, N'Cà phê trứng đá', N'Giá dao động: 31.000đ - 39.000đ', N'Cà Phê Trứng Đá vẫn giữ được hương vị đặc trưng nhưng sảng khoái hơn, mát lạnh và cực kỳ thú vị ngay ngụm đầu tiên thưởng thức.', 7, 35000, NULL, N'ca-phe-trung-da.png', NULL, CAST(N'2023-11-28T11:58:43.133' AS DateTime), CAST(N'2023-11-28T11:58:43.133' AS DateTime), 0, 0, 1, NULL, N'Cà phê trứng đá', N'ca-phe-trung-da', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3018, N'Cà phê dừa nóng', N'Giá dao động: 31.000đ - 39.000đ', N'Sự kết hợp giữa cà phê Espresso nồng nàn cùng lớp cốt dừa thơm béo.', 7, 35000, NULL, N'ca-phe-dua-nong.png', NULL, CAST(N'2023-11-28T12:00:19.587' AS DateTime), CAST(N'2023-11-28T12:00:19.587' AS DateTime), 0, 0, 1, NULL, N'Cà phê dừa nóng', N'ca-phe-dua-nong', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3019, N'Cà Phê Mè', N'Cà Phê Mè', N'Cà Phê Mè', 7, 39000, NULL, N'ca-phe-me.png', NULL, CAST(N'2023-11-28T12:19:34.043' AS DateTime), CAST(N'2023-11-28T12:19:34.043' AS DateTime), 0, 0, 1, NULL, N'Cà Phê Mè', N'ca-phe-me', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3020, N'Cà phê đen', N'Giá dao động: 18.000đ - 26.000đ', N'Cà phê đen truyền thống, đúng điệu của người Việt được tuyển chọn, pha chế từ những hạt cà phê Robusta tốt nhất tại nông trường CADA với lịch sử gần 100 năm tuổi. Hương thơm mộc mạc của cà phê thật bao giờ cũng khiến chúng ta say đắm', 7, 22000, NULL, N'ca-phe-den.png', NULL, CAST(N'2023-11-28T12:21:54.460' AS DateTime), CAST(N'2023-11-28T12:21:54.463' AS DateTime), 0, 0, 1, NULL, NULL, N'ca-phe-den', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3021, N'Bạc xỉu Ông Bầu', N'Giá dao động: 31.000đ - 39.000đ', N'Ly Bạc xỉu thơm béo, quen thuộc của người Việt nay với phiên bản đặc biệt chỉ có tại Cà Phê Ông Bầu với 3 tầng bắt mắt.', 7, 35000, NULL, N'bac-xiu-ong-bau.png', NULL, CAST(N'2023-11-28T12:23:13.450' AS DateTime), CAST(N'2023-11-28T12:23:13.450' AS DateTime), 0, 0, 1, NULL, N'Bạc xỉu Ông Bầu', N'bac-xiu-ong-bau', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3022, N'Americano', N'Giá dao động: 22.000đ - 30.000đ', N'Americano với hương vị cà phê dễ chịu, nhẹ nhàng không quá đậm đắng nhưng vẫn đầy đủ sự tinh tế để chinh phục người yêu cà phê trên toàn thế giới. ', 7, 26000, 0, N'americano.png', NULL, CAST(N'2023-11-28T12:25:08.657' AS DateTime), CAST(N'2023-11-28T12:25:08.657' AS DateTime), 0, 0, 1, NULL, N'Americano', N'americano', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3023, N'Cà phê sữa', N'Giá dao động: 20.000đ - 28.000đ', N'Cà phê sữa đá Ông Bầu là sự kết hợp hòa quyện bởi những hạt cà phê CADA danh tiếng thêm chút ngọt béo của sữa đặc mang lại ly cà phê sữa đá đậm vị Việt Nam đã và đang chinh phục nhưng người yêu cà phê trên', 7, 24000, NULL, N'ca-phe-sua.png', NULL, CAST(N'2023-11-28T12:26:33.143' AS DateTime), CAST(N'2023-11-28T12:26:33.143' AS DateTime), 0, 0, 0, NULL, N'Cà phê sữa', N'ca-phe-sua', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3024, N'Sữa đá milk foam', N'Giá dao động: 22.000đ -30.000đ', N'Một sự kết hợp độc đáo mang đến trải nghiệm mới về cà phê sữa đá truyền thống. Với hương vị nhẹ nhàng hơn cùng lớp kem Milk foam sánh mịn thơm béo, sẽ khiến bạn yêu ngay từ lần đầu thưởng thức.', 7, 26000, NULL, N'sua-da-milk-foam.png', NULL, CAST(N'2023-11-28T12:27:35.737' AS DateTime), CAST(N'2023-11-28T12:27:35.737' AS DateTime), 0, 0, 1, NULL, N'Sữa đá milk foam', N'sua-da-milk-foam', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3025, N'Espresso', N'Giá dao động: 22.000đ - 30.000đ', N'Ly cà phê Espresso tinh túy đầy hương thơm, không quá đắng mà êm, xốp nhẹ như kem, ngon đúng chất bởi sử dụng nguyên liệu từ nguồn Cà Phê Robusta CADA hảo hạng.', 7, 26000, NULL, N'espresso.png', NULL, CAST(N'2023-11-28T12:28:34.560' AS DateTime), CAST(N'2023-11-28T12:28:34.560' AS DateTime), 0, 0, 1, NULL, N'Espresso', N'espresso', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3026, N'Matcha dừa', N'Giá dao động: 36.000đ - 41.000đ', N'Hương vị nồng nàn, đắng nhẹ của matcha xen lẫn với bị béo, ngọt thanh của dừa và lớp topping ngũ cốc gấc mang đến một ly Matcha dừa thơm ngon khuấy động vị giác.', 8, 39000, NULL, N'matcha-dua.png', NULL, CAST(N'2023-11-28T12:30:10.607' AS DateTime), CAST(N'2023-11-28T12:30:10.607' AS DateTime), 0, 1, 1, NULL, N'Matcha dừa', N'matcha-dua', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3027, N'Caramel Choco', N'Caramel Choco', N'Caramel Choco', 8, 43000, NULL, N'caramel-choco.png', NULL, CAST(N'2023-11-28T12:30:59.463' AS DateTime), CAST(N'2023-11-28T12:30:59.463' AS DateTime), 0, 1, 1, NULL, N'Caramel Choco', N'caramel-choco', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3028, N'Matcha Lựu Đỏ', N'Matcha Lựu Đỏ', N'Matcha Lựu Đỏ', 8, 39000, NULL, N'matcha-luu-do.png', NULL, CAST(N'2023-11-28T12:31:35.660' AS DateTime), CAST(N'2023-11-28T12:31:35.660' AS DateTime), 0, 1, 1, NULL, N'Matcha Lựu Đỏ', N'matcha-luu-do', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3029, N'Matcha dừa', N'Giá dao động: 36.000đ - 41.000đ', N'Hương vị nồng nàn, đắng nhẹ của matcha xen lẫn với bị béo, ngọt thanh của dừa và lớp topping ngũ cốc gấc mang đến một ly Matcha dừa thơm ngon khuấy động vị giác', 8, 39000, NULL, N'matcha-dua.png', NULL, CAST(N'2023-11-28T12:32:31.767' AS DateTime), CAST(N'2023-11-28T12:32:31.767' AS DateTime), 0, 0, 1, NULL, N'Matcha dừa', N'matcha-dua', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3030, N'Sữa Chua Lựu Đỏ', N'Sữa Chua Lựu Đỏ', N'Sữa Chua Lựu Đỏ', 9, 43000, NULL, N'sua-chua-luu-do.png', NULL, CAST(N'2023-11-28T12:33:22.407' AS DateTime), CAST(N'2023-11-28T12:33:22.407' AS DateTime), 0, 1, 1, NULL, N'Sữa Chua Lựu Đỏ', N'sua-chua-luu-do', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3031, N'Sữa chua trân châu', N'Giá dao động: 33.000đ - 38.000đ', N'Sự kết hợp mới mẻ của sữa chua mát lạnh và hạt trân châu giòn giòn sần sật, ngọt nhẹ vị caramel sẽ khiến bạn thấy thú vị đến ngụm cuối cùng khi thưởng thức đấy.', 9, 36000, NULL, N'sua-chua-tran-chau.png', NULL, CAST(N'2023-11-28T12:34:15.207' AS DateTime), CAST(N'2023-11-28T12:34:15.207' AS DateTime), 0, 0, 1, NULL, N'Sữa chua trân châu', N'sua-chua-tran-chau', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3032, N'Sữa chua vải hoa hồng', N'Giá dao động: 40.000đ - 45.000đ', N'Sữa chua kết hợp cùng mứt vải hoa hồng thơm dịu tốt cho làn da.', 9, 43000, NULL, N'sua-chua-vai-hoa-hong.png', NULL, CAST(N'2023-11-28T12:35:05.860' AS DateTime), CAST(N'2023-11-28T12:35:05.860' AS DateTime), 0, 0, 1, NULL, N'Sữa chua vải hoa hồng', N'sua-chua-vai-hoa-hong', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3033, N'Sữa Tươi Phô Mai Trân Châu', N'Giá dao động: 36.000đ - 41.000đ', N'Sữa tươi béo béo cùng lớp milk foam mặn mặn, thêm vui miệng với hạt trân châu mềm dai và thạch phô mai.', 9, 39000, NULL, N'sua-tuoi-pho-mai-tran-chau.png', NULL, CAST(N'2023-11-28T12:36:25.610' AS DateTime), CAST(N'2023-11-28T12:36:25.610' AS DateTime), 0, 0, 1, NULL, N'Sữa Tươi Phô Mai Trân Châu', N'sua-tuoi-pho-mai-tran-chau', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3034, N'Sữa Chua Nhiệt Đới', N'Giá dao động: 36.000đ - 41.000đ', N'Sữa chua của nhãn hàng Nutifood kết hợp cùng thơm với vị ngọt dễ chịu mang lại giá trị dinh dưỡng cao.', 9, 39000, NULL, N'sua-chua-nhiet-doi.png', NULL, CAST(N'2023-11-28T12:37:19.173' AS DateTime), CAST(N'2023-11-28T12:37:19.173' AS DateTime), 0, 0, 1, NULL, N'Sữa Chua Nhiệt Đới', N'sua-chua-nhiet-doi', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3035, N'Trà Sữa Oolong Trân Châu', N'Trà Sữa Oolong Trân Châu', N'Trà Sữa Oolong Trân Châu', 10, 32000, NULL, N'tra-sua-oolong-tran-chau.png', NULL, CAST(N'2023-11-28T12:38:29.440' AS DateTime), CAST(N'2023-11-28T12:38:29.440' AS DateTime), 0, 1, 1, NULL, NULL, N'tra-sua-oolong-tran-chau', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3036, N'Trà đào', N'Giá dao động: 27.000đ - 32.000đ', N'Sự hấp dẫn của trà đào đơn giản đến từ sự giản dị của thức uống này với sự kết hợp của hương vị trái đào tươi thanh ngọt trên nền trà đen chát nhẹ, kích thích vị giác của bạn ngay lần đầu thưởng thức.', 10, 30000, NULL, N'tra-dao.png', NULL, CAST(N'2023-11-28T12:39:38.377' AS DateTime), CAST(N'2023-11-28T12:39:38.377' AS DateTime), 0, 1, 1, NULL, N'Trà đào', N'tra-dao', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3037, N'Trà Sữa Trân Châu Chocolate', N'Trà Sữa Trân Châu Chocolate', N'Trà Sữa Trân Châu Chocolate', 10, 32000, NULL, N'tra-sua-tran-chau-chocolate.png', NULL, CAST(N'2023-11-28T12:40:39.797' AS DateTime), CAST(N'2023-11-28T12:40:39.797' AS DateTime), 0, 1, 1, NULL, N'Trà Sữa Trân Châu Chocolate', N'tra-sua-tran-chau-chocolate', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3038, N'Trà Atiso Đỏ Hạt Boba', N'Giá dao động: 29.000đ - 34.000đ', N'Hương vị trà Atiso mát lạnh cùng Hạt Boba mọng nước vui miệng', 10, 32000, NULL, N'tra-atiso-do-hat-boba.png', NULL, CAST(N'2023-11-28T12:41:52.733' AS DateTime), CAST(N'2023-11-28T12:41:52.733' AS DateTime), 0, 0, 1, NULL, N'Trà Atiso Đỏ Hạt Boba', N'tra-atiso-do-hat-boba', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3039, N'Trà việt quất boba', N'Giá dao động: 27.000đ - 32.000đ', N'Với màu sắc trà đẹp mắt, vị chát nhẹ của trà đen cùng các hạt boba chua chua ngọt ngọt vỡ tan trong miệng, vị ngọt vị chua hòa cùng vị trà thanh mát rất dễ khiến bạn thích mê của thức uống này.', 10, 30000, NULL, N'tra-viet-quat-boba.png', NULL, CAST(N'2023-11-28T12:42:48.807' AS DateTime), CAST(N'2023-11-28T12:42:48.807' AS DateTime), 0, 0, 1, NULL, N'Trà việt quất boba', N'tra-viet-quat-boba', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3040, N'Trà Dứa Nhiệt Đới', N'Giá dao động: 29.000đ - 34.000đ', N'Hương vị trà atiso mát lành thơm nhẹ, vị ngọt dịu của mứt dứa, giòn sực của đào lát.', 10, 32000, NULL, N'tra-dua-nhiet-doi.png', NULL, CAST(N'2023-11-28T12:43:47.807' AS DateTime), CAST(N'2023-11-28T12:43:47.807' AS DateTime), 0, 0, 1, NULL, N'Trà Dứa Nhiệt Đới', N'tra-dua-nhiet-doi', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3041, N'Trà Lựu Nha Đam', N'Trà Lựu Nha Đam', N'Trà Lựu Nha Đam', 10, 32000, NULL, N'tra-luu-nha-dam.png', NULL, CAST(N'2023-11-28T12:44:33.153' AS DateTime), CAST(N'2023-11-28T12:44:33.153' AS DateTime), 0, 0, 1, NULL, N'Trà Lựu Nha Đam', N'tra-luu-nha-dam', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3042, N'Trà ổi hồng boba', N'Giá dao động: 27.000đ - 32.000đ', N'Thức uống mới lạ với hương vị của ổi hồng chua chua ngọt ngọt pha hòa quyện với hương thơm đậm đà của trà đen, thêm các hạt boba vui miệng sẽ giúp tinh thần thêm tươi mát và sảng khoái.', 10, 30000, NULL, N'tra-oi-hong-boba.png', NULL, CAST(N'2023-11-28T12:45:27.180' AS DateTime), CAST(N'2023-11-28T12:45:27.180' AS DateTime), 0, 0, 1, NULL, N'Trà ổi hồng boba', N'tra-oi-hong-boba', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3043, N'Trà sữa trân châu', N'Giá dao động: 27.000đ - 32.000đ', N'Hạt trân châu ngọt nhẹ vị caramel, giòn giòn sần sật vui miệng kết hợp với trà sữa đậm đà thơm vị trà đen chưa bao giờ ngừng được yêu thích tại Cà Phê Ông Bầu. Thử ngay bạn nhé! ', 10, 30000, NULL, N'tra-sua-tran-chau.png', NULL, CAST(N'2023-11-28T12:47:10.403' AS DateTime), CAST(N'2023-11-28T12:47:10.403' AS DateTime), 0, 0, 1, NULL, N'Trà sữa trân châu', N'tra-sua-tran-chau', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3044, N'Trà vải', N'Giá dao động: 27.000đ - 32.000đ', N'Thức uống thanh mát giải nhiệt từ trái vải quen thuộc của vùng nhiệt đới kết hợp cùng trà đen đặc trưng thơm ngon', 10, 30000, NULL, N'tra-vai.png', NULL, CAST(N'2023-11-28T12:47:55.677' AS DateTime), CAST(N'2023-11-28T12:47:55.677' AS DateTime), 0, 0, 1, NULL, N'Trà vải', N'tra-vai', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3045, N'Smoothie Thơm Dừa', N'Smoothie Thơm Dừa', N'Smoothie Thơm Dừa', 11, 43000, NULL, N'smoothie-thom-dua.png', NULL, CAST(N'2023-11-28T12:50:23.380' AS DateTime), CAST(N'2023-11-28T12:50:23.380' AS DateTime), 0, 1, 1, NULL, N'Smoothie Thơm Dừa', N'smoothie-thom-dua', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3046, N'Smoothie Olong Cookies', N'Smoothie Olong Cookies', N'Smoothie Olong Cookies', 11, 43000, NULL, N'smoothie-olong-cookies.png', NULL, CAST(N'2023-11-28T12:52:03.597' AS DateTime), CAST(N'2023-11-28T12:52:03.597' AS DateTime), 0, 1, 1, NULL, N'Smoothie Olong Cookies', N'smoothie-olong-cookies', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3047, N'Caramel Latte', N'Giá dao động: 27.000đ - 32.000đ', N'Vị thơm béo của sữa tươi kết hợp cùng cà phê Espresso CADA hảo hạng, quyện cùng hương vị ngọt ngào của Caramel mang đến một trải nghiệm mới về thức uống Latte.', 11, 30000, NULL, N'caramel-latte.png', NULL, CAST(N'2023-11-28T12:52:55.440' AS DateTime), CAST(N'2023-11-28T12:52:55.440' AS DateTime), 0, 1, 1, NULL, N'Caramel Latte', N'caramel-latte', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3048, N'Matcha Mè Rang', N'Matcha Mè Rang', N'Matcha Mè Rang', 11, 41000, NULL, N'matcha-me-rang.png', NULL, CAST(N'2023-11-28T12:53:38.133' AS DateTime), CAST(N'2023-11-28T12:53:38.133' AS DateTime), 0, 0, 0, NULL, N'Matcha Mè Rang', N'matcha-me-rang', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3049, N'Chocolate trứng đá', N'Giá dao động: 30.000đ - 35.000đ', N'Chocolate thơm ngon hòa quyện cùng hương vị đặc trưng của lớp trứng béo mịn, thêm một ít ngũ cốc phía trên mang đến ly thức uống lạ mắt nhưng không kém phần hấp dẫn.', 11, 33000, NULL, N'chocolate-trung-da.png', NULL, CAST(N'2023-11-28T12:54:35.170' AS DateTime), CAST(N'2023-11-28T12:54:35.170' AS DateTime), 0, 0, 1, NULL, N'Chocolate trứng đá', N'chocolate-trung-da', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3050, N'Matcha Latte', N' Giá dao động: 27.000đ - 32.000đ', N'Hương thơm thanh mát, vị đắng tinh tế của trà xanh hòa cùng sữa tươi thơm béo, sánh mịn chắc chắn sẽ khiến các tín đồ của latte thích thú với sự kết hợp này. Đây là món uống không có cà phê caffein. ', 11, 30000, NULL, N'matcha-latte.png', NULL, CAST(N'2023-11-28T12:55:25.000' AS DateTime), CAST(N'2023-11-28T12:58:52.977' AS DateTime), 0, 0, 1, NULL, N'Matcha Latte', N'matcha-latte', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3051, N'Latte Đá', N'Latte Đá', N'Latte Đá', 11, 28000, NULL, N'latte-da.png', NULL, CAST(N'2023-11-28T12:59:48.513' AS DateTime), CAST(N'2023-11-28T12:59:48.513' AS DateTime), 0, 0, 1, NULL, N'Latte Đá', N'latte-da', NULL, NULL, 100)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ShortDDesc], [Descriptioon], [CategoryId], [Price], [Discount], [Thumb], [Video], [DateCreate], [DateModified], [BestSellers], [HomeFlag], [Active], [Tags], [Title], [Alias], [MetaDesc], [MetaKey], [UnitslnStock]) VALUES (3052, N'Smoothie Olong Dừa', N'Smoothie Olong Dừa', N'Smoothie Olong Dừa', 11, 43000, NULL, N'smoothie-olong-dua.png', NULL, CAST(N'2023-11-28T13:00:29.000' AS DateTime), CAST(N'2023-11-28T21:53:35.110' AS DateTime), 0, 0, 1, NULL, N'Smoothie Olong Dừa', N'smoothie-olong-dua', NULL, NULL, 100)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (1, N'Admin', N'Quản Lý ')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (2, N'Staff', N'Nhân viên')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (4, N'Admin', N'Administrator')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (5, N'User', N'User Role')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (6, N'Guest', N'Guest Role')
GO
INSERT [dbo].[Shippers] ([ShipperId], [ShipperName], [Phone], [Company], [ShipDate]) VALUES (1, N'Shipper 1', N'123-456-7890', N'Company 1', CAST(N'2023-10-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Shippers] ([ShipperId], [ShipperName], [Phone], [Company], [ShipDate]) VALUES (2, N'Shipper 2', N'987-654-3210', N'Company 2', CAST(N'2023-10-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Shippers] ([ShipperId], [ShipperName], [Phone], [Company], [ShipDate]) VALUES (3, N'Shipper 3', N'555-123-4567', N'Company 3', CAST(N'2023-10-11T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Tintuc] ON 

INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (2, N'a', N'a', N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), N'a', NULL, NULL, NULL, 0, 1, N'a', N'a', 1)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (3, N'ac', NULL, N'a', N'a.png', 1, N'ac', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (4, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (5, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (6, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (7, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (8, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (9, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (10, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (11, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (12, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (13, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (14, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (15, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (16, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (17, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (18, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (19, N'b', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (20, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (21, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (22, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (23, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (24, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (25, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (26, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (27, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (28, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (29, N'c', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (30, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (31, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (32, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (33, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (34, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (35, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (36, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (37, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (38, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (39, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (40, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (41, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (42, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (43, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (44, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (45, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (46, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (47, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (48, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (49, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (50, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (51, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (52, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (53, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (54, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (55, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (56, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (57, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (58, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (59, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (60, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (61, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (62, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (63, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (66, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (68, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (69, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (75, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (78, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (80, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (81, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (82, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
INSERT [dbo].[Tintuc] ([PostId], [Title], [Scontents], [Contents], [Thumb], [Published], [Alias], [CreateDate], [Author], [AccountId], [Tags], [CategoryId], [isHot], [isNewFeed], [MetaKey], [MetaDesc], [Views]) VALUES (83, N'a', NULL, N'ab', N'a.png', 1, N'a', CAST(N'2023-11-26T13:42:03.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, N'a', N'a', NULL)
SET IDENTITY_INSERT [dbo].[Tintuc] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactStatus] ON 

INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (1, N'Chờ lấy hàng', N'Đã xác nhận và đang soạn hàng')
INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (2, N'Chờ xác nhận', N'Đang được người bán xác nhận với người mua')
INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (3, N'Đang giao', N'Đơn hàng đang được giao tới người mua')
INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (4, N'Đã giao thành công', N'Đơn hàng đã được giao tới người mua')
INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (5, N'Đã huỷ', N'Đơn hàng đã được huỷ thành công')
INSERT [dbo].[TransactStatus] ([TransacstatusId], [Status], [Description]) VALUES (6, N'Trả hàng', NULL)
SET IDENTITY_INSERT [dbo].[TransactStatus] OFF
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Roles]
GO
ALTER TABLE [dbo].[AttributesPrices]  WITH CHECK ADD  CONSTRAINT [FK_AttributesPrices_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([AttributesId])
GO
ALTER TABLE [dbo].[AttributesPrices] CHECK CONSTRAINT [FK_AttributesPrices_Attributes]
GO
ALTER TABLE [dbo].[AttributesPrices]  WITH CHECK ADD  CONSTRAINT [FK_AttributesPrices_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[AttributesPrices] CHECK CONSTRAINT [FK_AttributesPrices_Products]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Location]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_TransactStatus] FOREIGN KEY([TranSacStatusId])
REFERENCES [dbo].[TransactStatus] ([TransacstatusId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_TransactStatus]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories1] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CardId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories1]
GO
USE [master]
GO
ALTER DATABASE [CfOder] SET  READ_WRITE 
GO

USE [mmdb]
GO
/****** Object:  StoredProcedure [mmdb].[Insert_UserLoanApplyDetail]    Script Date: 26-07-2018 21:54:56 ******/
DROP PROCEDURE [mmdb].[Insert_UserLoanApplyDetail]
GO
/****** Object:  StoredProcedure [mmdb].[Insert_UserCCApplyDetail]    Script Date: 26-07-2018 21:54:56 ******/
DROP PROCEDURE [mmdb].[Insert_UserCCApplyDetail]
GO
ALTER TABLE [dbo].[CreditCard] DROP CONSTRAINT [FK_CreditCard_Bank]
GO
ALTER TABLE [dbo].[CityMaster] DROP CONSTRAINT [FK_CityMaster_StateMaster]
GO
ALTER TABLE [dbo].[CcDiscription] DROP CONSTRAINT [FK_CcDiscription_CreditCard]
GO
ALTER TABLE [dbo].[CcDiscription] DROP CONSTRAINT [FK_CcDiscription_CcMasterPoint]
GO
ALTER TABLE [dbo].[CcDiscription] DROP CONSTRAINT [FK_CcDiscription_CcDiscription]
GO
ALTER TABLE [dbo].[CcDetails] DROP CONSTRAINT [FK_CcDetails_CreditCard]
GO
ALTER TABLE [dbo].[CcDetails] DROP CONSTRAINT [FK_CcDetails_CcInfoSectionMaster]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] DROP CONSTRAINT [DF__UserLoanA__Creat__4BAC3F29]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] DROP CONSTRAINT [DF__UserLoanA__isUse__4AB81AF0]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] DROP CONSTRAINT [DF__UserLoanA__isEma__49C3F6B7]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] DROP CONSTRAINT [DF__UserLoanA__isMob__48CFD27E]
GO
ALTER TABLE [dbo].[BusinessPartnerProgramme] DROP CONSTRAINT [DF_BusinessPartnerProgramme_CreatedDate]
GO
/****** Object:  Index [UQ_BPP_Aadhar]    Script Date: 26-07-2018 21:54:56 ******/
ALTER TABLE [dbo].[BusinessPartnerProgramme] DROP CONSTRAINT [UQ_BPP_Aadhar]
GO
/****** Object:  Table [dbo].[UserLoanApplyDetail]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[UserLoanApplyDetail]
GO
/****** Object:  Table [dbo].[UserCCApplyDetail]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[UserCCApplyDetail]
GO
/****** Object:  Table [dbo].[StateMaster]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[StateMaster]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[Login]
GO
/****** Object:  Table [dbo].[CreditCard]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CreditCard]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[Company]
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CityMaster]
GO
/****** Object:  Table [dbo].[CcMasterPoint]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CcMasterPoint]
GO
/****** Object:  Table [dbo].[CcInfoSectionMaster]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CcInfoSectionMaster]
GO
/****** Object:  Table [dbo].[CcDiscription]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CcDiscription]
GO
/****** Object:  Table [dbo].[CcDetails]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[CcDetails]
GO
/****** Object:  Table [dbo].[BusinessPartnerProgramme]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[BusinessPartnerProgramme]
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 26-07-2018 21:54:56 ******/
DROP TABLE [dbo].[Bank]
GO
/****** Object:  Schema [mmdb]    Script Date: 26-07-2018 21:54:57 ******/
DROP SCHEMA [mmdb]
GO

DECLARE @RoleName sysname
set @RoleName = N'gd_execprocs'

IF @RoleName <> N'public' and (select is_fixed_role from sys.database_principals where name = @RoleName) = 0
BEGIN
	DECLARE @RoleMemberName sysname
	DECLARE Member_Cursor CURSOR FOR
	select [name]
	from sys.database_principals 
	where principal_id in ( 
		select member_principal_id
		from sys.database_role_members
		where role_principal_id in (
			select principal_id
			FROM sys.database_principals where [name] = @RoleName AND type = 'R'))

	OPEN Member_Cursor;

	FETCH NEXT FROM Member_Cursor
	into @RoleMemberName
	
	DECLARE @SQL NVARCHAR(4000)

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @SQL = 'ALTER ROLE '+ QUOTENAME(@RoleName,'[') +' DROP MEMBER '+ QUOTENAME(@RoleMemberName,'[')
		EXEC(@SQL)
		
		FETCH NEXT FROM Member_Cursor
		into @RoleMemberName
	END;

	CLOSE Member_Cursor;
	DEALLOCATE Member_Cursor;
END
/****** Object:  DatabaseRole [gd_execprocs]    Script Date: 26-07-2018 21:54:57 ******/
DROP ROLE [gd_execprocs]
GO
/****** Object:  User [mmdb]    Script Date: 26-07-2018 21:54:57 ******/
DROP USER [mmdb]
GO
USE [master]
GO
/****** Object:  Database [mmdb]    Script Date: 26-07-2018 21:54:57 ******/
DROP DATABASE [mmdb]
GO
/****** Object:  Database [mmdb]    Script Date: 26-07-2018 21:54:57 ******/
CREATE DATABASE [mmdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mmdb', FILENAME = N'E:\MSSQL.MSSQLSERVER\DATA\mmdb.mdf' , SIZE = 4096KB , MAXSIZE = 204800KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'mmdb_log', FILENAME = N'D:\MSSQL.MSSQLSERVER\DATA\mmdb_log.ldf' , SIZE = 1024KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [mmdb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mmdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mmdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mmdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mmdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mmdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mmdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [mmdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mmdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mmdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mmdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mmdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mmdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mmdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mmdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mmdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mmdb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [mmdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mmdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mmdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mmdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mmdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mmdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mmdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mmdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mmdb] SET  MULTI_USER 
GO
ALTER DATABASE [mmdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mmdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mmdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mmdb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [mmdb]
GO
/****** Object:  User [mmdb]    Script Date: 26-07-2018 21:55:00 ******/
CREATE USER [mmdb] FOR LOGIN [mmdb] WITH DEFAULT_SCHEMA=[mmdb]
GO
/****** Object:  DatabaseRole [gd_execprocs]    Script Date: 26-07-2018 21:55:02 ******/
CREATE ROLE [gd_execprocs]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [mmdb]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [mmdb]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [mmdb]
GO
ALTER ROLE [db_datareader] ADD MEMBER [mmdb]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [mmdb]
GO
/****** Object:  Schema [mmdb]    Script Date: 26-07-2018 21:55:02 ******/
CREATE SCHEMA [mmdb]
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 26-07-2018 21:55:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bank](
	[BankId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[LogoUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BusinessPartnerProgramme]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessPartnerProgramme](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](max) NULL,
	[Mobile] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PAN] [nvarchar](20) NOT NULL,
	[Aadhar] [nvarchar](20) NOT NULL,
	[Company] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_BusinessPartnerProgramme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CcDetails]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CcDetails](
	[CcDetailId] [int] IDENTITY(1,1) NOT NULL,
	[CardId] [int] NULL,
	[CcInfoSectionMasterId] [int] NULL,
	[Heading] [nvarchar](max) NULL,
	[Point] [nvarchar](max) NULL,
	[Key_] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_CcDetails] PRIMARY KEY CLUSTERED 
(
	[CcDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CcDiscription]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CcDiscription](
	[DiscriptionId] [int] IDENTITY(1,1) NOT NULL,
	[CardId] [int] NULL,
	[CcMasterPointsId] [int] NULL,
	[Heading] [nvarchar](max) NULL,
	[Point] [nvarchar](max) NULL,
	[Key_] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_CcDiscription] PRIMARY KEY CLUSTERED 
(
	[DiscriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CcInfoSectionMaster]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CcInfoSectionMaster](
	[CcInfoSectionMasterId] [int] IDENTITY(1,1) NOT NULL,
	[CcMasterPoint] [nvarchar](255) NULL,
 CONSTRAINT [PK_CcInfoSectionMaster] PRIMARY KEY CLUSTERED 
(
	[CcInfoSectionMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CcMasterPoint]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CcMasterPoint](
	[CcMasterPointId] [int] IDENTITY(1,1) NOT NULL,
	[CcMasterPoint] [nvarchar](255) NULL,
 CONSTRAINT [PK_CcMasterPoints] PRIMARY KEY CLUSTERED 
(
	[CcMasterPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[City] [nvarchar](255) NULL,
	[StateId] [int] NULL,
 CONSTRAINT [PK_Citys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Company]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CreditCard]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCard](
	[CardId] [int] IDENTITY(1,1) NOT NULL,
	[BankId] [int] NULL,
	[CardName] [nvarchar](250) NULL,
	[CardDescription] [nvarchar](max) NULL,
	[CardImageUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_CreditCard] PRIMARY KEY CLUSTERED 
(
	[CardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Login]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[LoginId] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [nvarchar](250) NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](250) NULL,
	[Mobile] [nvarchar](50) NULL,
	[EmailId] [nvarchar](50) NULL,
	[LastLogin] [datetime] NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StateMaster]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateMaster](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[State] [nvarchar](max) NULL,
 CONSTRAINT [PK_StateMaster] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserCCApplyDetail]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserCCApplyDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployerType] [bit] NULL,
	[CompanyName] [varchar](max) NULL,
	[GrossIncomeOrNetSalary] [decimal](18, 6) NULL,
	[Name] [varchar](max) NULL,
	[DOB] [datetime] NULL,
	[CityName] [varchar](max) NULL,
	[CityId] [int] NULL,
	[PinCode] [int] NULL,
	[MobileNumber] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[AccountWith] [varchar](max) NULL,
	[CreditCardWith] [varchar](max) NULL,
	[CreditCardMaxLimit] [decimal](18, 6) NULL,
	[CurrentOrPrevLoan] [bit] NULL,
	[OTP] [int] NULL,
	[isMobileNumberVerify] [bit] NULL DEFAULT ((0)),
	[isEmailVerify] [bit] NULL DEFAULT ((0)),
	[isUserActive] [bit] NULL DEFAULT ((0)),
	[CreatedDate] [datetime] NULL DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserLoanApplyDetail]    Script Date: 26-07-2018 21:55:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserLoanApplyDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployerType] [bit] NULL,
	[CompanyName] [varchar](max) NULL,
	[GrossIncomeOrNetSalary] [decimal](18, 6) NULL,
	[Name] [varchar](max) NULL,
	[DOB] [datetime] NULL,
	[CityName] [varchar](max) NULL,
	[CityId] [int] NULL,
	[PinCode] [int] NULL,
	[MobileNumber] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[AccountWith] [varchar](max) NULL,
	[CreditCardWith] [varchar](max) NULL,
	[CreditCardMaxLimit] [decimal](18, 6) NULL,
	[CurrentOrPrevLoan] [bit] NULL,
	[OTP] [int] NULL,
	[isMobileNumberVerify] [bit] NULL,
	[isEmailVerify] [bit] NULL,
	[isUserActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[Intended_loan_amount] [decimal](18, 6) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Bank] ON 

INSERT [dbo].[Bank] ([BankId], [Name], [LogoUrl]) VALUES (1, N'ICICI', NULL)
INSERT [dbo].[Bank] ([BankId], [Name], [LogoUrl]) VALUES (2, N'HDFC', NULL)
INSERT [dbo].[Bank] ([BankId], [Name], [LogoUrl]) VALUES (3, N'Kotak', NULL)
INSERT [dbo].[Bank] ([BankId], [Name], [LogoUrl]) VALUES (4, N'SBI', NULL)
INSERT [dbo].[Bank] ([BankId], [Name], [LogoUrl]) VALUES (5, N'Alahabad', NULL)
SET IDENTITY_INSERT [dbo].[Bank] OFF
SET IDENTITY_INSERT [dbo].[CcDetails] ON 

INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (2, 1, 2, N'Earn unlimited 10X reward points at select partners', N'Maecenas sit amet tellus at ligula condimentumgravida ei pharetra eulla eu justo mvariusam.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (3, 1, 2, N'Earn unlimited 10X reward points at select partners', N'Aliquam erat volucongue lectus. Morbi p. Sed consequat metus tortor, vel rhoncus orci tempor vel.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (5, 1, 2, N'Welcome rewards
', N'Get 1,500 bonus points on your first spend made within 30 days of card issue.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (6, 1, 2, N'Welcome rewards
', N'Get 1,000 bonus points on your first spend of Rs. 1000 made within 60 days of card issue.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (7, 1, 2, N'Earn bonus reward points
', N'Bonus on monthly Spends: Get 300 bonus points on card spends of $1500 or more in a month.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (8, 1, 2, N'Earn bonus reward points
', N'Maecenas pharetra augue ut nibh blandit, eget pellentesque orci rhoncus.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (9, 1, 2, N'Points that never expire
', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (10, 1, 2, N'Points that never expire
', N'Phasellus nec nisl eu metus porttitor consequat.
', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (11, 1, 3, N'Flexibility Fee and Charges', NULL, N'Interest Rate', N'3.25% per month (40% per annum). This can change periodically based on your spend, payback and utilization patterns.')
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (12, 1, 3, N'Flexibility Fee and Charges', NULL, N'Annual Fee ', N'Your annual fee of Rs1000 is waived on making spends of Rs30,000 in a membership year.')
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (13, 1, 5, N'Personal Concierge Services', N'Call your concierge for help with planning a party, sending flowers, making dining reservations, for travel assistance.', N'Dining Privileges', N'Up to 15% savings across participating restaurants.')
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (14, 1, 5, N'Personal Concierge Services', N'Call your concierge for help with planning a party, sending flowers, making dining reservations, for travel assistance.', N'Shopping Privileges', N'Enjoy savings and offers several stores in your City.')
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (15, 1, 5, N'Personal Concierge Services', N'Call your concierge for help with planning a party, sending flowers, making dining reservations, for travel assistance.', N'EMI Privileges', N'Choose easy EMI options at more than 2,000 consumer electronics and mobile phone outlets, leading retail chains and e-retailers.')
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (16, 1, 4, N'Fuel', N'Instant redemption at over 1200 participating oil outlets.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (17, 1, 4, N'Fuel', N'Redemption rate at oil outlets: 1 Reward Point = Rs 0.25 | Minimum Points required to redeem: 250.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (18, 1, 4, N'In-Store Shopping', N'Instant redemption at select partner stores.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (19, 1, 4, N'In-Store Shopping', N'Redemption rate at stores: 1 Reward Point = INR 0.30 | Minimum Points required to redeem: 250.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (20, 1, 4, N'Air miles', N'Redemption rate for air miles: 1 Reward Point = 0.75 miles | Minimum Points required to redeem: 100.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (21, 1, 4, N'Cash back', N'Adjust points against your Statement outstanding.', NULL, NULL)
INSERT [dbo].[CcDetails] ([CcDetailId], [CardId], [CcInfoSectionMasterId], [Heading], [Point], [Key_], [Value]) VALUES (22, 1, 4, N'Cash back', N'Redemption rate for cash back: 1 Reward Point = Rs 0.35 | Minimum Points required to redeem: 5,000.', NULL, NULL)
SET IDENTITY_INSERT [dbo].[CcDetails] OFF
SET IDENTITY_INSERT [dbo].[CcInfoSectionMaster] ON 

INSERT [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId], [CcMasterPoint]) VALUES (1, N'CC High Lights')
INSERT [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId], [CcMasterPoint]) VALUES (2, N'BENEFITS & FEATURES')
INSERT [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId], [CcMasterPoint]) VALUES (3, N'FEES & CHARGES')
INSERT [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId], [CcMasterPoint]) VALUES (4, N'REDEEM REWARDS')
INSERT [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId], [CcMasterPoint]) VALUES (5, N'BORROW PRIVILEGES')
SET IDENTITY_INSERT [dbo].[CcInfoSectionMaster] OFF
SET IDENTITY_INSERT [dbo].[CityMaster] ON 

INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1, N'Mumbai', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (2, N'Delhi', 9)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (3, N'Bengaluru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (4, N'Ahmedabad', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (5, N'Hyderabad', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (6, N'Chennai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (7, N'Kolkata', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (8, N'Pune', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (9, N'Jaipur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (10, N'Surat', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (11, N'Lucknow', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (12, N'Kanpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (13, N'Nagpur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (14, N'Patna', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (15, N'Indore', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (16, N'Thane', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (17, N'Bhopal', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (18, N'Visakhapatnam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (19, N'Vadodara', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (20, N'Firozabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (21, N'Ludhiana', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (22, N'Rajkot', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (23, N'Agra', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (24, N'Siliguri', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (25, N'Nashik', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (26, N'Faridabad', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (27, N'Patiala', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (28, N'Meerut', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (29, N'Kalyan-Dombivali', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (30, N'Vasai-Virar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (31, N'Varanasi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (32, N'Srinagar', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (33, N'Dhanbad', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (34, N'Jodhpur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (35, N'Amritsar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (36, N'Raipur', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (37, N'Allahabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (38, N'Coimbatore', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (39, N'Jabalpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (40, N'Gwalior', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (41, N'Vijayawada', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (42, N'Madurai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (43, N'Guwahati', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (44, N'Chandigarh', 6)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (45, N'Hubli-Dharwad', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (46, N'Amroha', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (47, N'Moradabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (48, N'Gurgaon', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (49, N'Aligarh', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (50, N'Solapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (51, N'Ranchi', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (52, N'Jalandhar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (53, N'Tiruchirappalli', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (54, N'Bhubaneswar', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (55, N'Salem', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (56, N'Warangal', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (57, N'Mira-Bhayandar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (58, N'Thiruvananthapuram', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (59, N'Bhiwandi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (60, N'Saharanpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (61, N'Guntur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (62, N'Amravati', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (63, N'Bikaner', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (64, N'Noida', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (65, N'Jamshedpur', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (66, N'Bhilai Nagar', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (67, N'Cuttack', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (68, N'Kochi', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (69, N'Udaipur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (70, N'Bhavnagar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (71, N'Dehradun', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (72, N'Asansol', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (73, N'Nanded-Waghala', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (74, N'Ajmer', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (75, N'Jamnagar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (76, N'Ujjain', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (77, N'Sangli', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (78, N'Loni', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (79, N'Jhansi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (80, N'Pondicherry', 26)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (81, N'Nellore', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (82, N'Jammu', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (83, N'Belagavi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (84, N'Raurkela', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (85, N'Mangaluru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (86, N'Tirunelveli', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (87, N'Malegaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (88, N'Gaya', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (89, N'Tiruppur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (90, N'Davanagere', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (91, N'Kozhikode', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (92, N'Akola', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (93, N'Kurnool', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (94, N'Bokaro Steel City', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (95, N'Rajahmundry', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (96, N'Ballari', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (97, N'Agartala', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (98, N'Bhagalpur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (99, N'Latur', 20)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (100, N'Dhule', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (101, N'Korba', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (102, N'Bhilwara', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (103, N'Brahmapur', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (104, N'Mysore', 17)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (105, N'Muzaffarpur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (106, N'Ahmednagar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (107, N'Kollam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (108, N'Raghunathganj', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (109, N'Bilaspur', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (110, N'Shahjahanpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (111, N'Thrissur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (112, N'Alwar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (113, N'Kakinada', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (114, N'Nizamabad', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (115, N'Sagar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (116, N'Tumkur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (117, N'Hisar', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (118, N'Rohtak', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (119, N'Panipat', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (120, N'Darbhanga', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (121, N'Kharagpur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (122, N'Aizawl', 23)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (123, N'Ichalkaranji', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (124, N'Tirupati', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (125, N'Karnal', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (126, N'Bathinda', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (127, N'Rampur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (128, N'Shivamogga', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (129, N'Ratlam', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (130, N'Modinagar', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (131, N'Durg', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (132, N'Shillong', 22)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (133, N'Imphal', 21)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (134, N'Hapur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (135, N'Ranipet', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (136, N'Anantapur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (137, N'Arrah', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (138, N'Karimnagar', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (139, N'Parbhani', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (140, N'Etawah', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (141, N'Bharatpur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (142, N'Begusarai', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (143, N'New Delhi', 9)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (144, N'Chhapra', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (145, N'Kadapa', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (146, N'Ramagundam', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (147, N'Pali', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (148, N'Satna', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (149, N'Vizianagaram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (150, N'Katihar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (151, N'Hardwar', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (152, N'Sonipat', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (153, N'Nagercoil', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (154, N'Thanjavur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (155, N'Murwara (Katni)', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (156, N'Naihati', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (157, N'Sambhal', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (158, N'Nadiad', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (159, N'Yamunanagar', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (160, N'English Bazar', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (161, N'Eluru', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (162, N'Munger', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (163, N'Panchkula', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (164, N'Raayachuru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (165, N'Panvel', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (166, N'Deoghar', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (167, N'Ongole', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (168, N'Nandyal', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (169, N'Morena', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (170, N'Bhiwani', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (171, N'Porbandar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (172, N'Palakkad', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (173, N'Anand', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (174, N'Purnia', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (175, N'Baharampur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (176, N'Barmer', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (177, N'Morvi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (178, N'Orai', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (179, N'Bahraich', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (180, N'Sikar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (181, N'Vellore', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (182, N'Singrauli', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (183, N'Khammam', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (184, N'Mahesana', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (185, N'Silchar', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (186, N'Sambalpur', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (187, N'Rewa', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (188, N'Unnao', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (189, N'Hugli-Chinsurah', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (190, N'Raiganj', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (191, N'Phusro', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (192, N'Adityapur', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (193, N'Alappuzha', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (194, N'Bahadurgarh', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (195, N'Machilipatnam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (196, N'Rae Bareli', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (197, N'Jalpaiguri', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (198, N'Bharuch', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (199, N'Pathankot', 27)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (200, N'Hoshiarpur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (201, N'Baramula', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (202, N'Adoni', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (203, N'Jind', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (204, N'Tonk', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (205, N'Tenali', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (206, N'Kancheepuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (207, N'Vapi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (208, N'Sirsa', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (209, N'Navsari', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (210, N'Mahbubnagar', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (211, N'Puri', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (212, N'Robertson Pet', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (213, N'Erode', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (214, N'Batala', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (215, N'Haldwani-cum-Kathgodam', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (216, N'Vidisha', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (217, N'Saharsa', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (218, N'Thanesar', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (219, N'Chittoor', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (220, N'Veraval', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (221, N'Lakhimpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (222, N'Sitapur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (223, N'Hindupur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (224, N'Santipur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (225, N'Balurghat', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (226, N'Ganjbasoda', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (227, N'Moga', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (228, N'Proddatur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (229, N'Srinagar', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (230, N'Medinipur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (231, N'Habra', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (232, N'Sasaram', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (233, N'Hajipur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (234, N'Bhuj', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (235, N'Shivpuri', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (236, N'Ranaghat', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (237, N'Shimla', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (238, N'Tiruvannamalai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (239, N'Kaithal', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (240, N'Rajnandgaon', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (241, N'Godhra', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (242, N'Hazaribag', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (243, N'Bhimavaram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (244, N'Mandsaur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (245, N'Dibrugarh', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (246, N'Kolar', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (247, N'Bankura', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (248, N'Mandya', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (249, N'Dehri-on-Sone', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (250, N'Madanapalle', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (251, N'Malerkotla', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (252, N'Lalitpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (253, N'Bettiah', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (254, N'Pollachi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (255, N'Khanna', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (256, N'Neemuch', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (257, N'Palwal', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (258, N'Palanpur', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (259, N'Guntakal', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (260, N'Nabadwip', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (261, N'Udupi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (262, N'Jagdalpur', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (263, N'Motihari', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (264, N'Pilibhit', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (265, N'Dimapur', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (266, N'Mohali', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (267, N'Sadulpur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (268, N'Rajapalayam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (269, N'Dharmavaram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (270, N'Kashipur', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (271, N'Sivakasi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (272, N'Darjiling', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (273, N'Chikkamagaluru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (274, N'Gudivada', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (275, N'Baleshwar Town', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (276, N'Mancherial', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (277, N'Srikakulam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (278, N'Adilabad', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (279, N'Yavatmal', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (280, N'Barnala', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (281, N'Nagaon', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (282, N'Narasaraopet', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (283, N'Raigarh', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (284, N'Roorkee', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (285, N'Valsad', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (286, N'Ambikapur', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (287, N'Giridih', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (288, N'Chandausi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (289, N'Purulia', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (290, N'Patan', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (291, N'Bagaha', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (292, N'Hardoi ', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (293, N'Achalpur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (294, N'Osmanabad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (295, N'Deesa', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (296, N'Nandurbar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (297, N'Azamgarh', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (298, N'Ramgarh', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (299, N'Firozpur', 27)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (300, N'Baripada Town', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (301, N'Karwar', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (302, N'Siwan', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (303, N'Rajampet', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (304, N'Pudukkottai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (305, N'Anantnag', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (306, N'Tadpatri', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (307, N'Satara', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (308, N'Bhadrak', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (309, N'Kishanganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (310, N'Suryapet', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (311, N'Wardha', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (312, N'Ranebennuru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (313, N'Amreli', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (314, N'Neyveli (TS)', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (315, N'Jamalpur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (316, N'Marmagao', 10)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (317, N'Udgir', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (318, N'Tadepalligudem', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (319, N'Nagapattinam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (320, N'Buxar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (321, N'Aurangabad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (322, N'Jehanabad', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (323, N'Phagwara', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (324, N'Khair', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (325, N'Sawai Madhopur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (326, N'Kapurthala', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (327, N'Chilakaluripet', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (328, N'Aurangabad', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (329, N'Malappuram', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (330, N'Rewari', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (331, N'Nagaur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (332, N'Sultanpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (333, N'Nagda', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (334, N'Port Blair', 1)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (335, N'Lakhisarai', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (336, N'Panaji', 10)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (337, N'Tinsukia', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (338, N'Itarsi', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (339, N'Kohima', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (340, N'Balangir', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (341, N'Nawada', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (342, N'Jharsuguda', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (343, N'Jagtial', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (344, N'Viluppuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (345, N'Amalner', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (346, N'Zirakpur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (347, N'Tanda', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (348, N'Tiruchengode', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (349, N'Nagina', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (350, N'Yemmiganur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (351, N'Vaniyambadi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (352, N'Sarni', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (353, N'Theni Allinagaram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (354, N'Margao', 10)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (355, N'Akot', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (356, N'Sehore', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (357, N'Mhow Cantonment', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (358, N'Kot Kapura', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (359, N'Makrana', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (360, N'Pandharpur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (361, N'Miryalaguda', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (362, N'Shamli', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (363, N'Seoni', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (364, N'Ranibennur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (365, N'Kadiri', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (366, N'Shrirampur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (367, N'Rudrapur', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (368, N'Parli', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (369, N'Najibabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (370, N'Nirmal', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (371, N'Udhagamandalam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (372, N'Shikohabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (373, N'Jhumri Tilaiya', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (374, N'Aruppukkottai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (375, N'Ponnani', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (376, N'Jamui', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (377, N'Sitamarhi', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (378, N'Chirala', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (379, N'Anjar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (380, N'Karaikal', 26)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (381, N'Hansi', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (382, N'Anakapalle', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (383, N'Mahasamund', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (384, N'Faridkot', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (385, N'Saunda', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (386, N'Dhoraji', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (387, N'Paramakudi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (388, N'Balaghat', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (389, N'Sujangarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (390, N'Khambhat', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (391, N'Muktsar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (392, N'Rajpura', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (393, N'Kavali', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (394, N'Dhamtari', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (395, N'Ashok Nagar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (396, N'Sardarshahar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (397, N'Mahuva', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (398, N'Bargarh', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (399, N'Kamareddy', 30)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (400, N'Sahibganj', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (401, N'Kothagudem', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (402, N'Ramanagaram', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (403, N'Gokak', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (404, N'Tikamgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (405, N'Araria', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (406, N'Rishikesh', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (407, N'Shahdol', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (408, N'Medininagar (Daltonganj)', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (409, N'Arakkonam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (410, N'Washim', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (411, N'Sangrur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (412, N'Bodhan', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (413, N'Fazilka', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (414, N'Palacole', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (415, N'Keshod', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (416, N'Sullurpeta', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (417, N'Wadhwan', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (418, N'Gurdaspur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (419, N'Vatakara', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (420, N'Tura', 22)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (421, N'Narnaul', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (422, N'Kharar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (423, N'Yadgir', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (424, N'Ambejogai', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (425, N'Ankleshwar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (426, N'Savarkundla', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (427, N'Paradip', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (428, N'Virudhachalam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (429, N'Kanhangad', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (430, N'Kadi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (431, N'Srivilliputhur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (432, N'Gobindgarh', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (433, N'Tindivanam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (434, N'Mansa', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (435, N'Taliparamba', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (436, N'Manmad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (437, N'Tanuku', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (438, N'Rayachoti', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (439, N'Virudhunagar', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (440, N'Koyilandy', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (441, N'Jorhat', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (442, N'Karur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (443, N'Valparai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (444, N'Srikalahasti', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (445, N'Neyyattinkara', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (446, N'Bapatla', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (447, N'Fatehabad', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (448, N'Malout', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (449, N'Sankarankovil', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (450, N'Tenkasi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (451, N'Ratnagiri', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (452, N'Rabkavi Banhatti', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (453, N'Sikandrabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (454, N'Chaibasa', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (455, N'Chirmiri', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (456, N'Palwancha', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (457, N'Bhawanipatna', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (458, N'Kayamkulam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (459, N'Pithampur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (460, N'Nabha', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (461, N'Shahabad, Hardoi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (462, N'Dhenkanal', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (463, N'Uran Islampur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (464, N'Gopalganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (465, N'Bongaigaon City', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (466, N'Palani', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (467, N'Pusad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (468, N'Sopore', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (469, N'Pilkhuwa', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (470, N'Tarn Taran', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (471, N'Renukoot', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (472, N'Mandamarri', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (473, N'Shahabad', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (474, N'Barbil', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (475, N'Koratla', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (476, N'Madhubani', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (477, N'Arambagh', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (478, N'Gohana', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (479, N'Ladnu', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (480, N'Pattukkottai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (481, N'Sirsi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (482, N'Sircilla', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (483, N'Tamluk', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (484, N'Jagraon', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (485, N'AlipurdUrban Agglomerationr', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (486, N'Alirajpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (487, N'Tandur', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (488, N'Naidupet', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (489, N'Tirupathur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (490, N'Tohana', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (491, N'Ratangarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (492, N'Dhubri', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (493, N'Masaurhi', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (494, N'Visnagar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (495, N'Vrindavan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (496, N'Nokha', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (497, N'Nagari', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (498, N'Narwana', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (499, N'Ramanathapuram', 29)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (500, N'Ujhani', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (501, N'Samastipur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (502, N'Laharpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (503, N'Sangamner', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (504, N'Nimbahera', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (505, N'Siddipet', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (506, N'Suri', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (507, N'Diphu', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (508, N'Jhargram', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (509, N'Shirpur-Warwade', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (510, N'Tilhar', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (511, N'Sindhnur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (512, N'Udumalaipettai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (513, N'Malkapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (514, N'Wanaparthy', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (515, N'Gudur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (516, N'Kendujhar', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (517, N'Mandla', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (518, N'Mandi', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (519, N'Nedumangad', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (520, N'North Lakhimpur', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (521, N'Vinukonda', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (522, N'Tiptur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (523, N'Gobichettipalayam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (524, N'Sunabeda', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (525, N'Wani', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (526, N'Upleta', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (527, N'Narasapuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (528, N'Nuzvid', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (529, N'Tezpur', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (530, N'Una', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (531, N'Markapur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (532, N'Sheopur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (533, N'Thiruvarur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (534, N'Sidhpur', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (535, N'Sahaswan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (536, N'Suratgarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (537, N'Shajapur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (538, N'Rayagada', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (539, N'Lonavla', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (540, N'Ponnur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (541, N'Kagaznagar', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (542, N'Gadwal', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (543, N'Bhatapara', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (544, N'Kandukur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (545, N'Sangareddy', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (546, N'Unjha', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (547, N'Lunglei', 23)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (548, N'Karimganj', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (549, N'Kannur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (550, N'Bobbili', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (551, N'Mokameh', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (552, N'Talegaon Dabhade', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (553, N'Anjangaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (554, N'Mangrol', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (555, N'Sunam', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (556, N'Gangarampur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (557, N'Thiruvallur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (558, N'Tirur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (559, N'Rath', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (560, N'Jatani', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (561, N'Viramgam', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (562, N'Rajsamand', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (563, N'Yanam', 26)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (564, N'Kottayam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (565, N'Panruti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (566, N'Dhuri', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (567, N'Namakkal', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (568, N'Kasaragod', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (569, N'Modasa', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (570, N'Rayadurg', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (571, N'Supaul', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (572, N'Kunnamkulam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (573, N'Umred', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (574, N'Bellampalle', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (575, N'Sibsagar', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (576, N'Mandi Dabwali', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (577, N'Ottappalam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (578, N'Dumraon', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (579, N'Samalkot', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (580, N'Jaggaiahpet', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (581, N'Goalpara', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (582, N'Tuni', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (583, N'Lachhmangarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (584, N'Bhongir', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (585, N'Amalapuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (586, N'Firozpur Cantt.', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (587, N'Vikarabad', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (588, N'Thiruvalla', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (589, N'Sherkot', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (590, N'Palghar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (591, N'Shegaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (592, N'Jangaon', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (593, N'Bheemunipatnam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (594, N'Panna', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (595, N'Thodupuzha', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (596, N'KathUrban Agglomeration', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (597, N'Palitana', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (598, N'Arwal', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (599, N'Venkatagiri', 2)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (600, N'Kalpi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (601, N'Rajgarh (Churu)', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (602, N'Sattenapalle', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (603, N'Arsikere', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (604, N'Ozar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (605, N'Thirumangalam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (606, N'Petlad', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (607, N'Nasirabad', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (608, N'Phaltan', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (609, N'Rampurhat', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (610, N'Nanjangud', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (611, N'Forbesganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (612, N'Tundla', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (613, N'BhabUrban Agglomeration', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (614, N'Sagara', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (615, N'Pithapuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (616, N'Sira', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (617, N'Bhadrachalam', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (618, N'Charkhi Dadri', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (619, N'Chatra', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (620, N'Palasa Kasibugga', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (621, N'Nohar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (622, N'Yevla', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (623, N'Sirhind Fatehgarh Sahib', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (624, N'Bhainsa', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (625, N'Parvathipuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (626, N'Shahade', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (627, N'Chalakudy', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (628, N'Narkatiaganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (629, N'Kapadvanj', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (630, N'Macherla', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (631, N'Raghogarh-Vijaypur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (632, N'Rupnagar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (633, N'Naugachhia', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (634, N'Sendhwa', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (635, N'Byasanagar', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (636, N'Sandila', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (637, N'Gooty', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (638, N'Salur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (639, N'Nanpara', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (640, N'Sardhana', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (641, N'Vita', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (642, N'Gumia', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (643, N'Puttur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (644, N'Jalandhar Cantt.', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (645, N'Nehtaur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (646, N'Changanassery', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (647, N'Mandapeta', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (648, N'Dumka', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (649, N'Seohara', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (650, N'Umarkhed', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (651, N'Madhupur', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (652, N'Vikramasingapuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (653, N'Punalur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (654, N'Kendrapara', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (655, N'Sihor', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (656, N'Nellikuppam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (657, N'Samana', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (658, N'Warora', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (659, N'Nilambur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (660, N'Rasipuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (661, N'Ramnagar', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (662, N'Jammalamadugu', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (663, N'Nawanshahr', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (664, N'Thoubal', 21)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (665, N'Athni', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (666, N'Cherthala', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (667, N'Sidhi', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (668, N'Farooqnagar', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (669, N'Peddapuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (670, N'Chirkunda', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (671, N'Pachora', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (672, N'Madhepura', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (673, N'Pithoragarh', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (674, N'Tumsar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (675, N'Phalodi', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (676, N'Tiruttani', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (677, N'Rampura Phul', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (678, N'Perinthalmanna', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (679, N'Padrauna', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (680, N'Pipariya', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (681, N'Dalli-Rajhara', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (682, N'Punganur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (683, N'Mattannur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (684, N'Mathura', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (685, N'Thakurdwara', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (686, N'Nandivaram-Guduvancheri', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (687, N'Mulbagal', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (688, N'Manjlegaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (689, N'Wankaner', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (690, N'Sillod', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (691, N'Nidadavole', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (692, N'Surapura', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (693, N'Rajagangapur', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (694, N'Sheikhpura', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (695, N'Parlakhemundi', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (696, N'Kalimpong', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (697, N'Siruguppa', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (698, N'Arvi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (699, N'Limbdi', 11)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (700, N'Barpeta', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (701, N'Manglaur', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (702, N'Repalle', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (703, N'Mudhol', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (704, N'Shujalpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (705, N'Mandvi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (706, N'Thangadh', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (707, N'Sironj', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (708, N'Nandura', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (709, N'Shoranur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (710, N'Nathdwara', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (711, N'Periyakulam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (712, N'Sultanganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (713, N'Medak', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (714, N'Narayanpet', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (715, N'Raxaul Bazar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (716, N'Rajauri', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (717, N'Pernampattu', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (718, N'Nainital', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (719, N'Ramachandrapuram', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (720, N'Vaijapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (721, N'Nangal', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (722, N'Sidlaghatta', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (723, N'Punch', 14)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (724, N'Pandhurna', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (725, N'Wadgaon Road', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (726, N'Talcher', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (727, N'Varkala', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (728, N'Pilani', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (729, N'Nowgong', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (730, N'Naila Janjgir', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (731, N'Mapusa', 10)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (732, N'Vellakoil', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (733, N'Merta City', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (734, N'Sivaganga', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (735, N'Mandideep', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (736, N'Sailu', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (737, N'Vyara', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (738, N'Kovvur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (739, N'Vadalur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (740, N'Nawabganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (741, N'Padra', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (742, N'Sainthia', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (743, N'Siana', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (744, N'Shahpur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (745, N'Sojat', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (746, N'Noorpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (747, N'Paravoor', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (748, N'Murtijapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (749, N'Ramnagar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (750, N'Sundargarh', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (751, N'Taki', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (752, N'Saundatti-Yellamma', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (753, N'Pathanamthitta', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (754, N'Wadi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (755, N'Rameshwaram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (756, N'Tasgaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (757, N'Sikandra Rao', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (758, N'Sihora', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (759, N'Tiruvethipuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (760, N'Tiruvuru', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (761, N'Mehkar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (762, N'Peringathur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (763, N'Perambalur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (764, N'Manvi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (765, N'Zunheboto', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (766, N'Mahnar Bazar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (767, N'Attingal', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (768, N'Shahbad', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (769, N'Puranpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (770, N'Nelamangala', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (771, N'Nakodar', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (772, N'Lunawada', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (773, N'Murshidabad', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (774, N'Mahe', 26)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (775, N'Lanka', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (776, N'Rudauli', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (777, N'Tuensang', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (778, N'Lakshmeshwar', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (779, N'Zira', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (780, N'Yawal', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (781, N'Thana Bhawan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (782, N'Ramdurg', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (783, N'Pulgaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (784, N'Sadasivpet', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (785, N'Nargund', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (786, N'Neem-Ka-Thana', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (787, N'Memari', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (788, N'Nilanga', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (789, N'Naharlagun', 3)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (790, N'Pakaur', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (791, N'Wai', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (792, N'Tarikere', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (793, N'Malavalli', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (794, N'Raisen', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (795, N'Lahar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (796, N'Uravakonda', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (797, N'Savanur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (798, N'Sirohi', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (799, N'Udhampur', 14)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (800, N'Umarga', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (801, N'Pratapgarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (802, N'Lingsugur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (803, N'Usilampatti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (804, N'Palia Kalan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (805, N'Wokha', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (806, N'Rajpipla', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (807, N'Vijayapura', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (808, N'Rawatbhata', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (809, N'Sangaria', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (810, N'Paithan', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (811, N'Rahuri', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (812, N'Patti', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (813, N'Zaidpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (814, N'Lalsot', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (815, N'Maihar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (816, N'Vedaranyam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (817, N'Nawapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (818, N'Solan', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (819, N'Vapi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (820, N'Sanawad', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (821, N'Warisaliganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (822, N'Revelganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (823, N'Sabalgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (824, N'Tuljapur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (825, N'Simdega', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (826, N'Musabani', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (827, N'Kodungallur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (828, N'Phulabani', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (829, N'Umreth', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (830, N'Narsipatnam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (831, N'Nautanwa', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (832, N'Rajgir', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (833, N'Yellandu', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (834, N'Sathyamangalam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (835, N'Pilibanga', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (836, N'Morshi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (837, N'Pehowa', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (838, N'Sonepur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (839, N'Pappinisseri', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (840, N'Zamania', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (841, N'Mihijam', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (842, N'Purna', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (843, N'Puliyankudi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (844, N'Shikarpur, Bulandshahr', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (845, N'Umaria', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (846, N'Porsa', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (847, N'Naugawan Sadat', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (848, N'Fatehpur Sikri', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (849, N'Manuguru', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (850, N'Udaipur', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (851, N'Pipar City', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (852, N'Pattamundai', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (853, N'Nanjikottai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (854, N'Taranagar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (855, N'Yerraguntla', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (856, N'Satana', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (857, N'Sherghati', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (858, N'Sankeshwara', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (859, N'Madikeri', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (860, N'Thuraiyur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (861, N'Sanand', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (862, N'Rajula', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (863, N'Kyathampalle', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (864, N'Shahabad, Rampur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (865, N'Tilda Newra', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (866, N'Narsinghgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (867, N'Chittur-Thathamangalam', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (868, N'Malaj Khand', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (869, N'Sarangpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (870, N'Robertsganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (871, N'Sirkali', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (872, N'Radhanpur', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (873, N'Tiruchendur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (874, N'Utraula', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (875, N'Patratu', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (876, N'Vijainagar, Ajmer', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (877, N'Periyasemur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (878, N'Pathri', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (879, N'Sadabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (880, N'Talikota', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (881, N'Sinnar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (882, N'Mungeli', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (883, N'Sedam', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (884, N'Shikaripur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (885, N'Sumerpur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (886, N'Sattur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (887, N'Sugauli', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (888, N'Lumding', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (889, N'Vandavasi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (890, N'Titlagarh', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (891, N'Uchgaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (892, N'Mokokchung', 24)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (893, N'Paschim Punropara', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (894, N'Sagwara', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (895, N'Ramganj Mandi', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (896, N'Tarakeswar', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (897, N'Mahalingapura', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (898, N'Dharmanagar', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (899, N'Mahemdabad', 11)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (900, N'Manendragarh', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (901, N'Uran', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (902, N'Tharamangalam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (903, N'Tirukkoyilur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (904, N'Pen', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (905, N'Makhdumpur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (906, N'Maner', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (907, N'Oddanchatram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (908, N'Palladam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (909, N'Mundi', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (910, N'Nabarangapur', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (911, N'Mudalagi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (912, N'Samalkha', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (913, N'Nepanagar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (914, N'Karjat', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (915, N'Ranavav', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (916, N'Pedana', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (917, N'Pinjore', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (918, N'Lakheri', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (919, N'Pasan', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (920, N'Puttur', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (921, N'Vadakkuvalliyur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (922, N'Tirukalukundram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (923, N'Mahidpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (924, N'Mussoorie', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (925, N'Muvattupuzha', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (926, N'Rasra', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (927, N'Udaipurwati', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (928, N'Manwath', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (929, N'Adoor', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (930, N'Uthamapalayam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (931, N'Partur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (932, N'Nahan', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (933, N'Ladwa', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (934, N'Mankachar', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (935, N'Nongstoin', 22)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (936, N'Losal', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (937, N'Sri Madhopur', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (938, N'Ramngarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (939, N'Mavelikkara', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (940, N'Rawatsar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (941, N'Rajakhera', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (942, N'Lar', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (943, N'Lal Gopalganj Nindaura', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (944, N'Muddebihal', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (945, N'Sirsaganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (946, N'Shahpura', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (947, N'Surandai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (948, N'Sangole', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (949, N'Pavagada', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (950, N'Tharad', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (951, N'Mansa', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (952, N'Umbergaon', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (953, N'Mavoor', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (954, N'Nalbari', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (955, N'Talaja', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (956, N'Malur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (957, N'Mangrulpir', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (958, N'Soro', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (959, N'Shahpura', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (960, N'Vadnagar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (961, N'Raisinghnagar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (962, N'Sindhagi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (963, N'Sanduru', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (964, N'Sohna', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (965, N'Manavadar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (966, N'Pihani', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (967, N'Safidon', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (968, N'Risod', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (969, N'Rosera', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (970, N'Sankari', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (971, N'Malpura', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (972, N'Sonamukhi', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (973, N'Shamsabad, Agra', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (974, N'Nokha', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (975, N'PandUrban Agglomeration', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (976, N'Mainaguri', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (977, N'Afzalpur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (978, N'Shirur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (979, N'Salaya', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (980, N'Shenkottai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (981, N'Pratapgarh', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (982, N'Vadipatti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (983, N'Nagarkurnool', 30)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (984, N'Savner', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (985, N'Sasvad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (986, N'Rudrapur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (987, N'Soron', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (988, N'Sholingur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (989, N'Pandharkaoda', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (990, N'Perumbavoor', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (991, N'Maddur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (992, N'Nadbai', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (993, N'Talode', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (994, N'Shrigonda', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (995, N'Madhugiri', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (996, N'Tekkalakote', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (997, N'Seoni-Malwa', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (998, N'Shirdi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (999, N'SUrban Agglomerationr', 32)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1000, N'Terdal', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1001, N'Raver', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1002, N'Tirupathur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1003, N'Taraori', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1004, N'Mukhed', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1005, N'Manachanallur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1006, N'Rehli', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1007, N'Sanchore', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1008, N'Rajura', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1009, N'Piro', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1010, N'Mudabidri', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1011, N'Vadgaon Kasba', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1012, N'Nagar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1013, N'Vijapur', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1014, N'Viswanatham', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1015, N'Polur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1016, N'Panagudi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1017, N'Manawar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1018, N'Tehri', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1019, N'Samdhan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1020, N'Pardi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1021, N'Rahatgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1022, N'Panagar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1023, N'Uthiramerur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1024, N'Tirora', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1025, N'Rangia', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1026, N'Sahjanwa', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1027, N'Wara Seoni', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1028, N'Magadi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1029, N'Rajgarh (Alwar)', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1030, N'Rafiganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1031, N'Tarana', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1032, N'Rampur Maniharan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1033, N'Sheoganj', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1034, N'Raikot', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1035, N'Pauri', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1036, N'Sumerpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1037, N'Navalgund', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1038, N'Shahganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1039, N'Marhaura', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1040, N'Tulsipur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1041, N'Sadri', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1042, N'Thiruthuraipoondi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1043, N'Shiggaon', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1044, N'Pallapatti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1045, N'Mahendragarh', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1046, N'Sausar', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1047, N'Ponneri', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1048, N'Mahad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1049, N'Lohardaga', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1050, N'Tirwaganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1051, N'Margherita', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1052, N'Sundarnagar', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1053, N'Rajgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1054, N'Mangaldoi', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1055, N'Renigunta', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1056, N'Longowal', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1057, N'Ratia', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1058, N'Lalgudi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1059, N'Shrirangapattana', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1060, N'Niwari', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1061, N'Natham', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1062, N'Unnamalaikadai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1063, N'PurqUrban Agglomerationzi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1064, N'Shamsabad, Farrukhabad', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1065, N'Mirganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1066, N'Todaraisingh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1067, N'Warhapur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1068, N'Rajam', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1069, N'Urmar Tanda', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1070, N'Lonar', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1071, N'Powayan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1072, N'P.N.Patti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1073, N'Palampur', 13)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1074, N'Srisailam Project (Right Flank Colony) Township', 2)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1075, N'Sindagi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1076, N'Sandi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1077, N'Vaikom', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1078, N'Malda', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1079, N'Tharangambadi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1080, N'Sakaleshapura', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1081, N'Lalganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1082, N'Malkangiri', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1083, N'Rapar', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1084, N'Mauganj', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1085, N'Todabhim', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1086, N'Srinivaspur', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1087, N'Murliganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1088, N'Reengus', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1089, N'Sawantwadi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1090, N'Tittakudi', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1091, N'Lilong', 21)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1092, N'Rajaldesar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1093, N'Pathardi', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1094, N'Achhnera', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1095, N'Pacode', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1096, N'Naraura', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1097, N'Nakur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1098, N'Palai', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1099, N'Morinda, India', 27)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1100, N'Manasa', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1101, N'Nainpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1102, N'Sahaspur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1103, N'Pauni', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1104, N'Prithvipur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1105, N'Ramtek', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1106, N'Silapathar', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1107, N'Songadh', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1108, N'Safipur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1109, N'Sohagpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1110, N'Mul', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1111, N'Sadulshahar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1112, N'Phillaur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1113, N'Sambhar', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1114, N'Prantij', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1115, N'Nagla', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1116, N'Pattran', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1117, N'Mount Abu', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1118, N'Reoti', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1119, N'Tenu dam-cum-Kathhara', 15)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1120, N'Panchla', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1121, N'Sitarganj', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1122, N'Pasighat', 3)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1123, N'Motipur', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1124, N'O'' Valley', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1125, N'Raghunathpur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1126, N'Suriyampalayam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1127, N'Qadian', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1128, N'Rairangpur', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1129, N'Silvassa', 8)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1130, N'Nowrozabad (Khodargama)', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1131, N'Mangrol', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1132, N'Soyagaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1133, N'Sujanpur', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1134, N'Manihari', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1135, N'Sikanderpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1136, N'Mangalvedhe', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1137, N'Phulera', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1138, N'Ron', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1139, N'Sholavandan', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1140, N'Saidpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1141, N'Shamgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1142, N'Thammampatti', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1143, N'Maharajpur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1144, N'Multai', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1145, N'Mukerian', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1146, N'Sirsi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1147, N'Purwa', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1148, N'Sheohar', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1149, N'Namagiripettai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1150, N'Parasi', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1151, N'Lathi', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1152, N'Lalganj', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1153, N'Narkhed', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1154, N'Mathabhanga', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1155, N'Shendurjana', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1156, N'Peravurani', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1157, N'Mariani', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1158, N'Phulpur', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1159, N'Rania', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1160, N'Pali', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1161, N'Pachore', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1162, N'Parangipettai', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1163, N'Pudupattinam', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1164, N'Panniyannur', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1165, N'Maharajganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1166, N'Rau', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1167, N'Monoharpur', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1168, N'Mandawa', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1169, N'Marigaon', 4)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1170, N'Pallikonda', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1171, N'Pindwara', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1172, N'Shishgarh', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1173, N'Patur', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1174, N'Mayang Imphal', 21)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1175, N'Mhowgaon', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1176, N'Guruvayoor', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1177, N'Mhaswad', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1178, N'Sahawar', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1179, N'Sivagiri', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1180, N'Mundargi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1181, N'Punjaipugalur', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1182, N'Kailasahar', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1183, N'Samthar', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1184, N'Sakti', 7)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1185, N'Sadalagi', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1186, N'Silao', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1187, N'Mandalgarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1188, N'Loha', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1189, N'Pukhrayan', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1190, N'Padmanabhapuram', 29)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1191, N'Belonia', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1192, N'Saiha', 23)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1193, N'Srirampore', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1194, N'Talwara', 27)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1195, N'Puthuppally', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1196, N'Khowai', 31)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1197, N'Vijaypur', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1198, N'Takhatgarh', 28)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1199, N'Thirupuvanam', 29)
GO
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1200, N'Adra', 34)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1201, N'Piriyapatna', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1202, N'Obra', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1203, N'Adalaj', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1204, N'Nandgaon', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1205, N'Barh', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1206, N'Chhapra', 11)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1207, N'Panamattom', 18)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1208, N'Niwai', 32)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1209, N'Bageshwar', 33)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1210, N'Tarbha', 25)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1211, N'Adyar', 16)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1212, N'Narsinghgarh', 19)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1213, N'Warud', 20)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1214, N'Asarganj', 5)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1215, N'Sarsod', 12)
INSERT [dbo].[CityMaster] ([Id], [City], [StateId]) VALUES (1219, N'Test City', 32)
SET IDENTITY_INSERT [dbo].[CityMaster] OFF
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([CompanyId], [CompanyName]) VALUES (1, N'Bytexus')
INSERT [dbo].[Company] ([CompanyId], [CompanyName]) VALUES (2, N'TCS')
SET IDENTITY_INSERT [dbo].[Company] OFF
SET IDENTITY_INSERT [dbo].[CreditCard] ON 

INSERT [dbo].[CreditCard] ([CardId], [BankId], [CardName], [CardDescription], [CardImageUrl]) VALUES (1, 4, N'Privilege Banking Edited', N'VISA Platinum ICICI Bank Debit Cards', N'\images\cards\26-07-201830923HD(17).jpg')
INSERT [dbo].[CreditCard] ([CardId], [BankId], [CardName], [CardDescription], [CardImageUrl]) VALUES (6, 1, N'Privilegeddddd Banking', N'VISA Platinum ICICI Bank Debit Cards', N'\images\cards\25-07-201843530482779_522055154512903_1646822345_n.jpg')
INSERT [dbo].[CreditCard] ([CardId], [BankId], [CardName], [CardDescription], [CardImageUrl]) VALUES (7, 1, N'Privilege Banking', N'VISA Platinum ICICI Bank Debit Cards', N'\images\cards\25-07-201843804426495_511678228883929_478420903_n.jpg')
SET IDENTITY_INSERT [dbo].[CreditCard] OFF
SET IDENTITY_INSERT [dbo].[Login] ON 

INSERT [dbo].[Login] ([LoginId], [LoginName], [Password], [UserName], [Mobile], [EmailId], [LastLogin]) VALUES (1, N'admin', N'admin', N'Avnish', N'7080506010', NULL, CAST(N'2018-07-24 23:17:02.450' AS DateTime))
SET IDENTITY_INSERT [dbo].[Login] OFF
SET IDENTITY_INSERT [dbo].[StateMaster] ON 

INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (1, N'Andaman and Nicobar Islands')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (2, N'Andhra Pradesh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (3, N'Arunachal Pradesh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (4, N'Assam')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (5, N'Bihar')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (6, N'Chandigarh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (7, N'Chhattisgarh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (8, N'Dadra and Nagar Haveli')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (9, N'Delhi')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (10, N'Goa')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (11, N'Gujarat')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (12, N'Haryana')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (13, N'Himachal Pradesh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (14, N'Jammu and Kashmir')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (15, N'Jharkhand')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (16, N'Karnataka')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (17, N'Karnatka')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (18, N'Kerala')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (19, N'Madhya Pradesh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (20, N'Maharashtra')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (21, N'Manipur')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (22, N'Meghalaya')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (23, N'Mizoram')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (24, N'Nagaland')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (25, N'Odisha')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (26, N'Puducherry')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (27, N'Punjab')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (28, N'Rajasthan')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (29, N'Tamil Nadu')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (30, N'Telangana')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (31, N'Tripura')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (32, N'Uttar Pradesh')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (33, N'Uttarakhand')
INSERT [dbo].[StateMaster] ([StateId], [State]) VALUES (34, N'West Bengal')
SET IDENTITY_INSERT [dbo].[StateMaster] OFF
SET IDENTITY_INSERT [dbo].[UserCCApplyDetail] ON 

INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (1, 1, N'bytexus', CAST(1213231.000000 AS Decimal(18, 6)), N'nirvesh', CAST(N'2018-07-16 00:00:00.000' AS DateTime), N'Lucknow', 11, 212112, N'897689', N'nirvesh@gmail.com', N'1,2', N'1', CAST(12313.000000 AS Decimal(18, 6)), 1, 0, 0, 0, 1, CAST(N'2018-07-16 06:27:35.913' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (2, 1, N'byt', CAST(98.000000 AS Decimal(18, 6)), N'nirv', CAST(N'2018-07-16 00:00:00.000' AS DateTime), N'Lucknow', 11, 1232, N'2342423423', N'sdf@dsd.sdfs', N'', N'', NULL, 0, 0, 0, 0, 0, CAST(N'2018-07-16 06:43:21.503' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (3, 1, N'byt', CAST(98.000000 AS Decimal(18, 6)), N'nirv', CAST(N'2018-07-16 00:00:00.000' AS DateTime), N'Lucknow', 11, 1232, N'2342423423', N'sdf@dsd.sdfs', N'1', N'1', CAST(123.000000 AS Decimal(18, 6)), 0, 0, 0, 0, 1, CAST(N'2018-07-16 06:43:26.987' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (4, 1, N'byt', CAST(98.000000 AS Decimal(18, 6)), N'nirv', CAST(N'2018-07-16 00:00:00.000' AS DateTime), N'Lucknow', 11, 1232, N'2342423423', N'sdf@dsd.sdfs', N'1', N'1', CAST(123.000000 AS Decimal(18, 6)), 0, 0, 0, 0, 1, CAST(N'2018-07-16 06:43:51.800' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (6, 1, N'Bytexus', CAST(123.000000 AS Decimal(18, 6)), N'doo', CAST(N'2018-07-17 00:00:00.000' AS DateTime), N'Lucknow', 0, 12321, N'3123', N'dsf@dasd.dasd', N'', N'', NULL, 0, 0, 0, 0, 1, CAST(N'2018-07-17 03:01:04.390' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (7, 0, N'', CAST(232.000000 AS Decimal(18, 6)), N'', NULL, N'', 0, 0, N'', N'', N'', N'', NULL, 0, 0, 0, 0, 0, CAST(N'2018-07-17 03:06:43.990' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (8, 1, N'TCS', CAST(11111.000000 AS Decimal(18, 6)), N'nirvesh', CAST(N'2018-07-18 00:00:00.000' AS DateTime), N'Lucknow', 0, 226010, N'12345431231', N'nirvesh0@gmail.com', N'1', N'1', NULL, 0, 0, 0, 0, 1, CAST(N'2018-07-18 01:17:40.697' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (9, 1, N'Meri Mudra', CAST(1000000.000000 AS Decimal(18, 6)), N'', NULL, N'', 0, 0, N'', N'', N'', N'', NULL, 0, 0, 0, 0, 0, CAST(N'2018-07-18 06:23:26.377' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (10, 1, N'Meri Mudra', CAST(100000.000000 AS Decimal(18, 6)), N'Avanish T', CAST(N'2018-07-04 00:00:00.000' AS DateTime), N'Lucknow', 0, 226001, N'7080506010', N'avanish32@gmail.com', N'1,2', N'1', CAST(50000.000000 AS Decimal(18, 6)), 0, 0, 0, 0, 1, CAST(N'2018-07-18 10:46:59.233' AS DateTime))
INSERT [dbo].[UserCCApplyDetail] ([Id], [EmployerType], [CompanyName], [GrossIncomeOrNetSalary], [Name], [DOB], [CityName], [CityId], [PinCode], [MobileNumber], [email], [AccountWith], [CreditCardWith], [CreditCardMaxLimit], [CurrentOrPrevLoan], [OTP], [isMobileNumberVerify], [isEmailVerify], [isUserActive], [CreatedDate]) VALUES (5, 1, N'Hcl', CAST(50000.000000 AS Decimal(18, 6)), N'Amit', CAST(N'2554-02-05 00:00:00.000' AS DateTime), N'kan', 63, 225020, N'234243234234', N'qwer@asdf.com', N'2,1', N'1', CAST(1110000.000000 AS Decimal(18, 6)), 0, 0, 0, 0, 1, CAST(N'2018-07-16 10:32:39.613' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserCCApplyDetail] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_BPP_Aadhar]    Script Date: 26-07-2018 21:55:11 ******/
ALTER TABLE [dbo].[BusinessPartnerProgramme] ADD  CONSTRAINT [UQ_BPP_Aadhar] UNIQUE NONCLUSTERED 
(
	[Aadhar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BusinessPartnerProgramme] ADD  CONSTRAINT [DF_BusinessPartnerProgramme_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] ADD  DEFAULT ((0)) FOR [isMobileNumberVerify]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] ADD  DEFAULT ((0)) FOR [isEmailVerify]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] ADD  DEFAULT ((0)) FOR [isUserActive]
GO
ALTER TABLE [dbo].[UserLoanApplyDetail] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CcDetails]  WITH CHECK ADD  CONSTRAINT [FK_CcDetails_CcInfoSectionMaster] FOREIGN KEY([CcInfoSectionMasterId])
REFERENCES [dbo].[CcInfoSectionMaster] ([CcInfoSectionMasterId])
GO
ALTER TABLE [dbo].[CcDetails] CHECK CONSTRAINT [FK_CcDetails_CcInfoSectionMaster]
GO
ALTER TABLE [dbo].[CcDetails]  WITH CHECK ADD  CONSTRAINT [FK_CcDetails_CreditCard] FOREIGN KEY([CardId])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CcDetails] CHECK CONSTRAINT [FK_CcDetails_CreditCard]
GO
ALTER TABLE [dbo].[CcDiscription]  WITH CHECK ADD  CONSTRAINT [FK_CcDiscription_CcDiscription] FOREIGN KEY([DiscriptionId])
REFERENCES [dbo].[CcDiscription] ([DiscriptionId])
GO
ALTER TABLE [dbo].[CcDiscription] CHECK CONSTRAINT [FK_CcDiscription_CcDiscription]
GO
ALTER TABLE [dbo].[CcDiscription]  WITH CHECK ADD  CONSTRAINT [FK_CcDiscription_CcMasterPoint] FOREIGN KEY([CcMasterPointsId])
REFERENCES [dbo].[CcMasterPoint] ([CcMasterPointId])
GO
ALTER TABLE [dbo].[CcDiscription] CHECK CONSTRAINT [FK_CcDiscription_CcMasterPoint]
GO
ALTER TABLE [dbo].[CcDiscription]  WITH CHECK ADD  CONSTRAINT [FK_CcDiscription_CreditCard] FOREIGN KEY([CardId])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CcDiscription] CHECK CONSTRAINT [FK_CcDiscription_CreditCard]
GO
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_StateMaster] FOREIGN KEY([StateId])
REFERENCES [dbo].[StateMaster] ([StateId])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_StateMaster]
GO
ALTER TABLE [dbo].[CreditCard]  WITH CHECK ADD  CONSTRAINT [FK_CreditCard_Bank] FOREIGN KEY([BankId])
REFERENCES [dbo].[Bank] ([BankId])
GO
ALTER TABLE [dbo].[CreditCard] CHECK CONSTRAINT [FK_CreditCard_Bank]
GO
/****** Object:  StoredProcedure [mmdb].[Insert_UserCCApplyDetail]    Script Date: 26-07-2018 21:55:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [mmdb].[Insert_UserCCApplyDetail]
@Id INT,
@employertype BIT=NULL,
@companyname VARCHAR(100)=NULL,
@grossincomeornetsalary DECIMAL(18,6) = NULL,
@name VARCHAR(100) =NULL,
@dob DATETIME= NULL,
@cityname VARCHAR(100) = NULL,
@cityid INT=NULL,
@pincode INT= NULL,
@mobilenumber VARCHAR(100) =NULL ,
@email VARCHAR(100) =NULL,
@accountwith VARCHAR(100) =NULL,
@creditcardwith VARCHAR(100) =NULL,
@creditcardmaxlimit VARCHAR(100)  =NULL,
@currentorprevloan bit=NULL,
@otp INT= NULL,
@ismobilenumberverify BIT= 0,
@isemailverify BIT=0,
@isuseractive BIT=0
AS
BEGIN
IF(@Id>0)
BEGIN
UPDATE UserCCApplyDetail
SET
	EmployerType = @employertype,
	CompanyName = @companyname,
	GrossIncomeOrNetSalary = @grossincomeornetsalary,
	Name = @name,
	DOB = @dob,
	CityName = @cityname,
	CityId = @cityid,
	PinCode = @pincode,
	MobileNumber = @mobilenumber,
	email = @email,
	AccountWith = @accountwith,
	CreditCardWith = @creditcardwith,
	CreditCardMaxLimit = @creditcardmaxlimit,
	CurrentOrPrevLoan = @currentorprevloan,
	OTP = @otp,
	isMobileNumberVerify = @ismobilenumberverify,
	isEmailVerify = @isemailverify,
	isUserActive = @isuseractive
WHERE  Id = @Id
SELECT @Id
END
ELSE
BEGIN

INSERT INTO UserCCApplyDetail (EmployerType, CompanyName, GrossIncomeOrNetSalary, Name, DOB, CityName, CityId, PinCode, MobileNumber, email, AccountWith, CreditCardWith, CreditCardMaxLimit, CurrentOrPrevLoan, OTP, isMobileNumberVerify, isEmailVerify, isUserActive)
VALUES (@employertype, @companyname, @grossincomeornetsalary, @name, @dob, @cityname, @cityid, @pincode, @mobilenumber, @email, @accountwith, @creditcardwith, @creditcardmaxlimit, @currentorprevloan, @otp, @ismobilenumberverify, @isemailverify, @isuseractive)

SELECT @@identity
END 


END
GO
/****** Object:  StoredProcedure [mmdb].[Insert_UserLoanApplyDetail]    Script Date: 26-07-2018 21:55:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [mmdb].[Insert_UserLoanApplyDetail]
@Id INT,
@employertype BIT=NULL,
@companyname VARCHAR(100)=NULL,
@grossincomeornetsalary DECIMAL(18,6) = NULL,
@name VARCHAR(100) =NULL,
@dob DATETIME= NULL,
@cityname VARCHAR(100) = NULL,
@cityid INT=NULL,
@pincode INT= NULL,
@mobilenumber VARCHAR(100) =NULL ,
@email VARCHAR(100) =NULL,
@accountwith VARCHAR(100) =NULL,
@creditcardwith VARCHAR(100) =NULL,
@creditcardmaxlimit VARCHAR(100)  =NULL,
@currentorprevloan bit=NULL,
@otp INT= NULL,
@ismobilenumberverify BIT= 0,
@isemailverify BIT=0,
@isuseractive BIT=0,
@Intended_loan_amount DECIMAL(18,6)=0
AS
BEGIN
IF(@Id>0)
BEGIN
UPDATE UserLoanApplyDetail
SET
	EmployerType = @employertype,
	CompanyName = @companyname,
	GrossIncomeOrNetSalary = @grossincomeornetsalary,
	Name = @name,
	DOB = @dob,
	CityName = @cityname,
	CityId = @cityid,
	PinCode = @pincode,
	MobileNumber = @mobilenumber,
	email = @email,
	AccountWith = @accountwith,
	CreditCardWith = @creditcardwith,
	CreditCardMaxLimit = @creditcardmaxlimit,
	CurrentOrPrevLoan = @currentorprevloan,
	OTP = @otp,
	isMobileNumberVerify = @ismobilenumberverify,
	isEmailVerify = @isemailverify,
	isUserActive = @isuseractive,
	Intended_loan_amount=@Intended_loan_amount
WHERE  Id = @Id
SELECT @Id
END
ELSE
BEGIN

INSERT INTO UserLoanApplyDetail (EmployerType, CompanyName, GrossIncomeOrNetSalary, Name, DOB, CityName, CityId, PinCode, MobileNumber, email, AccountWith, CreditCardWith, CreditCardMaxLimit, CurrentOrPrevLoan, OTP, isMobileNumberVerify, isEmailVerify, isUserActive,Intended_loan_amount)
VALUES (@employertype, @companyname, @grossincomeornetsalary, @name, @dob, @cityname, @cityid, @pincode, @mobilenumber, @email, @accountwith, @creditcardwith, @creditcardmaxlimit, @currentorprevloan, @otp, @ismobilenumberverify, @isemailverify, @isuseractive,@Intended_loan_amount)

SELECT @@identity
END 


END
GO
USE [master]
GO
ALTER DATABASE [mmdb] SET  READ_WRITE 
GO

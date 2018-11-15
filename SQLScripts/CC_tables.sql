USE [mmdb]
GO
/****** Object:  Table [dbo].[CCBenefitsAndFeature]    Script Date: 11/15/2018 11:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCBenefitsAndFeature](
	[BenefitsAndFeatureId] [int] IDENTITY(1,1) NOT NULL,
	[CardID] [int] NOT NULL,
	[Heading] [varchar](max) NULL,
	[Point] [varchar](max) NULL,
 CONSTRAINT [PK_CCFeaturesAndBenefits] PRIMARY KEY CLUSTERED 
(
	[BenefitsAndFeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCBorrowAndPrivileges]    Script Date: 11/15/2018 11:03:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCBorrowAndPrivileges](
	[BorrowAndPivilegesID] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[Heading] [varchar](max) NULL,
	[Keys] [varchar](max) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_CCBorrowAndPrivileges] PRIMARY KEY CLUSTERED 
(
	[BorrowAndPivilegesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCFeesAndBenefits]    Script Date: 11/15/2018 11:03:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCFeesAndBenefits](
	[FeesAndBenefitsID] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[Heading] [varchar](max) NULL,
	[Keys] [varchar](max) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_CCFeesAndBenefits] PRIMARY KEY CLUSTERED 
(
	[FeesAndBenefitsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCHightlights]    Script Date: 11/15/2018 11:03:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCHightlights](
	[HighlightsID] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[Heading] [varchar](max) NULL,
	[Descreption] [varchar](max) NULL,
 CONSTRAINT [PK_CCHightlights] PRIMARY KEY CLUSTERED 
(
	[HighlightsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCRedeemRewards]    Script Date: 11/15/2018 11:03:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCRedeemRewards](
	[RedeemRewardsID] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[Heading] [varchar](max) NULL,
	[Keys] [varchar](max) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_CCRedeemRewards] PRIMARY KEY CLUSTERED 
(
	[RedeemRewardsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CCBenefitsAndFeature]  WITH CHECK ADD  CONSTRAINT [FK_CCFeaturesAndBenefits_CreditCard] FOREIGN KEY([CardID])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CCBenefitsAndFeature] CHECK CONSTRAINT [FK_CCFeaturesAndBenefits_CreditCard]
GO
ALTER TABLE [dbo].[CCBorrowAndPrivileges]  WITH CHECK ADD  CONSTRAINT [FK_CCBorrowAndPrivileges_CreditCard] FOREIGN KEY([CardID])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CCBorrowAndPrivileges] CHECK CONSTRAINT [FK_CCBorrowAndPrivileges_CreditCard]
GO
ALTER TABLE [dbo].[CCFeesAndBenefits]  WITH CHECK ADD  CONSTRAINT [FK_CCFeesAndBenefits_CreditCard] FOREIGN KEY([CardID])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CCFeesAndBenefits] CHECK CONSTRAINT [FK_CCFeesAndBenefits_CreditCard]
GO
ALTER TABLE [dbo].[CCHightlights]  WITH CHECK ADD  CONSTRAINT [FK_CCHightlights_CreditCard] FOREIGN KEY([CardID])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CCHightlights] CHECK CONSTRAINT [FK_CCHightlights_CreditCard]
GO
ALTER TABLE [dbo].[CCRedeemRewards]  WITH CHECK ADD  CONSTRAINT [FK_CCRedeemRewards_CreditCard] FOREIGN KEY([CardID])
REFERENCES [dbo].[CreditCard] ([CardId])
GO
ALTER TABLE [dbo].[CCRedeemRewards] CHECK CONSTRAINT [FK_CCRedeemRewards_CreditCard]
GO

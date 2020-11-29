CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Password] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaresBank](
	[BankTransID] [bigint] IDENTITY(1,1) NOT NULL,
	[TransAmount] [money] NULL,
	[Type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StaffID] [int] NULL,
	[LocationID] [int] NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_CaresBank] PRIMARY KEY CLUSTERED 
(
	[BankTransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaresFund](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionAmount] [money] NULL,
	[Destination] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CaresFund] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[CommentContent] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StaffID] [int] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonationInventory](
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArticleType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArticleLocationID] [int] NULL,
	[ArticleDescription] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArticlePrice] [money] NULL,
	[ArticleSold] [bit] NULL,
	[DateSold] [date] NULL,
	[DateArrived] [date] NULL,
	[ArticleSize] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_DonationInventory] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EventDate] [date] NULL,
	[EventDescription] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventAttendees](
	[EventID] [int] NULL,
	[StaffID] [int] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hours](
	[HoursID] [int] IDENTITY(1,1) NOT NULL,
	[StaffID] [int] NULL,
	[TimeIn] [time](7) NULL,
	[TimeOut] [time](7) NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_Hours] PRIMARY KEY CLUSTERED 
(
	[HoursID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationAddress] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationCity] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationZipCode] [int] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonetaryDonations](
	[DonationID] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [money] NULL,
	[DonationDate] [date] NULL,
	[DonatorName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_MonetaryDonations] PRIMARY KEY CLUSTERED 
(
	[DonationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayRate](
	[StaffType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PerHour] [int] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationID] [int] NULL,
	[Manager] [bit] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Password] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StaffPicture] [image] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffComments](
	[StaffID] [int] NULL,
	[CommentID] [int] NULL
)

GO
ALTER TABLE [dbo].[CaresBank]  WITH CHECK ADD  CONSTRAINT [FK_CaresBank_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[CaresBank] CHECK CONSTRAINT [FK_CaresBank_Location]
GO
ALTER TABLE [dbo].[CaresBank]  WITH CHECK ADD  CONSTRAINT [FK_CaresBank_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[CaresBank] CHECK CONSTRAINT [FK_CaresBank_Staff]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Staff]
GO
ALTER TABLE [dbo].[DonationInventory]  WITH CHECK ADD  CONSTRAINT [FK_DonationInventory_Location] FOREIGN KEY([ArticleLocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[DonationInventory] CHECK CONSTRAINT [FK_DonationInventory_Location]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Location]
GO
ALTER TABLE [dbo].[EventAttendees]  WITH CHECK ADD  CONSTRAINT [FK_EventAttendees_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventAttendees] CHECK CONSTRAINT [FK_EventAttendees_Event]
GO
ALTER TABLE [dbo].[EventAttendees]  WITH CHECK ADD  CONSTRAINT [FK_EventAttendees_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[EventAttendees] CHECK CONSTRAINT [FK_EventAttendees_Staff]
GO
ALTER TABLE [dbo].[Hours]  WITH CHECK ADD  CONSTRAINT [FK_Hours_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Hours] CHECK CONSTRAINT [FK_Hours_Staff]
GO
ALTER TABLE [dbo].[StaffComments]  WITH CHECK ADD  CONSTRAINT [FK_StaffComments_Comments] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comments] ([CommentID])
GO
ALTER TABLE [dbo].[StaffComments] CHECK CONSTRAINT [FK_StaffComments_Comments]
GO
ALTER TABLE [dbo].[StaffComments]  WITH CHECK ADD  CONSTRAINT [FK_StaffComments_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[StaffComments] CHECK CONSTRAINT [FK_StaffComments_Staff]
GO

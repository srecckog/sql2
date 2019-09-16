USE [RFIND]
GO

/****** Object:  Table [dbo].[Satnica]    Script Date: 08.05.2017. 13:01:00 ******/
DROP TABLE [dbo].[Satnica]
GO

/****** Object:  Table [dbo].[Satnica]    Script Date: 08.05.2017. 13:01:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Satnica](
	[Firma] [int] NULL,
	[Radnikid] [int] NULL,
	[Ime] [varchar](50) NULL,
	[Godina] [int] NULL,
	[Mjesec] [int] NULL,
	[SatnicaStara] [int] NULL,
	[Satnica] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



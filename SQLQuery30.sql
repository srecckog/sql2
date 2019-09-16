USE [RFIND]
GO

/****** Object:  Table [dbo].[DPR]    Script Date: 17.4.2018. 11:45:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DPR1](
	[Datum] [date] NULL,
	[ID_kupac] [nvarchar](10) NULL,
	[Kupac] [nvarchar](50) NULL,
	[Kolicina_TOK] [int] NULL,
	[Kolicina_DO] [int] NULL,
	[Vrijednost_TOK] [decimal](18, 2) NULL,
	[Vrijednost_DO] [decimal](18, 2) NULL,
	CT int null,
	CM int null,
	CG int null,
	[DatumUnosa] [datetime] NULL
) ON [PRIMARY]

GO



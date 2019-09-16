USE [RFIND]
GO

/****** Object:  Table [dbo].[RADNICI_]    Script Date: 31.8.2018. 7:24:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[RADNICI_2](
	[id] [int] NULL,
	[ime] [nvarchar](255) NULL,
	[prezime] [nvarchar](255) NULL,
	[DatumZaposlenja] [date] NULL,
	[DatumPrestanka] [date] NULL,
	[Ulica] [varchar](50) NULL,
	[Grad] [varchar](30) NULL,
	[Posta] [varchar](6) NULL,
	[Telefon1] [varchar](15) NULL,
	[Telefon2] [varchar](15) NULL,
	[custid] [varchar](10) NULL,
	[rfid] [float] NULL,
	[rfidhex] [varchar](16) NULL,
	[lokacija] [float] NULL,
	[mt] [float] NULL,
	[radnomjesto] [nvarchar](255) NULL,
	[rfid2] [varchar](21) NULL,
	[poduzece] [varchar](9) NOT NULL,
	[sifrarm] [nvarchar](255) NULL,
	[rv] [int] NOT NULL,
	[Neradi] [int] NULL,
	[FixnaIsplata] [int] NULL,
	idradnika int null
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



USE [RFIND]
GO

/****** Object:  Table [dbo].[Norme_log]    Script Date: 22.1.2019. 7:19:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Norme_log2](
	[datum] [date] NULL,
	[id_pro] [nchar](10) NULL,
	[staranorma] [int] NULL,
	[novanorma] [int] NULL,
	[hala] [nchar](10) NULL,
	[linija] [nchar](15) NULL,
	hostname [nchar](25) NULL
) ON [PRIMARY]
GO



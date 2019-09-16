USE FeroApp

SELECT EPV.BrojRN, (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = EPV.ID_Pro) AS Pozicija, SUM(EPV.OtpadMaterijal) AS Otpad_mat, SUM(EPV.OtpadObrada) AS Otpad_obrada 
       FROM EvidencijaProizvodnjeView EPV 
       WHERE EPV.Datum >= '2017-01-01' 
             AND EPV.BrojRN IN 
			 
			 (
			 SELECT NS.BrojRN 
			 FROM NarudzbeSta NS 
			 WHERE NS.Obrada1 = 0 AND NS.Obrada2 = 1) 

       GROUP BY EPV.BrojRN, EPV.ID_Pro 



	   SELECT *
	   FROM NarudzbeSta NS 
	   WHERE NS.Obrada1 = 0 AND NS.Obrada2 = 1

-- Strukture tabele  Narudzbesta

    TABLE [dbo].[NarudzbeSta](
	[ID_NarS] [int] IDENTITY(1,1) NOT NULL,
	[ID_NarZ] [varchar](20) NULL,
	[PozicijaKupac] [varchar](5) NULL,
	[ID_Pro] [int] NULL,
	[ID_Mat] [int] NULL,
	[NazivPro] [varchar](60) NULL,
	[BrojSarze] [varchar](15) NULL,
	[CijenaMatTona] [decimal](11, 2) NULL,
	[KolicinaNar] [decimal](11, 2) NULL,
	[Obrada1] [smallint] NULL,
	[CijenaObrada1] [decimal](14, 5) NULL,
	[CijenaObrada1B] [decimal](14, 5) NULL,
	[CijenaObrada1C] [decimal](14, 5) NULL,
	[BrojRN1] [varchar](20) NULL,
	[BrojNar1] [varchar](20) NULL,
	[Obrada2] [smallint] NULL,
	[CijenaObrada2] [decimal](14, 5) NULL,
	[BrojRN2] [varchar](20) NULL,
	[BrojNar2] [varchar](20) NULL,
	[Obrada3] [smallint] NULL,
	[CijenaObrada3] [decimal](14, 5) NULL,
	[BrojRN3] [varchar](20) NULL,
	[BrojNar3] [varchar](20) NULL,
	[Obrada4] [smallint] NULL,
	[CijenaObrada4] [decimal](14, 5) NULL,
	[BrojRN4] [varchar](20) NULL,
	[BrojNar4] [varchar](20) NULL,
	[Obrada5] [smallint] NULL,
	[CijenaObrada5] [decimal](14, 5) NULL,
	[BrojRN5] [varchar](20) NULL,
	[BrojNar5] [varchar](20) NULL,
	[DatumIsporuke] [date] NULL,
	[Z_FiRupe] [varchar](10) NULL,
	[PostotakNaBrutto] [smallint] NULL,
	[TezinaSirovcaNetto] [decimal](11, 5) NULL,
	[DodatakNaMaluSerijuNar] [decimal](11, 2) NULL,
	[DodatakNaMaluSerijuKom] [decimal](11, 5) NULL,
	[FakturnaCijena] [decimal](14, 5) NULL,
	[OznakaMatPro] [varchar](20) NULL,
	[LoanPosao] [tinyint] NULL,
	[BrojRN] [varchar](20) NULL,
	[BazniRN] [tinyint] NULL,
	[Aktivno] [tinyint] NULL,
	[Isporuceno] [tinyint] NULL,
	[BrojRN_Veza] [varchar](20) NULL,
	[Napomena] [varchar](30) NULL,
	[UserName] [varchar](30) NULL,
	[DatumOtvaranjaRN] [date] NULL,
	[DatumDovrsetkaRN] [date] NULL,
	[KolicinaMaleSerije] [decimal](11, 2) NULL,
	[ParentRN] [varchar](20) NULL,
	[Nacrt_Index] [varchar](10) NULL,
	[Nacrt_ECV] [varchar](50) NULL,
 CONSTRAINT [KeyNarS:ID] PRIMARY KEY CLUSTERED 


	
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[idpar1]
      ,[idpar2]
      ,[idpare3]
      ,[idpar4]
  FROM [Planiranje].[dbo].[GrupePartnera]


  select '' id, id_par , nazivpar kupac into grupekupci
  from feroapp.dbo.partneri
  where kratkinazivikupca is not null
  --here nazivpar like '%schwein%'


  --update feroapp.dbo.partneri set KratkiNaziviKupca='BMW' where id_par=121277
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Datum]
      ,[ID_kupac]
      ,p.NazivPar
      ,[Kolicina_TOK]
      ,[Kolicina_DO]
      ,[Vrijednost_TOK]
      ,[Vrijednost_DO]
      ,max([DatumUnosa]) datumunosa
  FROM [RFIND].[dbo].[DPR]
  left join feroapp.dbo.partneri p on p.id_par=dpr.ID_kupac
  group by [Datum]
      ,[ID_kupac]
      ,p.NazivPar
      ,[Kolicina_TOK]
      ,[Kolicina_DO]
      ,[Vrijednost_TOK]
      ,[Vrijednost_DO]
  order by datum,datumunosa desc
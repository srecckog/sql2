/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Datum]
      ,[ID_kupac]
      ,[Kupac]
      ,[Kolicina_TOK]
      ,[Kolicina_DO]
      ,[Vrijednost_TOK]
      ,[Vrijednost_DO]
      ,[DatumUnosa]
  FROM [RFIND].[dbo].[DPR]
  order by datum desc
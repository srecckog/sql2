/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Datum]
      ,[Korisnik]
      ,[Korisnik_ID]
      ,[Opis]
      ,[IDprijave]
  FROM [RFIND].[dbo].[kks_log]
  where datum>='2019-03-01' AND OPIS LIKE '%474%'
  order by datum 


  SELECT TOP (1000) [Datum]
      ,[Korisnik]
      ,[Korisnik_ID]
      ,[Opis]
      ,[IDprijave]
  FROM [RFIND].[dbo].[kks_log]
  order by datum desc
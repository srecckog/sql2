/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Datum]
      ,[Korisnik]
      ,[Korisnik_ID]
      ,[Opis]
      ,[IDprijave]
  FROM [RFIND].[dbo].[infokiosk_log]
  order by datum desc

 -- delete from infokiosk_log where korisnik='Sistem'
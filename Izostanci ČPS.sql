/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_SKL]
      ,[Nazivskladista]
      ,[Kolicina]
      ,[Tezina]
      ,[Vrijednost]
      ,[Datum]
      ,[Tjedan]
      ,[Mjesec]
      ,[Godina]
  FROM [RFIND].[dbo].[ReproMaterijal2]


SELECT [ID_SKL]
      ,[Nazivskladista]
      ,[Kolicina]
      ,[Tezina]
      ,[Vrijednost]
      ,[Datum]
      ,[Tjedan]
      ,[Mjesec]
      ,[Godina]

	  int 
  FROM [RFIND].[dbo].[ReproMaterijal2]


  insert into repormaterijal2 ( [ID_SKL]
      ,[Nazivskladista]
      ,[Kolicina]
      ,[Tezina]
      ,[Vrijednost]
      ,[Datum]
      ,[Tjedan]
      ,[Mjesec]
      ,[Godina] )

	  select [ID_SKL]
      ,[Nazivskladista]
      ,[Kolicina]
      ,[Tezina]
      ,[Vrijednost]
      ,[Datum]


	  use rfind
	  select *
	  from pregledvremena
	  where idradnika=1426


	  update pregledvremena set ukupno_minuta=960 where datum='2017-12-23' and idradnika=1426
      
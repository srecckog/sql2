/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Ime]
      ,[Mjesec]
      ,[Brojdana]
      ,[Razlog]
      ,[Godina]
      ,[SN]
      ,[NN]
      ,[Firma]
  FROM [RFIND].[dbo].[stat_bo2]
  where id=984


  select *
  from pregledvremena
  where idradnika=984
  and month(datum)=04 and PreranoOtisao>0


  select *
  from [fxsap].dbo.plansatirada
  where radnikid=984
  and godina=2017

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[acWorker]
      ,[datum_zaposljavanja]
      ,[Poduzece]
      ,[mt]
  FROM [RFIND].[dbo].[panth_radnici]


  use 


  select * 
  from panth_radnici
  where id not in
  (
  select idradnika
  from pregledvremena
  where datum='2017-07-27'
   )
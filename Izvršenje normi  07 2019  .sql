/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [ID]
      ,[Firma]
      ,[Datum]
      ,[Ime]
      ,[mt]
      ,[funkcija]
      ,[hala]
      ,[Smjena]
      ,[Posto]
      ,[Norma]
      ,[KolicinaOK]
      ,[KolicinaOK2]
      ,[minuta]
      ,[N1]
      ,[N2]
      ,[N3]
      ,[SA]
      ,[psr]



select id,firma,ime,funkcija,hala,cast( avg(posto)*100 as float) Posto_average
  FROM [RFIND].[dbo].[MINorm]
  where datum>='2019-07-01'
  and norma>1 and KolicinaOK>0
  group by id,firma,ime,funkcija,hala
  order by ime


select count(*)
from (  
select id,firma,ime,funkcija,hala,datum,norma,kolicinaok,cast (  (KolicinaOK/(norma+0.00001))*100 as float)  posto
  FROM [RFIND].[dbo].[MINorm]
  where datum>='2019-07-01'
  and norma>1 and KolicinaOK>0
  and  ((KolicinaOK/(norma+0.00001))*100)>=100 and  ((KolicinaOK/(norma+0.00001))*100)<=100000
  group by id,firma,ime,funkcija,hala,datum,norma,kolicinaok
) x1



  order by ime
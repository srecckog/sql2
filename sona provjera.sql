/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[datum]
      ,[hala]
      ,[linija]
      ,[smjena]
      ,[proizvod]
      ,[norma]
      ,[max]
      ,[cijena]
      ,[kolicina]
      ,[iznos]
      ,[radnik]
      ,[ID_Partner]
      ,[kvarovi]
      ,[bolovanja]
      ,[materijal]
      ,[alati]
      ,[izostanci]
      ,[stelanja]
      ,[stelanja_minuta]
      ,[kvarovi_minuta]
      ,[idealno]
      ,[skart_obrada]
      ,[skart_materijal]
      ,[turm]
      ,[UkupnoIspravno]
  FROM [FxApp].[dbo].[ldp_aktivnost]
  where datum='2017-04-11'
  and hala=3 and linija in ( '19')
  and kolicina>0
  order by datum,smjena


  select sum(skart_obrada),sum(skart_materijal)
  from ldp_aktivnost
  where hala=3 and linija in ( '05')
  and datum='2017-04-11'



  select distinct  hala,linija,smjena,proizvod,datum,norma,max,kolicina
  from ldp_aktivnost
  where proizvod in 
  (
'1-57926-0000-MB-00',
'1-58080-0000-MB-00',
'1-58081-0000-MB-01',
'1-58089-0000-MB-00',
'1-58102-0000-MB-00',
'1-58233-0000-MB-00',
'1-58234-0000-MB-00',
'1-58235-0000-MB-00'
)
and datum>='2017-04-12'
and linija='35' and smjena=1
order by proizvod,hala,linija,smjena,datum

use
select *
from evidnormi('2017-04-12','2017-04-12',0)


select *
from ldp_aktivnost
where datum='2017-04-10'
and hala=3 and linija='19'



 select distinct  hala,linija,smjena,proizvod,datum,norma,max,kolicina,idealno,stelanja
  from ldp_aktivnost
  where proizvod in 
  (
'1-57926-0000-MB-00',
'1-58080-0000-MB-00',
'1-58081-0000-MB-01',
'1-58089-0000-MB-00',
'1-58102-0000-MB-00',
'1-58233-0000-MB-00',
'1-58234-0000-MB-00',
'1-58235-0000-MB-00'
)
and datum='2017-04-11'
order by proizvod,datum,hala,linija



 select distinct  hala,linija,smjena,proizvod,datum,norma,max,kolicina,idealno,stelanja
  from ldp_aktivnost
  where proizvod in 
  (
'1-57926-0000-MB-00',
'1-58080-0000-MB-00',
'1-58081-0000-MB-01',
'1-58089-0000-MB-00',
'1-58102-0000-MB-00',
'1-58233-0000-MB-00',
'1-58234-0000-MB-00',
'1-58235-0000-MB-00'
)
and datum>='2017-04-12'
order by proizvod,datum,hala,linija

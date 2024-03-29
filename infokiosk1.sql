/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
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
  FROM [RFIND].[dbo].[MINorm]
  where hala=0
  order by datum desc





  select m.datum,j.norma,sum(m.norma) planirano,sum(kolicinaok) kolicina,m.hala,datepart(week,m.datum) tjedan,month(m.datum) mjesec,year(m.datum) godina
  from minorm m
  inner join (
  select sum(norma) norma,hala,datum
  from feroapp.dbo.evidnormi('2018-11-01','2018-12-03',0)
  group by hala,datum
  ) j on j.hala=m.hala and m.datum=j.datum
  where m.datum=j.datum and m.hala=j.hala
  group by m.hala,j.norma,m.datum
  order by datum

  
  select sum(norma)
  from feroapp.dbo.evidnormi('2018-11-30','2018-11-30',0)
  where hala=1

  
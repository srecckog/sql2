/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (100000) [ID]
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
  where month(datum)=11 and year(datum)=2018
  order by datum

  --delete from rfind.dbo.minorm

  select r.id,prezime,ime,r.mt, x1.*
  from radnici_ r 
  left join (
  select cast( max( (kolicinaok+0.00001)/norma ) as decimal(5,2)) maxposto , cast(min((kolicinaok+0.00001)/norma) as decimal (5,2)) minposto,cast( AVG((kolicinaok+0.00001)/norma) as decimal(5,2)) averageposto,id
  FROM [RFIND].[dbo].[MINorm]
  where month(datum)=11 and year(datum)=2018 and norma>1
  group by id
  ) x1 on r.id=x1.id
  where neradi=0
  and r.fixnaisplata=0
  and mt not in ( 702,716,710,701,713,712)
  and x1.averageposto>3
  order by r.prezime
  


  
  select cast( max( (kolicinaok+0.00001)/norma ) as decimal(5,2)) maxposto , cast(min((kolicinaok+0.00001)/norma) as decimal (5,2)) minposto,cast( AVG((kolicinaok+0.00001)/norma) as decimal(5,2)) averageposto
  FROM [RFIND].[dbo].[MINorm]
  where month(datum)=11 and year(datum)=2018 and norma>1
  

  -- zeleni po tjednima
  select datepart(week,datum) tjedan, count(*) broj_zelenih
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  and posto>=1 --and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)
    
  -- narančasti po tjednima
  select datepart(week,datum) tjedan, count(*) broj_narančastih
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  and posto>=0.9 and posto<1 --and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)

-- crveni po tjednima
  select datepart(week,datum) tjedan, count(*) broj_crvenih
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (11, 10) and year(datum)=2018 and norma>1
  and posto<0.9 --and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)

-- prosječni postotak po tjednima  
  select datepart(week,datum) tjedan,avg(posto) posto_realizacije
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in ( 10,11) and year(datum)=2018 and norma>1
  --and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)

  --- po danima
  
  -- zeleni po datumu
  select count(*) broj_zelenih,datum
  FROM [RFIND].[dbo].[MINorm]
  where datum='2018-10-16' and norma>1
  and posto>=0.9 
  group by datum
  order by datum

-- crveni po tjednima
  select count(*) broj_crvenih,datepart(week,datum) tjedan
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (11, 10) and year(datum)=2018 and norma>1
  and posto<0.9 and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)

-- prosječni postotak po tjednima  
  select datepart(week,datum) tjedan,avg(posto) posto_realizacije
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in ( 10,11) and year(datum)=2018 and norma>1
  and hala=1
  group by datepart(week,datum)
  order by datepart(week,datum)



  select distinct ime
  FROM [RFIND].[dbo].[MINorm]
  where datum='2018-10-16' and norma>1
  and posto<0.9   
  order by ime

  
  select  avg(posto)
  FROM [RFIND].[dbo].[MINorm]
  where datum='2018-10-16' and norma>1
  
  

  select datepart(week,datum) tjedan, id,avg(posto) posto1
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  and posto>=1 --and hala=1
  group by datepart(week,datum),id
  order by datepart(week,datum)
  
-------------------------
--  27.11.2018
-------------------------
  select tjedan,count(*) broj_zelenih
  from (
  select datepart(week,datum) tjedan, id,avg(posto) posto1
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  --and posto>=1 --and hala=1
  and hala=1
  group by datepart(week,datum),id
  ) x1
  where posto1>1
  group by tjedan
  order by tjedan

  select tjedan,count(*) broj_narančasti
  from (
  select datepart(week,datum) tjedan, id,avg(posto) posto1
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  --and posto>=1 --and hala=1
  and hala=1
  group by datepart(week,datum),id
  ) x1
  where posto1>=0.9 and posto1<1
  group by tjedan
  order by tjedan


  select tjedan,count(*) broj_crvenih
  from (
  select datepart(week,datum) tjedan, id,avg(posto) posto1
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  --and posto>=1 --and hala=1
  and hala=1
  group by datepart(week,datum),id
  ) x1
  where posto1<0.9
  group by tjedan
  order by tjedan


  select tjedan,avg(posto1) posto
  from (
  select datepart(week,datum) tjedan, id,avg(posto) posto1
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  --and posto>=1 --and hala=1
  group by datepart(week,datum),id
  ) x1
  group by tjedan
  order by tjedan




  -- det
  -------------------------
  select tjedan,count(*) broj_zelenih
  from (
  select datepart(week,datum) tjedan, id,ime
  FROM [RFIND].[dbo].[MINorm]
  where month(datum) in (10,11) and year(datum)=2018 and norma>1
  --and posto>=1 --and hala=1
  and datepart(week,datum)=43
  --and datum='2018-10-22'
  and hala=1  --and smjena=3
  and posto<0.9
  group by datepart(week,datum),id,ime
  
  ) x1
  --where posto1<0.91

  group by tjedan
  order by tjedan



  -- crveni po tjednima
  select count(*) broj_crvenih,datum datum
  FROM [RFIND].[dbo].[MINorm]
  where   datepart(week,datum)=43 and year(datum)=2018 and norma>1
  and posto<0.9 and hala=1
  group by datum
  order by datum

  --------------------------------------------------------
  ---  28.11.2018
  --------------------------------------------------------
  select datepart(week,datum) tjedan,count(*) broj_crvenih
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>=1
  and posto<0.9 and hala=1 and datum='2018-10-20' and hala=1
  --group by datum
  group by datepart(week,datum)
  order by datepart(week,datum)


  select datepart(week,datum) tjedan,count(*) broj_narančasti
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and posto>=0.9 and posto<1  and hala=1
  --group by datum
  group by datepart(week,datum)
  order by datepart(week,datum)

  select datepart(week,datum) tjedan,count(*) broj_zeleni
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and posto>=1 and hala=1
  --group by datum
  group by datepart(week,datum)
  order by datepart(week,datum)



  select datepart(week,datum) tjedan, avg(posto) postocrveni,smjena,datum
  from(
  select distinct ime,datum,smjena,count(*) broj ,posto
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and posto<0.9  and  hala=1 --and smjena=1  --and smjena=1 and datum='2018-10-20'
  --and datum='2018-10-15'
  --group by datum
  --group by datepart(week,datum)
  group by ime,datum,smjena,posto
  ) x1
  --where datepart(week,datum)=42 and smjena=2
  group by datepart(week,datum),smjena,datum
  order by datepart(week,datum),datum,smjena


  select *
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and posto<0.9  and  hala=1 and smjena=1 --and smjena=1 and datum='2018-10-20'
  and datum='2018-10-15'
  --group by datum
  --group by datepart(week,datum)
  order by ime

  

   select datepart(week,datum) tjedan, avg(posto)postocrveni
  from(
  select distinct ime,datum,smjena,count(*) broj ,posto
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and posto>=1.3   and  hala=1 --and smjena=1  --and smjena=1 and datum='2018-10-20'
  --and datum='2018-10-15'
  --group by datum
  --group by datepart(week,datum)
  group by ime,datum,smjena,posto
  ) x1
  --where datepart(week,datum)=42 and smjena=2
  having avg(posto)<=0.7
  group by datepart(week,datum)
  order by datepart(week,datum)




  select  tjedan, count(*) brojcrveni
  from (
  
  select datepart(week,datum) tjedan, avg(posto) postocrveni,ID
  from(
  select distinct ID,datum,smjena,posto
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1
  and hala=1 --and smjena=1  --and smjena=1 and datum='2018-10-20'
  --and datum='2018-10-15'
  --group by datum
  --group by datepart(week,datum)
  group by iD,datum,smjena,posto
  ) x1
  group by datepart(week,datum),ID
  having avg(posto)<=0.7 -->=1 AND avg(posto)<3 --and datepart(week,datum)=47
    ) x1
  group by tjedan
  order by tjedan


  select DISTINCT ID
 FROM [RFIND].[dbo].[MINorm]
  where datepart(week,datum)=47 AND NORMA>1
  AND HALA=1
  --and ime like 'ŽUPAN%'


  select DISTINCT IDRADNIKA,RADNOMJESTO
 FROM [RFIND].[dbo].PREGLEDVREMENA
  where datepart(week,datum)=47 
  AND HALA='1' AND DATUM='2018-11-19'
  AND RADNOMJESTO IN ('BO','GO','B.O.','G.O.')
  

  select DISTINCT ID
 FROM [RFIND].[dbo].[MINorm]
  where datepart(week,datum)=47 AND NORMA>1
  AND HALA=1 AND DATUM='2018-11-19'
  ORDER BY ID



  select id,avg(posto) 
  from [RFIND].[dbo].[MINorm]
  where datepart(week,datum)=36 AND NORMA>1 and hala=1
  group by id
  having avg(posto)<=0.7
  
  

  select tjedan,count(*) broj1
  from(
  select  id,avg(posto) posto1 ,datepart(week,datum) tjedan
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11,12)  and year(datum)=2018 and norma>1 and hala=1
  --and posto<=0.7   and  hala=1 --and smjena=1  --and smjena=1 and datum='2018-10-20'
  --and datum='2018-10-15'
  --group by datum
  --group by datepart(week,datum)
  group by id,datepart(week,datum)
  ) x1
  --where datepart(week,datum)=42 and smjena=2
  --where posto1<0.7
  --where posto1>=0.7 and posto1<0.9
  --where posto1>=0.9 and posto1<1
 where posto1>=1
  group by tjedan
  order by tjedan



  select * from (
  select  id,ime,avg(posto) posto1 ,datepart(week,datum) tjedan
  FROM [RFIND].[dbo].[MINorm]
  where   month(datum) in ( 9,10,11)  and year(datum)=2018 and norma>1 and hala=1
  --and posto<=0.7   and  hala=1 --and smjena=1  --and smjena=1 and datum='2018-10-20'
  and datepart(week,datum)=44
  --group by datum
  --group by datepart(week,datum)
  group by id,ime,datepart(week,datum)
  ) x1 
  --where posto1<=0.7
  where posto1>=0.7 and posto1<=0.9
  --where posto1>0.9 and posto1<=1
  --where posto1>1


  select *
  FROM [RFIND].[dbo].[MINorm]
  order by datum desc

  --delete from [RFIND].[dbo].[MINorm] where datum>='2019-01-01'

  -- tjedni prikaz realizacije
  select year(datum) Godina,datepart(week,datum) tjedan,sum(kolicina_tok) realizirano,sum(planiranokol_tok) planirano, case when sum(planiranokol_tok)>0 then round(cast ( sum(kolicina_tok)/sum(planiranokol_tok+0.0001)*100 as float ),2) else 0 end  posto_realizacije
  from rfind.dbo.dpr
  where year(datum)>=2018 and planiranokol_tok>=0 and kolicina_tok>=0
  group by year(datum) ,datepart(week,datum) 
  order by godina,tjedan

  select id_kupac,kupac,sum(planiranokol_tok)
  from rfind.dbo.dpr
  where datum>='2019-01-07' and datum<='2019-01-13'
  group by id_kupac,kupac


  select year(datum) Godina,datepart(week,datum) tjedan,sum(kolicinaok) realizirano,sum(norma) planirano, case when sum(NORMA)>0 then round(cast ( sum(kolicinaOK)/sum(NORMA+0.0001)*100 as float ),2) else 0 end  posto_realizacije
  from rfind.dbo.MINORM
  where year(datum)>=2018 and NORMA>1 and kolicinaok>=0
  AND DATUM<getdate()
  group by year(datum) ,datepart(week,datum) 
  order by godina,tjedan


 select *
 from dpr
 where datum>='2019-01-07' and datum<='2019-01-13'



 --  tjedna realizacija samo tokarenje bez dodatnih operacija
 select year(datum) Godina,datepart(week,datum) tjedan,sum(kolicinaok) relizirano, sum(norma) planirano,hala
 from feroapp.dbo.evidnormi('2018-01-01','2019-02-01',0)
 where hala=1 and ( linija not like 'GT%' and linija not in ('VC510','HURCO','EMAG'))
 group by year(datum) ,datepart(week,datum),hala
 order by godina,tjedan,hala

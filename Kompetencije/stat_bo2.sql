/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Ime]
      ,[Mjesec]
      ,[Brojdana]
      ,[Razlog]
      ,[Godina]
      ,[SN]
      ,[NN]
  FROM [RFIND].[dbo].[stat_bo2]
  -------------------------------------------------------------------------------------------------
  -- ne rade nedjeljom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and month(datum)=4
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  order by idradnika
  --------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- ne rade subotom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=6
  and year(dosao)=1900
  and month(datum)=4
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  order by idradnika
  ----------------------------------------------------------------------------------------------
  -- kasni,prerano_otisao,nedostaje
  use rfind
  select p.idradnika,r.prezime,r.ime,r.poduzece,sum(kasni) kasni,sum(preranootisao) po, sum(kasni+preranootisao) nedostaje_pl,sum((480-ukupno_minuta)) nedostaje_do8
    --select *
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where month(datum)=3
  and year(dosao)!=1900 and dosao!=otisao
  and r.FixnaIsplata=0
  and r.neradi=0
  and (480-Ukupno_minuta)>0
  --and idradnika=1301
  group by p.idradnika,r.prezime,r.ime,r.poduzece
  order by sum(480-ukupno_minuta)
  ------------------------------------------------
  


  select sum(po)
  from (

  select datum,case when kasni=0 and (480-ukupno_minuta)>0 then (480-ukupno_minuta) else 0  end po
  from PregledVremena
  where idradnika=684
  and month(datum)=3

  ) x1


  order by datum



  update pregledvremena set preranootisao=(480-ukupno_minuta) where month(datum)=2 and kasni=0 and (480-ukupno_minuta)>0




  select * into  pv_0405
  from pregledvremena



  ----------------------------------------------------------------------------------------------
  use rfind
  select *
  from pregledvremena
  where datum='2017-05-02'

  
  delete from pregledvremena where datum='2017-05-01'


  select r.id,r.prezime,r.ime,p.datum,datename(dw, datum) dan_u_tjednu,p.dosao,p.otisao,tdoci,totici,napomena,kasni,preranootisao,ukupno_minuta,hala,smjena,p.RadnoMJesto,p.rbroj
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where p.idradnika=100
  order by datum


  --update pregledvremena set tdoci=6,totici=14 where idradnika=100


  -- duplikati

  select count(*),idradnika,datum,rbroj
  from pregledvremena
  group by idradnika,datum,rbroj
  having count(*)>1
  order by datum

------------------------------------
-- kasni,prerano_otisao,nedostaje
  use rfind
  select x1.idradnika,x1.godina,x1.mjesec,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8
  from (
  select p.idradnika, year(p.datum) godina,month(p.datum) mjesec,r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao end  po,(480-ukupno_minuta) nedostaje_do8
    --select *
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  and r.FixnaIsplata=0
  and r.neradi=0
  and (480-Ukupno_minuta)>0
  and idradnika=541
  and p.datum='2017-04-03'
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece,x1.godina,x1.mjesec
  order by nedostaje_do8 desc
  ------------------------------------------------
  -- korekcija prerano otisao
  ------------------------------------------------
  select p.*,x1.po
  from pregledvremena p
  left join (select idradnika,datum,case when kasni=0 and (480 -ukupno_minuta)>0 and preranootisao=0 then ( 480 -ukupno_minuta) else PreranoOtisao end po,kasni,ukupno_minuta,preranootisao
  from pregledvremena
  ) x1 on p.idradnika=x1.idradnika and p.datum=x1.datum
  where month(p.datum)=4
  and year(p.dosao)!=1900
  and p.dosao!=p.otisao
  and p.idradnika=541

  ---------------------------------------
  update pregledvremena set preranootisao=  where idradnika=423423423


  select * into pv_1105
  from PregledVremena
  

  delete from pregledvremena where datum='2017-02-27' --and idradnika=46


  - nadji duplicate


  select count(*) broj ,x2.datum
  from (
  
  select datum,idradnika,hala,smjena, count(*) broj1
  from pregledvremena
  group by datum,idradnika,hala,smjena
  having count(*) > 1
  order by datum

  ) x2
  
  group by datum
  having count(*) > 1
  order by datum


  
  select *
  from pregledvremena
  where datum='2017-02-27'
  order by idradnika

-----------------------------------------
-- update pregledvremena.preranootisao
-----------------------------------------
   UPDATE
    pregledvremena
SET
   preranootisao = 0
   

   select j.*

FROM
   (

select p.*,x1.po
  from pregledvremena p
  left join (select idradnika,datum,case when kasni=0 and (480 -ukupno_minuta)>=0 and ( preranootisao=0 or preranootisao=480) then ( 480 -ukupno_minuta) else PreranoOtisao end po,kasni,ukupno_minuta,preranootisao
  from pregledvremena
  ) x1 on p.idradnika=x1.idradnika and p.datum=x1.datum
  where month(p.datum)=4
  and year(p.dosao)!=1900
  and p.dosao=p.otisao
  --order by idradnika,datum
    
   ) j
INNER JOIn pregledvremena k
ON 
    j.idradnika = k.idradnika and k.datum=j.datum and j.smjena=k.smjena

	where j.idradnika = k.idradnika and k.datum=j.datum and k.smjena=j.smjena
	and ( k.dosao=j.otisao )  

---------------------------------------------------------------
select *
from PregledVremena
where  montH(datum)=3
--and PreranoOtisao<>0 
and (year(dosao)=1900
--or dosao=otisao
or radnomjesto in ('BO','B.O.','GO','G.O.')
)


select *
from PregledVremena
where  montH(datum)=4
and radnomjesto in ('BO','B.O.','GO','G.O.')
AND preranootisao<>0



update PregledVremena set PreranoOtisao=0,kasni=0 where montH(datum)=1
and PreranoOtisao<>0
and (year(dosao)=1900
--or dosao=otisao
or radnomjesto in ('BO','B.O.','GO','G.O.')
)



-----------------------------------------
-- kasni,prerano_otisao,nedostaje
-----------------------------------------
drop table tmp_kasne04_2

  use rfind
  select x1.idradnika,x1.godina,x1.mjesec,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 into tmp_kasne04_2
  from (
  
  select p.idradnika,datum, year(p.datum) godina,month(p.datum) mjesec,r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
    --select *
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  and r.FixnaIsplata=0
  and r.neradi=0
 -- and (480-Ukupno_minuta)>0
  --and idradnika=541
  and year(datum)=2017  
  and month(datum)=4
  --and p.datum='2017-04-03'
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece,x1.godina,x1.mjesec
  order by nedostaje_do8 desc
  ----------------------------------------------
  select *
  from tmp_kasne2017
  where idradnika=838


  -----------------
  select *
  from pregledvremena
  where datum='2017-04-03' and idradnika=541

  select *
  from pregledvremena  
  where month(datum)=3
  and 


------------------------


----------------------------------------
-- update kompetecnije1005, kasne, falid 8, po
-----------------------------------------
--update Kompetencije2017 set [PreranoOtisao]= 0,	[Kasni]= 0,	[NedostajeDo8sati]=0

update Kompetencije2017 set [PreranoOtisao]= 0,	[Kasni]= 0,	[NedostajeDo8sati]=0

   UPDATE
--    kompetencije2017
	kompetencije2017
SET
	[PreranoOtisao]= j.preranootisao,
	[Kasni]= j.kasni,
	[NedostajeDo8sati]=j.nedostaje_do8   

FROM
    tmp_kasne2017 j
    --tmp_kasne2017 j
--INNER JOIn kompetencije2017 k
INNER JOIn kompetencije2017 k  ON  j.idradnika = k.id 
	
---------------------------------------------------------------
-- update kompetecnije1005, neopravdani
-----------------------------------------
--update Kompetencije2017 set [Neopravdano_puta]=0,[NeopravdaniDani]=0,[NedolasciNedjeljom]=0,[NedolasciSubotom]=0

update Kompetencije set [Neopravdano_puta3]=0,[NeopravdaniDani3]=0,[NedolasciSubotom3]=0
   UPDATE
    --kompetencije2017
    kompetencije

SET	
   [NeopravdaniDani3]    = j.brojdana,
   [Neopravdano_puta3]   = j.puta,
 --  [NedolasciNedjeljom] = j.nn,
   [NedolasciSubotom3]   = j.sn

FROM
    (
	SELECT [mt]
      ,[mjestotroska]
      ,[id]
      ,[ime]
      --,[mjesec]
      ,[godina]
      ,[puta]
      ,[brojdana]
      ,[sn]
      ,[nn]
      ,[firma]
      ,[razlog]
  FROM [RFIND].[dbo].[odsustva2017]
  where godina=2017 
  --and mjesec=4
  and razlog='N'
  ) j
   
--INNER JOIn kompetencije2017 k
INNER JOIn kompetencije k
ON 
    j.id = k.id 


---------------------------------------------------------------
-- update kompetencije1005, bolovanja
-----------------------------------------
   --UPDATE  kompetencije2017 set [Bolovanje_broj]=0,[Bolovanja_dana]=0
   UPDATE  kompetencije set [Bolovanje_broj3]=0,[Bolovanja_dana3]=0



--   Update kompetencije2017
   Update kompetencije
SET	
   [Bolovanje_broj3] = j.puta,
	[Bolovanja_dana3]=j.brojdana
FROM
    (
	SELECT [mt]
      ,[mjestotroska]
      ,[id]
      ,[ime]
       --,[mjesec]
      ,[godina]
      ,[puta]
      ,[brojdana]
      ,[sn]
      ,[nn]
      ,[firma]
      ,[razlog]
  FROM [RFIND].[dbo].[odsustva2017]
  where godina=2017 
  --and mjesec=4
  and razlog='B'
  ) j
   
--INNER JOIn kompetencije2017 k
INNER JOIn kompetencije k
ON 
    j.id = k.id 

	
---------------------------------------------------------------
-- update kompetecnije1105, nn
-----------------------------------------
--update Kompetencije2017 set [NedolasciNedjeljom]=0
update Kompetencije1105 set [NedolasciNedjeljom]=0

   UPDATE
   --kompetencije2017
    kompetencije1105

SET	
   [NedolasciNedjeljom] =j.broj
   
FROM
    (

 select count(*) broj,idradnika
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and year(datum)=2017
  and month(datum)=4
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  
  ) j
   
--INNER JOIn kompetencije2017 k
INNER JOIn kompetencije1105 k
ON 
    j.idradnika = k.id 

----------------------------------
-- stimulacija iz plansatirada
-----------------------------------
--UPDATE  kompetencije2017 set stimulacija=0
UPDATE  kompetencije1105 set stimulacija=0


--Update kompetencije2017
Update kompetencije1105

SET	
   [stimulacija] = j.stimulacija1
  	
FROM
    (
	SELECT 
	radnikid,
	sum(stimulacija1) stimulacija1
	from plansatirada
	where godina=2017
	and mjesec=4
	group by radnikid
  ) j
   
--INNER JOIn kompetencije2017 k
INNER JOIn kompetencije1105 k
ON 
    j.radnikid = k.id 
-------------------------------


SELECT *
FROM plansatirada
where radnikid=70
and mjesec=4
and godina=2017

update pregledvremena set preranootisao=0 where idradnika=1007 and datum='2017-04-29'


select *
from  kompetencije1105
where id=1007

select *
from  kompetencije1105
where id=1007



select sum(preranootisao)

select *
from PregledVremena
where idradnika=838
and year(datum)=2017
and preranootisao<>0


update pregledvremena set preranootisao=0 where dosao=otisao




select *
from tmp_kasne2017
where idradnika=1007

select *
from kompetencije2017
where id=1007




update kompetencije2017 set PreranoOtisao=0 where id=1007


select *
from Kompetencije1105
union all
select *
from Kompetencije2017
order by id


select *
from plansatirada
where radnikid=1007
and godina=2017


SELECT DATEDIFF(MONTH, '2009-04-30', '2009-05-15')
SELECT DATEDIFF(DAY, '2009-04-16', '2009-05-15')/30
    , DATEDIFF(DAY, '2016-12-17', '2017-05-15')/30
    , DATEDIFF(DAY, '2009-04-16', '2009-06-16')/30



-- ne rade nedjeljom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and year(datum)=2017
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'

  order by idradnika
  --------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- ne rade subotom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=6
  and year(dosao)=1900
  and year(datum)=2017
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  order by idradnika
  ----------------------------------------------------------------------------------------------

  select *
  from stat_bo2
  where id=26
  
  use fxsap
  select *
  from plansatirada
  where radnikid=42


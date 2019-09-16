declare @dat1 date='2019-01-12'
use feroapp	 
--select x11.* from (
--			 select x11.*,id from (
--			 select e.id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika,'1' vrstarada
--			 FROM EvidNormiRada(@dat1, @dat1) e 
--			 group by e.id_radnika,e.firma,e.datum,e.hala,e.smjena
--			 ) x11
--			 inner join rfind.dbo.radnici_ r on r.id_radnika=x11.id_radnika 
--			 ) x11	

  
   --select e.id_radnika,radnik,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika,'1' vrstarada
			-- FROM EvidNormiRada(@dat1, @dat1) e 
			-- group by e.id_radnika,radnik,e.firma,e.datum,e.hala,e.smjena
			-- order by radnik

			 select r.prezime,r.ime,x2.*
			 from (
			 select x1.*,p.dosao,p.otisao,p.Ukupno_minuta,p.RadnoMjesto, 
			 case when dosao is null  then 'Nije zaplaniran u toj smjeni_'+cast(x1.smjena as varchar(1))
			      when x1.satiradaradnika>0 and p.ukupno_minuta=0 then 'Šteler upisao sate a nije se registrirao'
				  when year(dosao)=1900 and x1.satiradaradnika>0 then 'Radio, nije se prijavio' 
				  when year(dosao)=1900 and x1.satiradaradnika>0 then 'Radio, nije se prijavio' end napomena,				  
				  case when x1.satiradaradnika>0 and p.ukupno_minuta=0 then '!0'					   
					   when DATEPART(WEEKDAY,@dat1) !=6 and  x1.smjena=3 and x1.satiradaradnika>=8 then '1n' 
				       when DATEPART(WEEKDAY,@dat1) not in (6) and x1.smjena=2 and x1.satiradaradnika>=8 then '1p' 
					   when DATEPART(WEEKDAY,@dat1) not in (6) and x1.smjena=1 and x1.satiradaradnika>=8 then '1j' 
					   when DATEPART(WEEKDAY,@dat1) not in (6) and x1.smjena=3 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'n') 
					   when DATEPART(WEEKDAY,@dat1) not in (6) and x1.smjena=2 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'p') 
					   when DATEPART(WEEKDAY,@dat1) not in (6) and x1.smjena=1 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((7.0-x1.satiradaradnika) as varchar(12)) + 'j') 					   
				       when DATEPART(WEEKDAY,@dat1) =6 and  x1.smjena=2 and x1.satiradaradnika>=8 then '3p' 
					   when DATEPART(WEEKDAY,@dat1) =6 and  x1.smjena=1 and x1.satiradaradnika>=8 then '3j' 					   
					   when DATEPART(WEEKDAY,@dat1) =6 and  x1.smjena=2 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((5.0-x1.satiradaradnika) as varchar(12)) + 'p') 
					   when DATEPART(WEEKDAY,@dat1) =6 and  x1.smjena=1 and x1.satiradaradnika<8 and x1.satiradaradnika>0 then ('-'+cast((5.0-x1.satiradaradnika) as varchar(12)) + 'j') 
					   when x1.satiradaradnika=0 and p.ukupno_minuta=0 then '0e' 
					   when x1.satiradaradnika=0 and p.ukupno_minuta>0 then '0X' 					   
					   end oznaka from (					   
			 
			 select x11.* from (
			 select x11.*,id from (
			 select e.id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.satiradaradnika) satiradaradnika,'1' vrstarada
			 FROM EvidNormiRada(@dat1, @dat1) e 
			 group by e.id_radnika,e.firma,e.datum,e.hala,e.smjena
			 ) x11
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x11.id_radnika 
			 ) x11			
			 
			 union all
			 
			 select x12.* from (
			 select x12.*,id from (
			 select e.id_radnika2 id_radnika,e.firma,e.datum,e.hala,e.smjena,sum(e.SatiRadaPomocnogRadnika) satiradaradnika,'2' vrstarada
			 FROM EvidNormiRada(@dat1, @dat1) e 
			 where pomocniradnik is not null and  pomocniradnik!=''
			 group by e.id_radnika2,e.firma,e.datum,e.hala,e.smjena
			 ) x12
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x12.id_radnika
			 ) x12	
			 	
			 ) x1
			 left join rfind.dbo.pregledvremena p on p.IDRadnika=x1.id and p.datum=x1.datum and x1.smjena=p.smjena			
			 ) x2
			 inner join rfind.dbo.radnici_ r on r.id_radnika=x2.id_radnika			 
			 --where x2.oznaka like '!%'
			 order by prezime,x2.id_radnika,x2.smjena

-------------------
----------- kontrola izuzetaka
select firma,radnikid,ime,mt,dan19
from fxsap.dbo.plansatirada
where mjesec=12 and godina=2018
and dan19 not like '1%' and dan19 not in ( '0j','7g','8b','5g','0e')
-------------------------------------------------------------------------
select firma,radnikid,ime,mt,dan04
from rfind.dbo.plansatirada2 p
where mjesec=11 and godina=2018
and dan30 not like '1%' and dan30 not in ( '0j','7g','8b')
order by ime
-----------------------------------
select *
from rfind.dbo.plansatirada
where mjesec=11 and godina=2018
--and radnikid=892
order by ime
--------------------------------------------------------------------------
-- lista za kontrolu
select p.firma,p.radnikid,p.ime,p.sifrarm,p.mt,dan10
from fxsap.dbo.plansatirada p
left join feroapp.dbo.radnici r1 on r1.ID_Fink=p.RadnikID and r1.ID_Firme=p.Firma
left join rfind.dbo.radnici_ r2 on r2.id_radnika=r1.id_radnika
inner join fxsap.dbo.psruserlist r on  p.RadnikID=r.RadnikID and p.firma=r.firma
where mjesec=12 and godina=2018 and ( dan10 is null or dan10 ='0e') and p.firma=r.firma
and r.username='sbiscan'
and p.mt not in ( 702,710) and r2.neradi=0
order by mt,ime
------------------------------------------------------------------------
select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.dan18,v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena --firma,radnikid,ime,mt,dan15,dan16
from  fxsap.dbo.plansatirada p
inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma
left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='2018-12-18'
where mjesec=12 and godina=2018 and ( year(v.dosao)!=1900 or v.ukupno_minuta>60 ) --and radnikid= 1269 and firma=3 and v.ukupno_minuta>
--and radnikid=2137
and r1.username='sbiscan'
and p.mt not in ( 702,710,713,704)
and ( p.dan18 is null or p.dan18 ='0e')
order by ime
--------------------------------
--  radio više od 8 sati
--------------------------------
select neradi,firma,mt,radnikid,ime,dan18,dosao,otisao,ukupno_minuta,sati,smjena,RadnoMjesto --firma,radnikid,ime,mt,dan15,dan16
from (
select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.dan18,v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto --firma,radnikid,ime,mt,dan15,dan16
from  fxsap.dbo.plansatirada p
inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma
left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='2018-12-18'
where mjesec=12 and godina=2018 and v.ukupno_minuta>60 --and radnikid= 1269 and firma=3 and v.ukupno_minuta>
--and radnikid=2137
and r1.username='sbiscan'
and p.mt not in ( 702,710,713,704)
--and ( p.dan28 is null or p.dan28 ='0e')
) x1
where sati>8
order by ime
--------------------------------
--------------------------------
--  krivo se registrirao, šteler ga nije zapisao
--------------------------------
select neradi,firma,mt,radnikid,ime,dan18,dosao,otisao,ukupno_minuta,sati,smjena,RadnoMjesto --firma,radnikid,ime,mt,dan15,dan16
from (
select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.dan18,v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto --firma,radnikid,ime,mt,dan15,dan16
from  fxsap.dbo.plansatirada p
inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma
left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='2018-12-18'
where mjesec=12 and godina=2018 and v.dosao=v.otisao and year(v.dosao)!=1900    -- nije se 2 prijavio
--and radnikid=2137
and r1.username='sbiscan'
and p.mt not in ( 702,710,713,704)
and ( p.dan18 is null or p.dan18 ='0e')   -- ostalo mu 0e
) x1
--where ( p.dan28 is null or p.dan28 ='0e')
order by ime
--------------------------------


select r.prezime,r.ime,r.DatumZaposlenja,p.*
from rfind.dbo.pregledvremena p
left join rfind.dbo.radnici_ r on r.id=p.idradnika
where idradnika>900000 and month(datum)=9 and year(datum)=2018
and r.DatumZaposlenja>'2018-09-01'
order by prezime

select *
FROM EvidNormiRada('2018-11-08', '2018-11-08') 
where radnik like 'ere%'


select *
FROM EvidNormi('2018-11-13', '2018-11-13',0) 
where radnik like 'ant%'
union all
select *
FROM EvidNormi('2018-11-08', '2018-11-08',0) 
where radnik2 like 'ere%'

update  rfind.dbo.plansatirada2 set dan24=null where dan24 not in ('7g','8b') and mt not in ( 7001,7161) and mjesec=11 and godina=2018 
--update  fxsap.dbo.plansatirada set dan16='0j' where dan15 not in ('7g','8b') and mt not in ( 7001,7161) and mjesec=11 and godina=2018 and radnikid=917


select *
from rfind.dbo.plansatirada2
where mjesec=11 and godina=2018
and radnikid=142


select *
from fxsap.dbo.plansatirada
where mjesec=12 and godina=2018
and radnikid=129
order by radnikid
			 
select radnikid,dan09
from rfind.dbo.plansatirada2
where mjesec=10 and godina=2018
and radnikid=119
order by radnikid

-- šteleri
  use rfind
  select r.prezime,r.ime,p.*
  from radnici_ r
  left join MjestoTroska m on m.id=r.mt
  left join pregledvremena p on p.idradnika=r.id
  where  r.Neradi=0 and m.id=716 and p.datum='2018-10-16'
  order by prezime
-----------------------------------------

--- koji nisu unešeni u prvom koraku a imaju >450 minuta
select r.neradi,p.firma,p.mt,p.radnikid,p.ime,dan15,dan16,dan17,dan19,v.dosao,v.otisao,v.ukupno_minuta,v.smjena --firma,radnikid,ime,mt,dan15,dan16
from  fxsap.dbo.plansatirada p
left join radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='2018-10-19'
where mjesec=10 and godina=2018 and v.ukupno_minuta>450 --and radnikid= 1269 and firma=3 and v.ukupno_minuta>
--and radnikid=2137
and a.mt in ( 700,716) and ( dan19 is null or dan19 ='0e')
order by ime


-- ostali koji nisu unešeni 0e
select r.neradi,p.firma,p.radnikid,p.ime,dan15,dan16,dan17,a.neradi --firma,radnikid,ime,mt,dan15,dan16
from  rfind.dbo.plansatirada2 p
left join radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
where mjesec=10 and godina=2018 and a.neradi=0
and a.mt in ( 700,716) and dan17 is null
order by ime

------  rfind log
use rfind
select dt Vrijeme,LastName Prezime,u.FirstName Ime,r.name Lokacija,e.Device_ID Uredaj,e.EventType,t.CodeName,b.extid FxId,e.[User],e.No2 Serial_number,e.no RFID_Hex 
from event e 
left join badge b on e.No= b.BadgeNo 
left join [dbo].[User] u on u.extid=b.extid 
left join eventtype t on e.EventType=t.Code 
left join reader r on r.id=e.device_id 
WHERE E.[USER] IS NOT NULL and e.eventtype!='SP23'  and ( e.dt>='2018-10-01' and e.dt<='2018-10-19 23:59:59.00') AND  ( lastname+' '+firstname) like '%gašpar%'  and  e.device_id!='544666590' 
order by dt desc


--use rfind
--update pregledvremena set dosao='2019-5-21 17:21:00',otisao='2019-5-22 04:59:00' where idradnika=138 and datum='2019-5-21'
--update pregledvremena set ukupno_minuta=DATEDIFF(mi,dosao,otisao),PreranoOtisao=0 where idradnika=138 and datum='2018-5-21'


select *
from pregledvremena
where idradnika=226 and datum='2018-10-21'
--delete from pregledvremena where idradnika=226 and datum='2018-10-21' and ukupno_minuta=711

--delete from pregledvremena where datum>'2018-11-01' 


select *
from feroapp.dbo.EvidNormiRada('2018-12-13','2018-12-13')
order by PomocniRadnik

select *
from pregledvremena
where idradnika=984
order by datum desc


select *
from pregledvremena
order by datum desc

-- provjera 0e;
select p.firma,p.radnikid,p.ime,p.sifrarm,p.mt,dan04
from fxsap.dbo.plansatirada p
inner join fxsap.dbo.psruserlist r on  p.RadnikID=r.RadnikID and p.firma=r.firma
where mjesec=10 and godina=2018 and ( dan16 like '%0e:%'  or dan17 like '%0e:%'  or dan18 like '%0e:%'  or dan19 like '%0e:%'  or dan20 like '%0e:%'  or dan21 like '%0e:%') and p.firma=r.firma
and r.username='sbiscan'
and mt not in ( 702,710)
order by mt,ime
-- 

select firma,radnikid,ime,sifrarm,vrstarm,mt,dan20
from fxsap.dbo.plansatirada
where mjesec=10 and godina=2018

---------------------
-- update radnici_  id_radnika
---------------------
select *
from feroapp.dbo.radnici
order by id_radnika desc
--order by id_fink desc

select *
from feroapp.dbo.radnici
order by id_radnika desc

update rfind.dbo.radnici_ set id_radnika=2193,fixnaisplata=0,sifrarm='proizvodnja' where id=148 and poduzece='Tokabu'
update feroapp.dbo.radnici set SifraRM='proizvodnja',radnastroju=1 where id_radnika=2193
update rfind.dbo.radnici_ set neradi=0,lokacija=500,fixnaisplata=0 where id_radnika=2192

select *
from rfind.dbo.radnici_
order by datumzaposlenja desc

select *
from rfind.dbo.radnici_
order by prezime

------------------------
select *
from rfind.dbo.pregledvremena
where idradnika=923
order by datum desc
---
use feroapp
select * into rfind.dbo.plansatirada_2710_2022
from fxsap.dbo.plansatirada


select distinct dan06
from fxsap.dbo.plansatirada
where mjesec=10 and godina=2018 and dan06!='3jj:3p'
order by ime

-----------------
use rfind
select * into rfind.dbo.plansatirada2
from fxsap.dbo.plansatirada
update rfind.dbo.plansatirada2 set dan03='' where mjesec=1 and godina=2019



-----------------

--update fxsap.dbo.plansatirada set dan06='3j:-1p' where mjesec=10 and godina=2018 and dan06='1j:-3p'

-- provjera oznake neradi
select r.*, a.neradi neradi_
from feroapp.dbo.radnici r
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
where r.neradi!=a.neradi
order by r.id_radnika

-------------------------------------------------------------------
-- update feroapp.dbo.radnici from rfind.dbo.radnici_
-------------------------------------------------------------------
--update feroapp.dbo.radnici set neradi = j.neradi_
from (
select r.*, a.neradi neradi_
from feroapp.dbo.radnici r
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika
where r.neradi!=a.neradi
)j
inner join feroapp.dbo.radnici k on k.id_radnika=j.id_radnika
where 1=2
-------------------------------------------------------------------
--select * into rfind.dbo.backup_radnici3110
--from feroapp.dbo.radnici


select *
from rfind.dbo.pregledvremena
where idradnika=1207
order by datum desc


select *
from event
order by dt desc




select *
from radnici_
where mt in (700,702,716) and lokacija=521
order by prezime



select *
from rfind.dbo.radnici_
where id>8000 and id<9000
order by id_radnika desc


where datumzaposlenja>'2018-10-30'
order by id desc

--update rfind.dbo.radnici_ set fixnaisplata=1 where id>8000 and id<8900 and rv=2

select *
from feroapp.dbo.proizvodi


--select * into rfind.dbo.plansatirada
--from fxsap.dbo.plansatirada

select *
from rfind.dbo.plansatirada2
where mjesec=12 and godina=2018
order by ime


-----------------------
-- sati.xlsm
-----------------------
declare @dat11 date='2018-12-17'
         SELECT (CASE WHEN LEN(PomocniRadnik) > 6 THEN RIGHT(PomocniRadnik,LEN(PomocniRadnik)-6) END) AS Radnik,
         Datum, Smjena,
         SUM(SatiRadaPomocnogRadnika) AS SatiRadaRadnika, Vrsta, Napomena1, Napomena2
         FROM feroapp.dbo.EvidNormiRada(@dat11, @dat11)
         INNER JOIN feroapp.dbo.Radnici ON EvidNormiRada.ID_Radnika2=Radnici.ID_Radnika
         WHERE  PomocniRadnik <> '' AND Vrsta NOT IN ('Šteler')
         AND Radnici.Kontrola = 0 AND PomocniRadnik <> 'Pomo? '
         GROUP BY EvidNormiRada.PomocniRadnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaPomocnogRadnika 
         UNION ALL 
         SELECT Radnik, Datum, Smjena, SUM(SatiRadaRadnika), Vrsta, Napomena1, Napomena2 FROM feroapp.dbo.EvidNormiRada(@dat11, @dat11) INNER JOIN feroapp.dbo.Radnici ON
         EvidNormiRada.ID_Radnika=Radnici.ID_Radnika WHERE Radnik <> '' AND Vrsta NOT IN ('Šteler') AND Radnici.Kontrola = 0
         GROUP BY EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika
         UNION ALL
         SELECT Radnik, Datum, Smjena, SUM(SatiRadaRadnika), Vrsta, Napomena1, Napomena2
         FROM feroapp.dbo.EvidNormiRada(@dat11, @dat11) WHERE Vrsta = 'Šteler'
         GROUP BY EvidNormiRada.Radnik, EvidNormiRada.ID_Radnika, EvidNormiRada.Datum, EvidNormiRada.Smjena, EvidNormiRada.Vrsta, EvidNormiRada.Napomena1, EvidNormiRada.Napomena2, EvidNormiRada.SatiRadaRadnika
         ORDER BY Radnik, Datum, Smjena
----------------------------
------  rfind log

-- imaju upisano 0e,null ili prazno a registrirali su se taj dan
declare @dat11 date='2018-12-18'
use rfind
select *
from fxsap.dbo.plansatirada
where mjesec=12 and godina=2018 and (dan18 ='0e' or dan18 is null or dan18='') and SifraRM not like 'Režija'
and radnikid in (
select extid
from (
select b.extid, count(*) broj
from event e 
left join badge b on e.No= b.BadgeNo 
left join [dbo].[User] u on u.extid=b.extid 
left join eventtype t on e.EventType=t.Code 
left join reader r on r.id=e.device_id 
WHERE E.[USER] IS NOT NULL and e.eventtype!='SP23'  and year(e.dt)=year(@dat11) and month(e.dt)=month(@dat11) and day(e.dt)=day(@dat11)
group by b.extid
)x1 where broj>1
)
--order by dt desc
-----------------------------------------------


select *
from feroapp.dbo.radnici
where id_fink not in 
(7
select id
from rfind.dbo.radnici_
)
order by id_radnika desc


select *
from rfind.dbo.radnici_
order by datumzaposlenja desc

select *
from rfind.dbo.radnici_
order by datumzaposlenja desc
-----------------------------------------------------------------------------------------------
select *
from feroapp.dbo.radnici
order by id_radnika desc

update rfind.dbo.radnici_ set id_radnika=2245,fixnaisplata=0,sifrarm='proizvodnja' where id=1675 --and poduzece='Tokabu'

update feroapp.dbo.radnici set SifraRM='Režija',radnastroju=0 where id_radnika=2232
update rfind.dbo.radnici_ set neradi=0,lokacija=500,fixnaisplata=0 where id_radnika in ( 2192,2191,2193)
--update rfind.dbo.radnici_ set custid=131,RFID2='131-6308381' WHERE id=146 and prezime='NUHI'

update rfind.dbo.radnici_ set prezime='ISLAMI' WHERE id IN ( 1579)
update rfind.dbo.KOMPETENCIJE set prezimeIME='ISLAMI AFRIM (1579)' WHERE id IN ( 1579)

update rfind.dbo.radnici_ set fixnaisplata=1 where id=1648 --and poduzece='Tokabu'

select *
from rfind.dbo.radnici_
order by datumzaposlenja desc

select *
from rfind.dbo.radnici_
order by prezime


SELECT *
FROM KOMPETENCIJE

select *
from radnici_
where id=8162

--update FEROAPP.DBO.radnici set ime='DOMAGOJ' where id=8162




--delete from radnici_ where id=0
select r1.id,r1.id_radnika,r1.neradi,r1.ime,r1.prezime,r2.id_radnika
from rfind.dbo.radnici_ r1
left join feroapp.dbo.radnici r2 on r1.id_radnika=r2.ID_Radnika
where r2.id_radnika is null and r1.neradi=0
order by r1.id_radnika




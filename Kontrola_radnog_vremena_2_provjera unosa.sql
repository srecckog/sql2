use fxsap
select *
from fxsap.dbo.plansatirada
where mjesec=12 and godina=2018
and (
   charindex('0e',dan01)>0
 or  charindex('0e',dan02)>0
 or  charindex('0e',dan03)>0
 or  charindex('0e',dan04)>0
 or  charindex('0e',dan05)>0
 or  charindex('0e',dan06)>0
 or  charindex('0e',dan07)>0
 or  charindex('0e',dan08)>0
 or  charindex('0e',dan09)>0
 or  charindex('0e',dan10)>0
 or  charindex('0e',dan11)>0
 or  charindex('0e',dan12)>0
 or  charindex('0e',dan13)>0
 or  charindex('0e',dan14)>0
 or  charindex('0e',dan15)>0
 or  charindex('0e',dan16)>0
 or  charindex('0e',dan17)>0
 or  charindex('0e',dan18)>0
 or  charindex('0e',dan19)>0
 or  charindex('0e',dan20)>0
 or  charindex('0e',dan21)>0
 or  charindex('0e',dan22)>0
 or  charindex('0e',dan23)>0
 or  charindex('0e',dan24)>0
 or  charindex('0e',dan25)>0
 or  charindex('0e',dan26)>0
 or  charindex('0e',dan27)>0
 or  charindex('0e',dan28)>0
 or  charindex('0e',dan29)>0
 or  charindex('0e',dan30)>0
 or  charindex('0e',dan31)>0
 )
 --and dandolaska>'2018-10-01'
 order by ime


use fxsap
select *
--from fxsap.dbo.plansatirada
from fxsap.dbo.plansatirada
where mjesec=12 and godina=2018
and (
 dan01 is null
 or  dan02 is null
 or  dan03 is null
 or  dan04 is null
 or  dan05 is null
 or  dan06 is null
 or  dan07 is null
 or  dan08 is null
 or  dan09 is null
 or  dan10 is null
 or  dan11 is null
 or  dan12 is null
 or  dan13 is null
 or  dan14 is null
 or  dan15 is null
 or  dan16 is null
 or  dan17 is null
 or  dan18 is null
 or  dan19 is null
 or  dan20 is null
 or  dan21 is null
 or  dan22 is null
 or  dan23 is null
 or  dan24 is null
 or  dan25 is null
 or  dan26 is null
 or  dan27 is null
 or  dan28 is null
 or  dan29 is null
 or  dan30 is null
 --or  dan31 is null 
 )
 --and dandolaska>'2018-10-01'
 and mt not in ( 702) 
 order by ime



 use fxsap
select *
from plansatirada
where mjesec=12 and godina=2018
and (
   charindex('X',dan01)>0
 or  charindex('X',dan02)>0
 or  charindex('X',dan03)>0
 or  charindex('X',dan04)>0
 or  charindex('X',dan05)>0
 or  charindex('X',dan06)>0
 or  charindex('X',dan07)>0
 or  charindex('X',dan08)>0
 or  charindex('X',dan09)>0
 or  charindex('X',dan10)>0
 or  charindex('X',dan11)>0
 or  charindex('X',dan12)>0
 or  charindex('X',dan13)>0
 or  charindex('X',dan14)>0
 or  charindex('X',dan15)>0
 or  charindex('X',dan16)>0
 or  charindex('X',dan17)>0
 or  charindex('X',dan18)>0
 or  charindex('X',dan19)>0
 or  charindex('X',dan20)>0
 or  charindex('X',dan21)>0
 or  charindex('X',dan22)>0
 or  charindex('X',dan23)>0
 or  charindex('X',dan24)>0
 or  charindex('X',dan25)>0
 or  charindex('X',dan26)>0
 or  charindex('X',dan27)>0
 or  charindex('X',dan28)>0
 or  charindex('X',dan29)>0
 or  charindex('X',dan30)>0
 or  charindex('X',dan31)>0
 )


 select *
 --from fxsap.dbo.plansatirada
 from rfind.dbo.plansatirada2
 where mjesec=11 and godina=2018
 and RadnikID=172


 -- pregled dolazaka za studente
 --select year(dt) g,month(dt)m ,day(dt) d,DATEPART(HOUR, dt) hour,DATEPART(n, dt) min,u.extid,u.oid,max(dt) izlaz,min(dt) izlaz
 select concat(g,'-',m,'-',d) datum,x1.lastname,x1.firstname, extid,oid,ulaz,izlaz, DATEDIFF(n,ulaz,izlaz)/60 sati from (
 select year(dt) g,month(dt)m ,day(dt) d,u.extid,u.oid,min(dt) ulaz,max(dt) izlaz,u.firstname,u.LastName
 from rfind.dbo.event e
 left join rfind.dbo.[user] u on u.[oid]=e.[user]
 where e.dt>='2018-11-01 0:0' and u.oid is not null
 and u.extid=900044 and e.eventtype='SP39'
 group by year(dt) ,month(dt)  ,day(dt) ,u.extid,u.oid, u.lastname,u.firstname ) x1
 order by g,m,d


 select *
 from rfind.dbo.event
 order by dt desc


 select *
 from rfind.dbo.[user]
 order by oid

 --update fxsap.dbo.plansatirada set dan07='0j' where radnikid=122 and firma=1 and mjesec=11 and godina=2018
 select *
 from fxsap.dbo.plansatirada
 where mjesec=11 and godina=2018
 and radnikid=122



 --update rfind.dbo.[user] set lastname='DRAŽENOVIÆ',FIRSTNAME='STJEPAN' WHERE OID=920

 SELECT id,  RIGHT(rfid2,LEN(rfid2)-CHARINDEX('-',rfid2)) rfid_drugi_dio,rfid2,rfid,rfidhex
 FROM RFIND.DBO.RADNICI_
 order by id

 WHERE ID=132

 
 select *
 from rfind.dbo.reader
 where 


 select *
 from rfind.dbo.badge
 order by badgeno


 select *
 from event
 where [user]=919
 order by dt desc


 select *
 from [user]
 order by lastname

 where extid=8122


 select *
 from badge
 where extid=122
 order by badgeno


 where extid in (125) and active=1

 --update badge set badgeno='000259D3' where [user]=2834

 select *
 from badge
 where customcardid='12'


 select *
 from event
 where [user]=919
 order by dt desc


 select *
 from event 
 order by dt desc

 where no like '004613%'
 order by dt desc

select year(dt) g,month(dt)m ,day(dt) d,u.extid,u.oid,min(dt) ulaz,max(dt) izlaz,u.firstname,u.LastName,e.EventType
 from rfind.dbo.event e
 left join rfind.dbo.[user] u on u.[oid]=e.[user]
 where e.dt>='2018-10-01 0:0' and u.oid is not null
 and u.extid>=900049
 group by year(dt) ,month(dt)  ,day(dt) ,u.extid,u.oid, u.lastname,u.firstname,e.EventType



 select *
 from rfind.dbo.radnici_
 order by id desc


 select r.prezime,r.ime,r.id,p.datum,p.dosao,p.otisao,p.ukupno_minuta,p.ukupno_minuta/60 sati
 from rfind.dbo.pregledvremena p
 left join rfind.dbo.radnici_ r on r.id=p.idradnika
 where month(datum)=10 and day(datum) in ( 6,13,20,27) and year(datum)=2018
 and idradnika >=900049 and idradnika<=900060
 order by r.prezime,p.datum

 ------------------------
 -- Makedonci, radne subote u 10.2018 
 ----------------------------
 select d dan,lastname,firstname,ulaz,izlaz,citac,DATEDIFF(n,ulaz,izlaz) minuta,DATEDIFF(n,ulaz,izlaz)/60 sati
 from (
select year(dt) g,month(dt)m ,day(dt) d,u.extid,u.oid,min(dt) ulaz,max(dt) izlaz,u.firstname,u.LastName,e.EventType,e.Device_ID citac
 from rfind.dbo.event e
 left join rfind.dbo.[user] u on u.[oid]=e.[user]
 --where month(e.dt)=11 and year(e.dt)=2018 and day(e.dt) in ( 3,10,17,24) and u.oid is not null
 where month(e.dt)=11 and year(e.dt)=2018  and u.oid is not null
 and u.extid>=900049
 and e.device_id in ('544666577','544666590')   -- pogon 1 i 3
 group by year(dt) ,month(dt)  ,day(dt) ,u.extid,u.oid, u.lastname,u.firstname,e.EventType,e.Device_ID) x1
 order by lastname,ulaz


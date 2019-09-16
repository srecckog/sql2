
select idradnika,datum,dosao,otisao,hala,smjena,tdoci,ukupno_minuta,preranootisao,datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 06:00:00.0') po
from pregledvremena
where smjena=3
and year(dosao)!=1900 
--and datum='2017-03-01'
--and tdoci='22'
and datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 06:00:00.0')>15 and abs(datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 06:00:00.0')-preranootisao)>3
order by idradnika


select idradnika,datum,dosao,otisao,hala,smjena,ukupno_minuta,preranootisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10)
from pregledvremena
where smjena=1
and year(datum)!=1900 


select *
from pregledvremena
where datum='2017-03-01'
--and tdoci='7'
order by idradnika

-- 1. smjena
update pregledvremena
set preranootisao=j.po
from (
select idradnika,rbroj,datum,dosao,otisao,hala,smjena,tdoci,ukupno_minuta,preranootisao,datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 14:00:00.0') po
from pregledvremena
where smjena=1
and year(dosao)!=1900 
--and datum='2017-03-01'
--and tdoci='22'
and datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 14:00:00.0')>15 and abs(datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 14:00:00.0')-preranootisao)>3
)j
inner join pregledvremena p on p.idradnika=j.idradnika and p.datum=j.datum and p.rbroj=j.rbroj and p.smjena=j.smjena
where p.idradnika=j.idradnika and p.datum=j.datum and p.rbroj=j.rbroj and p.smjena=j.smjena
and j.dosao!=j.otisao
and j.po>30 and j.po<450
order by datum


-- 2. smjena
update pregledvremena
set preranootisao=j.po
from (
select idradnika,rbroj,datum,dosao,otisao,hala,smjena,tdoci,ukupno_minuta,preranootisao,datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 22:00:00.0') po
from pregledvremena
where smjena=1
and year(dosao)!=1900 
--and datum='2017-03-01'
--and tdoci='22'
and datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 22:00:00.0')>15 and abs(datediff(minute,otisao,LEFT(CONVERT(VARCHAR, otisao, 120), 10) +' 22:00:00.0')-preranootisao)>3
)j
inner join pregledvremena p on p.idradnika=j.idradnika and p.datum=j.datum and p.rbroj=j.rbroj and p.smjena=j.smjena
where p.idradnika=j.idradnika and p.datum=j.datum and p.rbroj=j.rbroj and p.smjena=j.smjena
and j.dosao!=j.otisao
and j.po>30 and j.po<450
order by datum


---
select r.prezime,r.ime,p.*
from PregledVremena p
left join radnici_ r on r.id=p.idradnika
where dosao=otisao
and year(dosao)>1900
and month(datum)=6
--and idradnika=36
and smjena!=3
order by idradnika



-- korekcija dosao, kada je dosao=otisao
update pregledvremena
set dosao=j.kdosao
from (
select l.idradnika,l.smjena,l.radnomjesto,l.datum,l.dosao,l.otisao,l.door, min(l.kdosao) kdosao,max(l.kotisao) kotisao
from
(
select p.idradnika,p.smjena,p.radnomjesto,p.datum,p.dosao,p.otisao,e.dt,r.door, case when r.door in (7,8) and abs(datediff(n,e.dt,p.dosao))<30  then p.dosao else e.dt end kdosao, case when r.door in (9,10) and abs(datediff(n,e.dt,p.otisao))<30  then p.otisao else e.dt end  kotisao
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
left join pregledvremena p on p.idradnika=u.extid
where p.dosao=p.otisao and
year(e.dt)=year(p.datum) and month(e.dt)=month(p.datum) and day(e.dt)=day(p.datum)
and year(p.dosao)>1900
and p.smjena!=3
and month(datum)=6
and idradnika=226
) l
group by  l.idradnika,l.smjena,l.radnomjesto,l.datum,l.dosao,l.otisao,l.door
--order by l.idradnika
) j
inner join pregledvremena p on p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto
where j.door in ( 7,8)
and p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto

-- korekcija otisao, kada je dosao=otisao
update pregledvremena
set otisao=j.kotisao
from (
select l.idradnika,l.smjena,l.radnomjesto,l.datum,l.dosao,l.otisao,l.door, max(l.kotisao) kotisao
from
(
select p.idradnika,p.smjena,p.radnomjesto,p.datum,p.dosao,p.otisao,e.dt kotisao,r.door
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
left join pregledvremena p on p.idradnika=u.extid and year(e.dt)=year(p.datum) and month(e.dt)=month(p.datum) and day(e.dt)=day(p.datum)
where

--abs(datediff(minute,dosao,otisao))<1  and --p.dosao=p.otisao and 
--year(e.dt)=year(p.datum) and month(e.dt)=month(p.datum) and day(e.dt)=day(p.datum)
---and year(p.dosao)>1900
--and p.smjena!=3
--and 

r.door in ( 9,10)
and month(datum)=6
and idradnika=226

) l
group by  l.idradnika,l.smjena,l.radnomjesto,l.datum,l.dosao,l.otisao,l.door
--order by l.idradnika
) j
inner join pregledvremena p on p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto
where j.door in ( 9,10)
and p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto



select *
from pregledvremena --_1206
where idradnika=226
and month(datum)=6




update pregledvremena
set dosao=otisao 
where idradnika=10
and datum='2017-06-11'

select e.*,r.Door
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
where u.extid=36
and month(e.dt)=6 and day(e.dt)=3

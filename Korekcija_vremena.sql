select 
from event



select * into pv_test
from pregledvremena
where dosao=otisao
and year(datum)=2017
and year(dosao)>1900


select *
from pv_test
where idradnika=1020



select p.idradnika,p.datum,p.dosao,min(dt),p.otisao,max(dt)
from event e
left join [user] u on u.oid=e.[user]
left join pregledvremena p on p.idradnika=u.extid
where p.dosao=p.otisao and
year(e.dt)=year(p.datum) and month(e.dt)=month(p.datum) and day(e.dt)=day(p.datum)
and year(p.dosao)>1900
and p.smjena!=3
group by p.idradnika,p.datum,p.dosao,p.otisao
order by p.datum



select *
from pregledvremena
where idradnika=1397
and datum>='2017-06-08'



and dt='2017-02-02'




select p.idradnika,p.dosao,p.otisao,p.datum,e.*,r.Door,r.name
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
left join pregledvremena p on p.idradnika=u.extid
where  p.dosao=p.otisao
and year(p.datum)=2017 and e.eventtype='sp39'
and year(p.dosao)>1900
and p.idradnika is not NULL
and e.[user] is not null


select convert(varchar(12),e.dt,104),u.extid,r.Door,r.name,e.dt
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
where eventtype='sp39'
and door in (7,8,9,10)
and month(e.dt)=6
and u.extid=1276



select p.idradnika,p.datum,p.dosao,p.otisao,e.dt,r.door, case when r.door in (7,8) and abs(datediff(n,e.dt,p.dosao))<30  then p.dosao else e.dt end kdosao, case when r.door in (9,10) and abs(datediff(n,e.dt,p.otisao))<30  then p.otisao else e.dt end  kotisao
from event e
left join reader r on r.id=e.device_id
left join [user] u on u.oid=e.[user]
left join pregledvremena p on p.idradnika=u.extid
where p.dosao=p.otisao and
year(e.dt)=year(p.datum) and month(e.dt)=month(p.datum) and day(e.dt)=day(p.datum)
and year(p.dosao)>1900
and p.smjena!=3
and month(datum)=6
--group by p.idradnika,p.datum,p.dosao,p.otisao
order by idradnika,p.datum



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
and idradnika=26
) l
group by  l.idradnika,l.smjena,l.radnomjesto,l.datum,l.dosao,l.otisao,l.door
--order by l.idradnika
) j
inner join pregledvremena p on p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto
where j.door in ( 7,8)
and p.idradnika=j.idradnika and p.datum=j.datum and p.smjena=j.smjena and p.radnomjesto=j.radnomjesto



select *
from pregledvremena
where idradnika=26
and month(datum)=6


order by j.idradnika


select * into pregledvremena_1206
from PregledVremena




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
order by p.idradnika


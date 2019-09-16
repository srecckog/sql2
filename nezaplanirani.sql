-- NEW nije zaplaniran a dosao
use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Režija1','Rez1')
and pv.idradnika is null
and DATEDIFF(day,pv.datum,getdate())=1
--and pv.datum='2017-03-26'
--and id=373
--and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika

) x1
order by x1.prezime



select x1.*,u.*,e.*
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid,pv.datum
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
where pv.idradnika is null



and DATEDIFF(day,pv.datum,getdate())=1
) x1
left join [user] u on u.extid=x1.id
left join event e on u.OID=e.[User]
--where DATEDIFF(day,e.dt,getdate())=1


select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where DATEDIFF(day,datum,getdate())=1

)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
where DATEDIFF(day,e.dt,getdate())=1
)



SELECT *
fROM pregledvremena
where datum='2017-04-12' and idradnika=1337



select *
from pregledvremena
Left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
where pv.idradnika is null

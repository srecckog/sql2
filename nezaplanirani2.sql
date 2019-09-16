DECLARE @datum1 date= '2017-10-09';  
use rfind
-- nezaplanirani
select x1.id,x1.ime,x1.prezime,e.dt vrijeme,r.Name
from (
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where datum=@datum1
)
--and r.id not in 
--(
--select idradnika
--from PregledVremena
--where DATEDIFF(day,datum,@datum1)=1
--and smjena=3
--)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door in (1,8,2,6,7 )
and DATEPART(hour, e.dt)>5
)	
) x1
left join [user] u on u.extid=x1.id
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
order by x1.id,e.dt
use rfind
delete from pregledvremena where datum=@datum1
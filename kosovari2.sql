use rfind


select x2.*
from (
select r.id,r.prezime,r.ime,max(x1.dt) datumZadnjegdolaska, DATEDIFF(day,max(x1.dt),getdate()) BrojDanaNedolaska,r.neradi Odjavljen
from radnici_ r 
left join (

select e.*,r2.id,r2.prezime,r2.ime
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
left join radnici_ r2 on r2.id=u.extid
--here DATEDIFF(day,e.dt,'2018-07-01')<0  AND E.EVENTTYPE='SP39'
where E.EVENTTYPE='SP39' and e.dt>'2018-06-01'
and r.Door not in ( 7,8,9,10)
--and u.extid not in ( select id from radnici_ where id>=1569 and id<=1606)
) x1 on x1.id=r.id
where r.id>=1569 and r.id<=1606
group by r.id,r.prezime,r.ime,r.neradi
) x2
order by x2.BrojDanaNedolaska desc


-------------------

select x2.*
from (
select r.id,r.prezime,r.ime,x1.dt datum,r.neradi Odjavljen
from radnici_ r 
left join (

select e.*,r2.id,r2.prezime,r2.ime
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
left join radnici_ r2 on r2.id=u.extid
--here DATEDIFF(day,e.dt,'2018-07-01')<0  AND E.EVENTTYPE='SP39'
where E.EVENTTYPE='SP39' and e.dt>'2018-06-01'
and r.Door not in ( 7,8,9,10)
--and u.extid not in ( select id from radnici_ where id>=1569 and id<=1606)
) x1 on x1.id=r.id
where r.id>=1569 and r.id<=1606
group by r.id,r.prezime,r.ime,r.neradi,x1.dt
) x2
order by x2.datum desc
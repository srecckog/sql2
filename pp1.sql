use rfind
select r.id,r.prezime,r.ime,e.dt,re.Name
from event e
left join [user] u on u.oid=e.[user]
left join radnici_ r on r.id=u.extid
left join reader re on re.id=e.Device_ID
where u.extid=1088
order by dt desc
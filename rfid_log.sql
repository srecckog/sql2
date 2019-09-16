
select e.dt,r.Door,r.Name,u.LastName,u.FirstName,u.ExtId
from event e 
left join reader r on r.id=e.Device_ID
left join [user] u on u.OID=e.[user]
where DATEDIFF(day,e.dt,'2018-04-14')=0 AND E.EVENTTYPE='SP39'
AND LTRIM(RTRIM(extid))=282
order by dt 




use rfind
select r.prezime,r.ime,p.*
from pregledvremena p
left join radnici_ r on r.id=p.idradnika
where datum>='2017-05-29' and idradnika in (1361,66,1269,1061,1063,1176,1342,1238)
order by r.prezime






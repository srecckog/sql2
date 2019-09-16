select r.prezime,r.ime,idradnika,broj from (
select count(*) broj,idradnika
from (
select r.prezime,r.ime,pv.*
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2018-04-01' and dosao=otisao
and year(dosao)!=1900
)x1
 group by idradnika
 ) x1
 left join radnici_ r on  r.id=x1.idradnika
 order by broj desc

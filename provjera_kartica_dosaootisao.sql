use rfind
select pv.idradnika,count(*)broj,r.prezime,r.ime
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where dosao=otisao
and year(dosao)!=1900
and year(dosao)=2017 and month(dosao)>9
group by idradnika,prezime,ime
order by count(*) desc


use rfind
select x1.idradnika,count(*)broj,x1.prezime,x1.ime
from (

select distinct pv.idradnika,r.prezime,r.ime,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where dosao=otisao
and year(dosao)!=1900
and year(dosao)=2017 and month(dosao)>9
order by prezime,ime

) x1
group by x1.idradnika,x1.prezime,x1.ime
having count(*)>1
order by count(*) desc
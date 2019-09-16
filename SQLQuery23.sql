use feroapp
select *
from radnici 
order by id_fink desc



use rfind
select r.prezime,r.ime,pv.*
from pregledvremena pv
left join radnici_ r on r.id=pv.IDRadnika
where dosao=otisao and year(dosao)!=1900
and datum>'2018-04-01'
order by prezime,datum
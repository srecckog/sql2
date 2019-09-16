use rfind

select distinct x2.id , x2.ime , x2.prezime , x2.hala , x2.brojsmjena
from(

select r.id,r.ime,r.prezime,pv.hala,count(*) brojsmjena
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2017-11-01'
and r.neradi=0
and hala not in ('Režija','')
group by r.id,r.ime,r.prezime,pv.hala

) x2

left join (

select x11.id,x11.ime,x11.prezime,max(brojsmjena) brojsmjena
from (
select r.id,r.ime,r.prezime,pv.hala,count(*) brojsmjena
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2017-11-01'
and r.neradi=0
and hala not in ('Režija','')
group by r.id,r.ime,r.prezime,pv.hala
) x11
group by x11.id,x11.ime,x11.prezime

) x3 on x3.id=x2.id and x2.brojsmjena=x3.brojsmjena

where x3.id=x2.id and x2.brojsmjena=x3.brojsmjena

--group by x2.id,x2.ime,x2.prezime,x2.hala
order by x2.prezime,x2.ime,x2.hala,x2.id

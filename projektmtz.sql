use rfind
select projekt,count(*) broj,k.linija,v.Naziv
from kompetencije k
left join RadniciVjestine rv on rv.idradnika=k.id
left join vjestine v on v.id=rv.idvjestine
left join radnici_ r on r.id=k.id
where r.neradi=0
and k.mjesto_troska='Tokarenje'
group by projekt,v.naziv,k.linija
order by projekt


use rfind
select projekt,count(*) broj
from kompetencije k
left join radnici_ r on r.id=k.id
where r.neradi=0
and k.mjesto_troska='Tokarenje'
group by projekt
order by projekt

select *
from projectmtz

select *
from kompetencije
where projekt='SKF'
and linija='Ostalo'


update projectmtz set linija=(isnull(available,0) - isnull(okuma,0)- isnull(sherer,0)-isnull(iv,0)-isnull(emag,0)-isnull(dodatneoperacije,0))



use rfind
select count(*)
from (select distinct id
from(
select projekt,count(*) broj,k.id,v.Naziv, '1' prior
from kompetencije k
left join RadniciVjestine rv on rv.idradnika=k.id
left join vjestine v on v.id=rv.idvjestine
left join radnici_ r on r.id=k.id
where r.neradi=0
and k.mjesto_troska='Tokarenje' --and (v.naziv='Sherer' or v.naziv='Okuma' or v.naziv='IV')
and k.projekt='BDF' AND v.naziv='IV'
and k.id not in (
select idradnika
from radnicivjestine
where idvjestine in (16,17))
group by projekt,k.id,v.naziv
)x1)x2
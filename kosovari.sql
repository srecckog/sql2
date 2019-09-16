use rfind
select r.prezime,r.ime,p.dosao,p.otisao,smjena,hala,p.radnomjesto,ukupno_minuta,kasni,preranootisao
from pregledvremena p
left join radnici_ r on r.id=p.idradnika
where r.id>=1569 and r.id<=1606
order by r.prezime,p.datum desc


use rfind
select r.prezime,r.ime,p.datum,p.dosao,p.otisao,smjena,hala,p.radnomjesto,ukupno_minuta,kasni,preranootisao,r.neradi, case when (dosao=otisao) then 'Nije se ispravno registrirao' end registracija
from pregledvremena p
left join radnici_ r on r.id=p.idradnika
where r.id>=1569 and r.id<=1606
and ( kasni>20  or ukupno_minuta<450)
and year(dosao)!=1900
order by r.prezime,p.datum desc


select 
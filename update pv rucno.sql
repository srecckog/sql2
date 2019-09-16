select *
from pregledvremena
where datum>='2018-03-01' and datum<'2018-03-31'
and ukupno_minuta<15 and ukupno_minuta>0 and year(dosao)!=1900



select *
from pregledvremena
where idradnika=282 and datum>='2018-03-14' and datum<'2018-03-16'
and dosao=otisao

UPDATE PRegledvremena set otisao='2018-03-13 21:32' where idradnika=807 and datum='2018-03-13' and tdoci=14
update pregledvremena set Ukupno_minuta=datediff(n,dosao,otisao) where datum>='2018-03-01' 

delete from pregledvremena where idradnika=814 and datum='2018-03-18' and tdoci=6


select r.id,r.prezime,r.ime,pv.datum,pv.dosao,pv.otisao,pv.ukupno_minuta,pv.radnomjesto,pv.preranootisao
from radnici_ r
left join pregledvremena pv on r.id=pv.idradnika
where pv.datum>='2018-03-01'
and idradnika=892



select *
from pregledvremena
where datediff(n,dosao,otisao)!=ukupno_minuta
and datum>='2018-03-01' 

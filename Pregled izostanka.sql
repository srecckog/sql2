select datum,count(*) broj, 'Bolovanje' vrsta
from pregledvremena
where datum='2017-08-31'
and radnomjesto in ('BO','B.O.')
GROUP BY DATUM
UNION ALL
select datum,count(*) broj, 'GO' vrsta
from pregledvremena
where datum='2017-08-31'
and radnomjesto in ('GO','G.O.')
GROUP BY DATUM
union all
select datum,count(*) broj,'Nisu dosli' vrsta
from pregledvremena
where datum='2017-08-31'
and dosao=otisao AND YEAR(DOSAO)=1900 AND radnomjesto NOT in ('BO','B.O.','go','G.O.','GO')
GROUP BY DATUM



SELECT pv.rbroj,r.ime,r.prezime,pv.radnomjesto,pv.kasni,r.mt
FROM Pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum='2017-08-30'
and pv.radnomjesto in ('BO','B.O.','go','G.O.','GO')
or pv.kasni>0


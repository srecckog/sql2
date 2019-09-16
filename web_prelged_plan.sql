use rfind
select idradnika,prezimeime,datum,dosao,otisao,hala,smjena,RadnoMjesto
from pregledvremena2
where idradnika=1182
order by datum desc


select idradnika,prezimeime,datum,dosao,otisao,hala,smjena,RadnoMjesto
from pregledvremena2
where datum='2017-03-14'
order by hala,smjena,radnomjesto



select idradnika,r.prezime,r.ime,datum,dosao,otisao,hala,smjena,pv.RadnoMjesto
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum='2017-03-14'
order by hala,smjena,pv.radnomjesto
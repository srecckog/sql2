use rfind
select p.datum,r.id,r.prezime,r.ime,p.hala,p.smjena,p.radnomjesto,p.dosao,p.otisao,p.Kasni,p.Ukupno_minuta,p.Ukupno_sati
from pregledvremena p
left join radnici_ r on r.id=p.idradnika
where prezime like  '%gAŠP%'
order by p.datum desc

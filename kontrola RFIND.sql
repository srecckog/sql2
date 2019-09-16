-- kontrola 12 sati 
select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati,pv.rbroj,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2017-04-17'
and ukupno_minuta>720
order by datum

-- kontrola druga smjena prije 11 sati ????
select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati,pv.rbroj,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2017-04-17'
and smjena=2 and datepart(hh,dosao)<11 and year(dosao)!=1900
order by datum


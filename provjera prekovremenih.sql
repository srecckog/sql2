use feroapp
select r.ID_Radnika,r.ID_Firme,r.ID_Fink,r.Ime, sum(satiradaradnika) ukupno_sati
from evidnormiradA('2017-04-03','2018-04-04') a
left join radnici r on r.ID_Radnika=a.ID_Radnika
where datum='2017-04-04'
and a.hala=3
group by r.ID_Radnika,r.ID_Firme,r.ID_Fink,r.Ime
having sum(satiradaradnika)>8
ORDER BY r.id_radnika


use rfind
select r.prezime,r.ime,pv.rbroj,pv.datum,pv.dosao,pv.otisao,pv.napomena,pv.Smjena,pv.RadnoMjesto,pv.Ukupno_minuta,round(ukupno_minuta/60,1) sati
from pregledvremena pv
left join radnici_ r on r.id=pv.IDRadnika
where ukupno_minuta>540
and datum='2017-04-03'



use feroapp
select a.*
from evidnormiradA('2017-04-03','2018-04-04') a
left join radnici r on r.ID_Radnika=a.ID_Radnika
where datum='2017-04-04'
and a.hala=3

ORDER BY r.id_radnika
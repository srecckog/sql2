use  feroapp
select A.Radnik,a.Smjena,a.Hala,a.Linija,a.Norma,a.KolicinaOK,ID_Firme,R.ID_Fink,a.Napomena1,a.Napomena2
from evidnormiradA('2017-04-04','2017-04-04') a
left join radnici r on r.ID_Radnika=A.ID_Radnika
where datum='2017-04-04'
and a.hala=3
ORDER BY A.HALA,SMJENA


select *
from radnici
where id_radnika=1743



use  feroapp
select A.*
from evidnormiradA('2017-04-04','2017-04-04') a
left join radnici r on r.ID_Radnika=A.ID_Radnika
where datum='2017-04-04'
and radnik like '%BRLIÆ%'
and a.hala=3
ORDER BY A.HALA,SMJENA,linija


use feroapp
select r.ID_Radnika,r.ID_Firme,r.ID_Fink,r.Ime, sum(satiradaradnika) ukupno_sati
from evidnormiradA('2017-04-04','2017-04-04') a
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
and datum='2017-04-04'


USE RFIND
select *
from PregledVremena
where idradnika=852
and datum='2017-04-04'





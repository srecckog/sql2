use rfind
select idradnika,PV.Rbroj,pv.datum,dosao,otisao,r.mt,r.prezime,r.ime,Ukupno_minuta,r.poduzece,pv.RadnoMjesto, case when year(dosao)=1900 then 0 else 1 end Dosao
from pregledvremena pv
left join radnici_ r on pv.idradnika=r.id
left join MjestoTroska mt on mt.id=r.mt
where month(datum)=3 and year(datum)=2018
--and r.mt=700
and r.prezime LIKE '%struhak%'
ORDER by prezime,DATUM


update pregledvremena set dosao='2018-03-11 6:06' where idradnika=242 and datum='2018-03-11'


select distinct radnomjesto from (

select rbroj,datum,idradnika,r.prezime,r.ime,r.poduzece,hala,smjena,pv.radnomjesto,8 sati
from pregledvremena pv
left join radnici_ r on pv.idradnika=r.id
left join MjestoTroska mt on mt.id=r.mt
where month(datum)=3 and year(datum)=2018
--and r.mt=700
and r.prezime LIKE '%STRUHAK%'
ORDER BY DATUM

--and r.id=242
) x1
order by radnomjesto

ORDER by prezime,datum


use FeroApp
select distinct datum,smjena
from (
select datum,smjena,VrijemeOdTC15,VrijemeDoTC15
from EvidNormi('2016-04-01','2016-04-30',0)
where TekstCheck04=1 or TekstCheck05=1
)x1
order by datum,smjena




use FeroApp
select *
from EvidNormi('2016-11-07','2016-11-07',0)
where kupac like '%SONA%'
order by nazivpro

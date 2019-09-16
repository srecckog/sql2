


select *
from evidnormi('2016-09-01','2016-10-31',0)
where TekstCheck01=1
and linija='11'
order by datum,hala,linija,smjena


select datum,hala,linija,smjena,VrijemeOdTC01,VrijemeDoTC01,id_pro
from evidnormi('2016-09-01','2016-10-31',0)
where TekstCheck01=1
order by datum,hala,linija,smjena



select Hala,linija,count(*) as 'Broj štelanja'
from (
select distinct datum,hala,linija,id_pro
from evidnormi('2016-09-01','2016-09-01',0)
where TekstCheck01=1
group by hala,linija,id_pro,datum
) x1
group by hala,linija
order by hala,linija


select linija,sum(Brojstelanja)
from (
select datum,linija,id_pro,count(*) as Brojstelanja
from evidnormi('2016-09-01','2016-10-31',0)
where TekstCheck01=1
group by linija,id_pro,datum
) x1
group by linija
order by linija


--order by datum,hala,linija,smjena
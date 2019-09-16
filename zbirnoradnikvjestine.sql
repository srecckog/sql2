use feroapp
select count(*) kolikoputa,hala,linija,p.kratkinazivikupca,sum(kolicinaok) komada,sum(otpadobrada) skarta
 from evidencijanormiview e
left join partneri p on p.id_par=e.id_par
where id_radnika=1482
and month(datum)=8 and year(datum)=2017
and e.kolicinaok>0
group by hala,linija,p.kratkinazivikupca


select count(*) kolikoputa,e.hala,e.linija,p.kratkinazivikupca,p.NazivPar,p.id_par,sum(e.kolicinaok) komada,sum(e.otpadobrada) skarta 
from feroapp.dbo.evidencijanormiview e 
left join feroapp.dbo.radnici r on r.id_radnika = e.id_radnika 
left join feroapp.dbo.partneri p on p.id_par = e.id_par 
where r.id_fink = 1362 and e.kolicinaok > 0 
group by e.hala,e.linija,p.kratkinazivikupca,p.nazivpar,p.id_par order by count(*) desc


select e.*
from feroapp.dbo.evidencijanormiview e 
left join feroapp.dbo.radnici r on r.id_radnika = e.id_radnika 
left join feroapp.dbo.partneri p on p.id_par = e.id_par 
where r.id_fink = 62 and e.kolicinaok > 0 
and e.hala='1' and linija='06' and e.id_par=274
order by datum desc
--group by e.hala,e.linija,p.kratkinazivikupca order by count(*) desc


select *
from partneri
where id_par=121269


update partneri set kratkinazivikupca='BMW' where id_par=121269


where kratkinazivikupca is not null

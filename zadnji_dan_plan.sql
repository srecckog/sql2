declare @dat2 date='2018-08-28' -- datum uzimanja podataka

select p.idradnika,y1.ime,p.datum,p.hala,p.smjena,p.radnomjesto,y1.id,y1.poduzece
from pregledvremena p
left join 
(
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'1' poduzece,j.acfieldsa
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null ) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'3' poduzece,j2.acfieldsa
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where (j2.adDateEnd is null ) and rtrim(p2.acregno) not  in ('','0000')
)y1 on y1.id = p.idradnika
where p.datum=@dat2  and p.idradnika<8000 

union all

select (p.idradnika-8000) idradnika,y2.ime,p.datum,p.hala,p.smjena,p.radnomjesto,y2.id,y2.poduzece
from pregledvremena p
left join 
(
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'1' poduzece,j.acfieldsa
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null ) and rtrim(p.acregno) not  in ('','0000')
)y2 on y2.id = (p.idradnika-8000)
where p.datum=@dat2  and p.idradnika>8000 and p.idradnika<9000
order by p.idradnika

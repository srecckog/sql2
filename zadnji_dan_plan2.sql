Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
declare @dat1 date='2018-08-01' -- datum odlaska

select *
from (
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'1' poduzece,j.acfieldsa
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null or j.addateend>@dat1) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'3' poduzece,j2.acfieldsa
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where (j2.adDateEnd is null or j2.addateend>@dat1) and rtrim(p2.acregno) not  in ('','0000')
)y1
--where addateend is not null
order by id


declare @dat1 date='2018-08-01' -- datum odlaska
select p.idradnika,y1.ime,p.datum,p.hala,p.smjena,p.radnomjesto,y1.id,y1.poduzece,y1.addateend
from pregledvremena p
left join 
(
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'1' poduzece,j.acfieldsa
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null or j.addateend>@dat1) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'3' poduzece,j2.acfieldsa
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where (j2.adDateEnd is null or j2.addateend>@dat1) and rtrim(p2.acregno) not  in ('','0000')
)y1 on y1.id = p.idradnika
where p.datum='2018-08-28' 
order by p.idradnika




select r.*
from pregledvremena p
left join radnici_ r on r.id=p.idradnika
where idradnika=1604
order by datum desc






where idradnika>8000

delete from pregledvremena where datum>='2018-06-30' and idradnika=1414
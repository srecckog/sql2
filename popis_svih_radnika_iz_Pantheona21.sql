declare @dat1 date='2019-07-01' -- datum odlaska

select *
from (
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'AT' poduzece,j.acfieldsa,p.actaxid oib,p.acactive
from PantheonFxAt.dbo.thr_prsn p
left join PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null or j.addateend>@dat1) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'TKB' poduzece,j2.acfieldsa,p2.actaxid oib,p2.acactive
from [PantheonTKB].dbo.thr_prsn p2
left join [PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where (j2.adDateEnd is null or j2.addateend>@dat1) and rtrim(p2.acregno) not  in ('','0000')
)y1
--where addateend is not null
order by ime




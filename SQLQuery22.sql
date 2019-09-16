declare @dat1 date='2018-01-01' -- datum odlaska

select y1.* --,p.acStatus
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
--where year(datumzaposlenja)=2017
left join thr_prsnstatus p on p.acWorker=y1.ime
where p.acStatus like '%1.%' and y1.datumzaposlenja<'2017-01-01'
--where addateend is not null
order by ime





select *
from [PantheonFxat].dbo.thr_prsnjob
--where acworker like '%KOLAR%'
group by acworker
having count(*)>1


select y1.*
from 
(
select count(*)broj,j.acworker,j.adDate
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob j on p.acworker=j.acworker
--where year(j.addate)<2017 and p.acactive='T'
where p.acactive='T' and anid=2 and year(j.addate)=2017
group by j.acworker,j.adDate
--having count(*)>1
) y1
left join [PantheonTKB].dbo.thr_prsnjob j on y1.acworker=j.acworker
where j.addate<='2017-01-01'


order by acworker




select j.*
from [PantheonFxat].dbo.thr_prsn p
left join [PantheonFxat].dbo.thr_prsnjob j on p.acworker=j.acworker
--where year(j.addate)<2017 and p.acactive='T'
where p.acactive='T'
order by acworker
--group by j.acworker
--1having count(*)>0
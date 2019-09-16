select p.acworker,j.accostdrv MT
from thr_prsn p
left join thr_prsnjob j on p.acworker=j.acworker
where p.addateexit is null



select j.accostdrv MT, count(*),'Feroimpex'  Poduzece
from [PantheonFxAt].dbo.thr_prsn p
left join thr_prsnjob j on p.acworker=j.acworker
where p.addateexit is null
group by j.accostdrv
union all
select j.accostdrv MT, count(*),'TokaBu'  Poduzece
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob j on p.acworker=j.acworker
where p.addateexit is null
group by j.accostdrv


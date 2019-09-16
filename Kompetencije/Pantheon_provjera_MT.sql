select *
from (
select j.acCostDrv,p.acworker,'TB' Poduzece
from thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob j on p.acworker=j.acworker
where addateexit is null and j.addateend is null
union all
select j.acCostDrv,p.acworker,'FX' Poduzece
from [PantheonFxAt].dbo.thr_prsn p
left join [PantheonFxAt].dbo.thr_prsnjob j on p.acworker=j.acworker
where addateexit is null and j.addateend is null
) x1
where accostdrv=''
order by x1.acworker



select *
from [PantheonFxAt].dbo.thr_prsnjob p
where charindex('1185',acworker)>0
order by acworker
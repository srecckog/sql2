use PantheonFxAt
select * from tHR_SlryCalcSum 
where acregno=1173


select t.acname , a.anvalue/NULLIF(a.anhours,0) bruto1, a.annet/NULLIF(a.anhours,0) neto1, a.* from 
thr_SlryCalcET a
left join thr_SetSlryET t on a.acET=t.acet
where acworker like '%1251%'
and ACPERIOD='2017-06'
order by acworker

--and a.acet='X2'


select *
from
thr_SetSlryET



select *
from plansatirada



-- provjera mjesta troška
select p.acworker,j.acCostDrv MT,'FX' Poduzece
from thr_prsn p
left join thr_prsnjob j on p.acworker=j.acworker
where j.addateend is null and j.acCostDrv=''
union all
select p.acworker,j.acCostDrv MT,'TB' Poduzece
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob j on p.acworker=j.acworker
where j.addateend is null and j.acCostDrv=''



select * into panth_radnici
from (
select p.acregno id, p.acworker,j.acCostDrv MT,'FX' Poduzece
from thr_prsn p
left join thr_prsnjob j on p.acworker=j.acworker
where j.addateend is null 
union all
select p.acregno id, p.acworker,j.acCostDrv MT,'TB' Poduzece
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob j on p.acworker=j.acworker
where j.addateend is null 
) x1

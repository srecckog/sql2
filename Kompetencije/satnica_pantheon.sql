--select anhourfund,annet,anwrk28
select angross,anNet,anextras,anwrk23,(annet/anHourFund) neto,angross/anHourFund bruto1
from [dbo].[tHR_SlryCalcSum]
where anHourFund=176
order by (annet/anHourFund)


select acworker, acregno,anhourfund,angross,anintax,annet,(annet/anhourfund) neto1,cast(anwrk23 as money)bruto1, k.satnica as sat_komp
from [dbo].[tHR_SlryCalcSum] s
left join fxserver.rfind.dbo.kompetencije k on k.id=s.acRegNo
where acperiod='2017-03'
and k.id is not null
and anhourfund>0


update fxserver.rfind.dbo.kompetencije set satnicabruto =j.satnica
from
(select acregno id, cast (anwrk23 as money)satnica from [dbo].[tHR_SlryCalcSum] s where s.acPeriod='2017-04') j 
inner join fxserver.rfind.dbo.kompetencije k on k.id=j.id


select *
from [dbo].[tHR_SlryCalcSum] 
where anwrk23=0 and acperiod='2017-04'

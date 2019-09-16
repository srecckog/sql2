use rfind
select j.DanOdlaska,k.*
from kompetencije k
left join (
select *
from fxsap.dbo.plansatirada
where danodlaska!=''
and danodlaska<(dateadd(day,30,getdate()))
and danodlaska>(dateadd(day,-30,getdate()))
and danodlaska is not NULL
) j on j.radnikid=k.id
where projekt not in ('NERADI','Na odlasku')
and j.danodlaska is not null
order by PrezimeIme desc
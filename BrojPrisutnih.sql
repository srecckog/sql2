use rfind


select count(*) BrojPrisutnih,datum
from (

select distinct idradnika,datum
from pregledvremena
where datum>='2019-08-01'
and year(dosao)!=1900
--order by idradnika,datum

) x1
group by datum
order by datum

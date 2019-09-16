select count(*) 
from(
select distinct idradnika
from pregledvremena
where datum='2017-07-29' and radnomjesto in ('BO','B.O.')
)x1

select count(*) 
from(
select distinct idradnika
from pregledvremena
where datum='2017-07-29' and radnomjesto in ('GO','G.O.')
)x1


select count(*) 
from(
select distinct idradnika
from pregledvremena
where year(dosao)=1900 and radnomjesto not in ('GO','G.O.','BO','B.O.')
AND DATUM='2017-07-30'
)x1

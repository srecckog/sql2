use feroapp
select distinct kupac,id_par from evidnormi('2017-10-13','2017-10-13',0)


use feroapp
select * from evidnormi('2017-10-13','2017-10-13',0)
where kupac like '%FURT'

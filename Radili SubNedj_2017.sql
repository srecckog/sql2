use fxsap
select radnikid,ime,godina,mjesec,'Subota' Dan
from plansatirada
where godina=2017 and mjesec=1
and dan07 not in ('0e','','0j','5g')
and dan14 not in ('0e','','0j','5g')
and dan21 not in ('0e','','0j','5g')
and dan28 not in ('0e','','0j','5g')
union all
select radnikid,ime,godina,mjesec,'Nedjelja' Dan
from plansatirada
where godina=2017 and mjesec=1
and dan08 not in ('0e','','0j','5g')
and dan15 not in ('0e','','0j','5g')
and dan22 not in ('0e','','0j','5g')
and dan29 not in ('0e','','0j','5g')

union all

select radnikid,ime,godina,mjesec,'Subota' Dan
from plansatirada
where godina=2017 and mjesec=2
and dan04 not in ('0e','','0j','5g')
and dan11 not in ('0e','','0j','5g')
and dan18 not in ('0e','','0j','5g')
and dan25 not in ('0e','','0j','5g')
union all
select radnikid,ime,godina,mjesec,'Nedjelja' Dan
from plansatirada
where godina=2017 and mjesec=2
and dan05 not in ('0e','','0j','5g')
and dan12 not in ('0e','','0j','5g')
and dan19 not in ('0e','','0j','5g')

union all

select radnikid,ime,godina,mjesec,'Subota' Dan
from plansatirada
where godina=2017 and mjesec=3
and dan04 not in ('0e','','0j','5g')
and dan11 not in ('0e','','0j','5g')
and dan18 not in ('0e','','0j','5g')
and dan25 not in ('0e','','0j','5g')
union all
select radnikid,ime,godina,mjesec,'Nedjelja' Dan
from plansatirada
where godina=2017 and mjesec=3
and dan05 not in ('0e','','0j','5g')
and dan12 not in ('0e','','0j','5g')
and dan19 not in ('0e','','0j','5g')

union all

select radnikid,ime,godina,mjesec,'Subota' Dan
from plansatirada
where godina=2017 and mjesec=4
and dan01 not in ('0e','','0j','5g')
and dan08 not in ('0e','','0j','5g')
and dan15 not in ('0e','','0j','5g')
and dan22 not in ('0e','','0j','5g')
and dan29 not in ('0e','','0j','5g')
union all
select radnikid,ime,godina,mjesec,'Nedjelja' Dan
from plansatirada
where godina=2017 and mjesec=4
and dan02 not in ('0e','','0j','5g')
and dan09 not in ('0e','','0j','5g')
and dan16 not in ('0e','','0j','5g')
and dan23 not in ('0e','','0j','5g')
and dan30 not in ('0e','','0j','5


use rfind
select distinct u.extid,u.lastname,u.firstname,(cast(day(e.dt) as varchar) +'.'+ cast(month(e.dt) as varchar) +'.2017') as datumd, case when datepart(dw, dt)=6 then 'Subota' else 'Nedjelja' end as dan
from event e
left join [user] u on u.OID=e.[user]
where datepart(dw, dt) in (6,7)
and year(dt)=2017 
and e.[user] is not null

and u.extid=172
and month(e.dt)=4

order by u.lastname,(cast(day(e.dt) as varchar) +'.'+ cast(month(e.dt) as varchar) +'.2017')


use rfind
select *
from event
where [user]=1047
order by dt desc


select *
from [user]
where extid=750


select *
from pregledvremena
where idradnika=1173
order by datum desc


delete  from pregledvremena where datum>='2019-09-02'

use rfind
select *
from pregledvremena where idradnika=474
and datum='2018-04-02'

delete from pregledvremena where idradnika=474 and datum='2018-04-02' and tdoci>=14
update pregledvremena set totici=22 where idradnika=474 and datum='2018-04-02' and tdoci=6
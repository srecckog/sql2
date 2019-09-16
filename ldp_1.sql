use fxapp
select *
from ldp_aktivnost_view
where datum='2017-03-30' and id_partner=274



use fxapp
select *
from ldp_aktivnost
where datum='2017-03-30' and id_partner=274
and hala<4
order by hala,linija,smjena

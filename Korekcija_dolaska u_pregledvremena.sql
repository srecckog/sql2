use rfind
select *
from pregledvremena
where idradnika=1473
order by datum desc

update pregledvremena set preranootisao=0,otisao='2018-10-13 2:54:0',ukupno_minuta =Datediff(n,dosao,otisao)  where idradnika=1473 and datum='2018-10-12'
use rfind
select r.prezime,r.ime,r.mt,x1.*
from (
select idradnika,count(*) broj_dana
from pregledvremena
where idradnika>=90000
and month(datum )=1 and year(dosao)!=1900   -- mjesec=1
group by idradnika
) x1
left join radnici_ r on r.id=x1.idradnika



select *
from fxsap.dbo.plansatirada
where radnikid =1492


select id, '2018-01-02', (prezime + ' ' + ime) ime , mt , -1       , 0    , 0      , 0     , '' , '' , '' , 'ND' ,0 , '' from radnici_ where datumzaposlenja > '2018-01-02'
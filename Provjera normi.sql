select *
from proizvodnelinije
where naziv='L2' and hala=1


where broj='24'and hala=1


select count(*), parent_pli
from proizvodnelinije
where vrsta='Stroj' and hala=1
group by parent_pli

select *
from proizvodnelinije
where parent_pli=2


select *
from ProizvodneNorme
--where id_pro='830013'
where linija in ('06','06*') and id_pro='830004'

update feroapp.dbo.ProizvodneNorme set norma=180 where  id_pro='830004' and linija='06*' and hala=1

SELECT * from proizvodnelinije where vrsta='Linija' and hala=1 --and broj='06'

SELECT * from proizvodnelinije where vrsta='Linija' and hala=1 and broj='06 L'

select * from feroapp.dbo.proizvodnenorme where hala='1' and linija in ('06','06*') and id_pro='830012' --and norma=210
select * from proizvodnenorme where hala='1' and id_pro='830013' 

select * into rfind.dbo.pnorme170119
from ProizvodneNorme 


select *
from evidnormi('2019-01-17','2019-01-17',0)
where hala=1 and smjena=1 and norma=1

update rfind.dbo.plansatirada2 set dan12=null where mjesec=1 and godina=2019


select *
from rfind.dbo.plansatirada2
where mjesec=1 and godina=2019
and radnikid=172

select r.neradi,p.firma,p.radnikid,p.ime,Dan12,v.dosao,v.otisao,v.ukupno_minuta,v.smjena,a.fixnaisplata from rfind.dbo.plansatirada2 p 
left join feroapp.dbo.radnici r on r.id_fink = p.radnikid and r.id_firme = p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika = r.id_radnika 
left join rfind.dbo.pregledvremena v on v.idradnika = a.id and v.Datum = '2019-01-12' 
where mjesec = 1 and godina = 2019 and v.ukupno_minuta > 465 and a.mt in (700,701,712, 716,704,710,702,713) and Dan12 is null  
order by ime


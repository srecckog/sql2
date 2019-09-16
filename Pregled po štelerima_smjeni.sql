use feroapp
select *
from evidnormi('2017-09-01','2017-09-30',0)
where smjena=1 and id_pro='941151'

select datum,hala,x1.username,smjena,sum(x1.kolicinaok) kolicinaok, sum(norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat,sum(x1.cijena*x1.KolicinaOK) vrijednost
from 
(
select datum,hala,e.username,smjena,kolicinaok, norma,otpadobrada, otpadmat,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=9 and year(datum)=2017
) x1
group by datum,hala,smjena,x1.username
order by datum desc,hala,smjena,x1.username


select hala,x1.username,smjena,sum(x1.kolicinaok) kolicinaok, sum(norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat,sum(x1.cijena*x1.KolicinaOK) vrijednost
from 
(
select hala,e.username,smjena,e.kolicinaok,e.norma,e.ID_Pro, otpadobrada, otpadmat,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=9 and year(datum)=2017
--and e.id_pro='941151'

) x1
group by hala,smjena,x1.username
order by hala,smjena,x1.username



select x1.username,sum(x1.kolicinaok) kolicinaok, sum(norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat,sum(x1.cijena*x1.KolicinaOK) vrijednost,x2.broj_stelanja
from 
(
select hala,e.username,smjena,e.kolicinaok,e.norma,e.ID_Pro, otpadobrada, otpadmat,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=9 and year(datum)=2017
) x1
left join 
(
select count(*) broj_stelanja,x.username
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and month(pocetak)=9 and year(pocetak)=2017
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.username
) x2 on x2.username=x1.username
where x2.broj_stelanja is not null
group by x1.username,x2.broj_stelanja
order by x1.username



select count(*) broj_stelanja,x.username
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and month(pocetak)=9 and year(pocetak)=2017
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.username
order by x.username









select *
from EvidencijaNormiView

select * from 
[dbo].[NarudzbeSta]
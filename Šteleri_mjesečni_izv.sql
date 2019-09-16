-- treba promijeniti, idradnika ->username
--
--
select x1.username,x1.radnik,sum(x1.kolicinaok) kolicinaok, sum(norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat,sum(x1.cijena*x1.KolicinaOK) vrijednost,x2.broj_stelanja
from 
(
select hala,e.username,smjena,e.kolicinaok,e.norma,e.ID_Pro, otpadobrada, otpadmat,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena,e.ID_Radnika,e.radnik
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
) x1
left join 
(

select count(*) broj_stelanja,x.id_radnika,x.radnik
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and month(pocetak)=10 and year(pocetak)=2017
) x

left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.username,x.id_radnika,x.radnik
) x2 on x2.id_radnika=x1.id_radnika
where x2.broj_stelanja is not null
group by x1.username,x2.broj_stelanja,x2.id_radnika,x1.radnik
order by x1.username


-- broj štelanja
select count(*) broj_stelanja,x.id_radnika,x.radnik,x.username
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and month(pocetak)=10 and year(pocetak)=2017
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.username,x.id_radnika,x.radnik
order by count(*) desc


-- pregled po broju upisa
select username,count(*) broj_upisa
from(
select hala,e.username,smjena,e.kolicinaok,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena,e.ID_Radnika,e.radnik
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
)x1
group by username
order by count(*) desc


-- pregled po vrijednosti
select username,sum(kolicinaok*cijena) vrijednost
from(
select hala,e.username,smjena,e.kolicinaok,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena,e.ID_Radnika,e.radnik
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
)x1
group by username
order by sum(kolicinaok*cijena) desc


-- pregled po kolièini
select e.username,sum(e.kolicinaok) kolicinaok,sum(e.norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
group by e.username
order by sum(e.kolicinaok) desc



select distinct x1.username,x1.broj_upisa,x2.kolicinaok,x2.otpadobrada,x3.vrijednost
from
(
select username,count(*) broj_upisa
from(
select hala,e.username,smjena,e.kolicinaok,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena,e.ID_Radnika,e.radnik
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
)x11
group by x11.username
)x1

left join (
select e.username,sum(e.kolicinaok) kolicinaok,sum(e.norma) norma,sum(otpadobrada) otpadobrada, sum(otpadmat) otpadmat
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
group by e.username
) x2 on x2.username=x1.username

left join (
select x11.username,sum(kolicinaok*cijena) vrijednost
from(
select hala,e.username,smjena,e.kolicinaok,(e.ObradaA*n.CijenaObrada1+e.ObradaB*n.CijenaObrada2+e.ObradaC*n.CijenaObrada3) cijena,e.ID_Radnika,e.radnik
from EvidencijaNormiView e
left join narudzbesta n on e.brojrn=n.BrojRN1
where month(datum)=10 and year(datum)=2017
)x11
group by x11.username

) x3 on x3.username=x1.username
order by x1.username



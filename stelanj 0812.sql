declare @dat11 date
declare @dat12 date

set @dat11='2017-11-24 06:0:0'
set @dat12='2018-12-08 06:0:0'

SELECT pr.NazivPro,pla.*, p.naziv,p.hala,(SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
left join proizvodnelinije p on p.id_pli=pla.id_pli
left join narudzbesta n on n.BrojRN=pla.BrojRN
left join Proizvodi pr on pr.ID_Pro=n.ID_Pro
where (aktivnost like '%nema sirovca%' or pla.napomena like '%otkivak%')
and ( pocetak >=@dat11  and pocetak<=@dat12)


<yxy<x
select *
from proizvodnelinije



select count(*) broj_stelanja,p.nazivpar kupac,x.vrstanarudzbe
from (

SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and ( pocetak >=@dat11  and pocetak<=@dat12)

--and pocetak >@dat11 and ( kraj<@dat12 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.NazivPar,x.vrstanarudzbe
order by p.nazivpar
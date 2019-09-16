declare @dat1 date
declare @dat11 varchar(18)
declare @dat2 date
declare @dat12 varchar(18)
set @dat1='2018-01-24'
set @dat2='2018-01-24'

set @dat11 ='2018-01-24 06:00:00'
set @dat12 =  '2018-01-24 06:00:00'

select count(*) broj_stelanja,x.hala,p.nazivpar kupac,x.vrstanarudzbe
from (
SELECT pla.*,pl.hala, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
inner join feroapp.dbo.ProizvodneLinije pl  on pl.ID_PLI=pla.ID_PLI
where aktivnost like '%ŠTEL%'
and ( pocetak >=@dat11  and pocetak<=@dat12)
--and pocetak >@dat11 and ( kraj<@dat12 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.hala,p.NazivPar,x.vrstanarudzbe
order by p.nazivpar

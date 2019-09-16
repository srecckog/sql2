declare @dat1 varchar(20)='2017-08-31 06:00'
declare @dat2 varchar(20)='2017-09-01 06:00'

select a.*,p.NazivPar
from (
SELECT pl.hala,pl.Naziv, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
where aktivnost like '%ŠTEL%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
--group by p.nazivpar,a.vrstanarudzbe,a.hala,a.naziv
order by p.nazivpar,a.hala,a.Naziv
----------------------
declare @dat11 varchar(20)='2017-08-30 06:00'
declare @dat12 varchar(20)='2017-08-31 06:00'

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
----------------------
declare @dat11 varchar(20)='2017-08-29 06:00'
declare @dat12 varchar(20)='2017-08-30 06:00'

select x1.*,e.vrijemeod,e.vrijemedo,e.smjena --, (select (cast(datum as varchar(10))+' '+cast(vrijemeod as varchar(10))) as datum1 from feroapp.dbo.evidnormi('2017-08-29','2017-08-29',0) e where e.hala=x1.hala and e.linija=x1.broj ) as datum1

from (

SELECT pl.hala,pl.Naziv,pl.Broj,pla.*,case when datepart(hour,pocetak)>=6 and datepart(hour,pocetak)<=14 then 1 when datepart(hour,pocetak)>14 and datepart(hour,pocetak)<=22 then 2 when datepart(hour,pocetak)>22 and datepart(hour,pocetak)<=23 then 3 when datepart(hour,pocetak)>=0 and datepart(hour,pocetak)<=5 then 3 end smjena, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
left join feroapp.dbo.proizvodnelinije pl on pl.ID_PLI=pla.ID_PLI
where aktivnost like '%ŠTEL%'
and ( pocetak >=@dat11  and pocetak<=@dat12)
) x1
left join feroapp.dbo.evidnormi('2017-08-29','2017-08-29',0) e on e.hala=x1.hala and e.linija=x1.broj and e.smjena=x1.smjena
order by x1.hala,x1.broj





where pocetak> (

select datum1
from (
select cast(datum as varchar(10))+' '+cast(vrijemeod as varchar(10)) as datum1
from feroapp.dbo.evidnormi('2017-08-29','2017-08-29',0) e
where e.hala=x1.hala and e.linija=x1.broj 
)x2

) 















------------------------







declare @dat1 varchar(20)='2017-08-30 06:00'
declare @dat2 varchar(20)='2017-08-30 14:00'
select count(*) broj_stelanja,p.nazivpar kupac,x.vrstanarudzbe
from (

SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and pocetak >@dat1 and ( kraj<@dat2 or kraj is null)

) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.nazivpar,x.vrstanarudzbe
order by p.nazivpar



declare @dat1 varchar(20)='2017-08-29 06:00'
declare @dat2 varchar(20)='2017-08-30 06:00'

select a.*,p.NazivPar
from (
SELECT pl.hala,pl.Naziv, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
where aktivnost like '%ŠTEL%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
--group by p.nazivpar,a.vrstanarudzbe,a.hala,a.naziv
order by p.nazivpar,a.hala,a.Naziv



declare @dat1 varchar(20)='2017-08-29 06:00'
declare @dat2 varchar(20)='2017-08-30 06:00'

select count(*) broj_stelanja,p.KratkiNaziviKupca kupac,x.vrstanarudzbe
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and pocetak >@dat1 and ( kraj<@dat2 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.KratkiNaziviKupca,x.vrstanarudzbe
order by p.KratkiNaziviKupca



declare @dat1 varchar(20)='2017-08-29 06:00'
declare @dat2 varchar(20)='2017-08-30 06:00'

select count(*) broj_stelanja,p.KratkiNaziviKupca kupac,x.vrstanarudzbe
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and pocetak >@dat1 and ( kraj<@dat2 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.KratkiNaziviKupca,x.vrstanarudzbe
order by p.KratkiNaziviKupca


declare @dat11 varchar(20)='2017-08-29 06:00'
declare @dat12 varchar(20)='2017-08-30 06:00'

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


declare @dat11 varchar(20)='2017-08-30 06:00'
declare @dat12 varchar(20)='2017-08-31 06:00'

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





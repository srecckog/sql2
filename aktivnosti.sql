use feroapp

declare @dat1 date='2018-04-19 6:00'
declare @dat2 date='2018-04-20 6:00'

select hala,naziv,aktivnost,sum(trajanje_minuta) trajanje,count(*) broj,napomena
from (
select hala,naziv,aktivnost,pocetak,kraj,trajanje_minuta,brojrn,napomena,username,nazivpar,vrstanarudzbe, 0 izgubljeno
from(
select a.*,p.NazivPar,n.id_pro,pn.norma
from (
SELECT pl.hala,pl.Naziv,pl.broj, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost not like '%ŠTEL%'
where aktivnost not like '%999%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
left join feroapp.dbo.narudzbesta n on n.brojrn=a.brojrn
left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pn.hala=a.hala and pn.linija=a.broj
) b
) x1
group by hala,naziv,aktivnost,Napomena
order by x1.hala,x1.Naziv


---------------------------

use feroapp

declare @dat1 date='2018-04-01 6:00'
declare @dat2 date='2018-04-20 6:00'

select aktivnost,count(*)
from (

select hala,naziv,aktivnost,sum(trajanje_minuta) trajanje,napomena
from (
SELECT pl.hala,pl.Naziv,pl.broj, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost not like '%ŠTEL%'
where aktivnost not like '%999%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) x1
group by hala,naziv,aktivnost,napomena
) x1
group by aktivnost


declare @dat1 date='2018-04-19 6:00'
declare @dat2 date='2018-04-20 6:00'

select hala,naziv,aktivnost,sum(trajanje_minuta) trajanje,napomena,pocetak,kraj,brojrn, case when sat>13 and sat<22 then 2 when  sat>=22 or sat<6 then 3 when  sat>=6 and sat<14 then 1 end smjena 
from (
SELECT pl.hala,pl.Naziv,pl.broj, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe ,DATEPART(HOUR,pocetak ) sat
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost not like '%ŠTEL%'
where aktivnost not like '%999%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) x1
group by hala,naziv,aktivnost,napomena,pocetak,kraj,brojrn,sat
order by x1.hala,x1.naziv






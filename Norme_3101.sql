select * from rfind.dbo.evidnormiradad('2018-01-02','2018-01-02') 
where radnik like '%CARIN%'
order by vrsta,hala,smjena,linija


SELECT *
FROM feroapp.dbo.evidnormi('2018-01-02','2018-01-02',0)
where hala=3 and smjena=2 and linija='25'



select a.*,p.NazivPar
from (
SELECT pl.hala,pl.Naziv, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
where (pocetak >='2018-01-02 14:00'  and pocetak <='2018-01-02 22:00')
AND PL.Hala=3
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
order by p.nazivpar,a.hala,a.Naziv
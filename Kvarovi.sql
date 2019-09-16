
--declare @dat1 varchar(20)='2017-08-30 06:00'
--declare @dat2 varchar(20)='2017-08-31 06:00'

--select hala,naziv,aktivnost,pocetak,kraj,trajanje_minuta,brojrn,napomena,username,nazivpar,vrstanarudzbe, cast(  b.norma*(trajanje_minuta/(420+0.001)) as integer) izgubljeno
select aktivnost,hala,naziv,aktivnost,cast(pocetak as date) datum,kraj,trajanje_minuta,brojrn,napomena,username,nazivpar,vrstanarudzbe, 0 izgubljeno,datepart(dw,pocetak) wdn,case when datediff(d,pocetak,getdate())<7 then 1 else 0 end  ZT,case when datediff(d,pocetak,getdate())<30 then 1 else 0 end  ZM,case when datediff(d,pocetak,getdate())<365 then 1 else 0 end  ZG,datepart(wk,pocetak) wkn,case when month(pocetak)<10 then cast(datepart(yyyy,pocetak) as varchar(4))+'-0'+cast(datepart(m,pocetak) as varchar(2)) else cast(datepart(yyyy,pocetak) as varchar(4))+'-'+cast(datepart(m,pocetak) as varchar(2)) end mjesec,datepart(yyyy,pocetak) godina
from(

select a.*,p.NazivPar,n.id_pro,pn.norma
from (
SELECT pl.hala,pl.Naziv,pl.broj, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost not like '%ŠTEL%'
where  (pocetak >='2017-01-23'  and pocetak <=getdate())
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
left join feroapp.dbo.narudzbesta n on n.brojrn=a.brojrn
left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pn.hala=a.hala and pn.linija=a.broj
) b
--where aktivnost like '%Kvar%'
order by year(pocetak)*100+month(pocetak),b.aktivnost

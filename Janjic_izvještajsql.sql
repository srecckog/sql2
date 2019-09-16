
USE FEROAPP
select kupac, linija,sum(kolicinaok) Ukupno
from (
SELECT Datum, Smjena, NazivLinije, Hala, ID_Pro, (SELECT VrstaPro FROM Proizvodi WHERE ID_Pro = EvidNormi.ID_Pro) AS VrstaPro, NazivPro, (CASE WHEN LoanPosao = 1 THEN 'Loan' ELSE 'FX' END) AS Vlasnik, BrojRN, OrderNo, KolicinaOK, OtpadMat, OtpadObrada, ID_Par, Kupac, case when  nazivlinije in ( 'l10','l11') then 'Shareri' when  nazivlinije in ( 'l12.1','l12.2') then 'Okuma'else 'Standardne Linije'   end  linija
                FROM EvidNormi('2015-01-01', '2015-09-14', 0)
                WHERE (CASE WHEN ZavrsnaObrada = 'Tokarenje' AND ObradaA = 1 THEN 1 WHEN ZavrsnaObrada = 'Glodanje' AND ObradaB = 1 THEN 1 WHEN ZavrsnaObrada = 'Busenje' AND ObradaB = 1 THEN 1 ELSE 0 END) = 1
				) x1
				group by kupac,linija
				order by kupac,linija


select kupac, linija,sum(iznos) Ukupno_Kn
from (
SELECT Datum, NazivLinije, Hala, ID_Pro, NazivPro, NazivMat, KolicinaOK, OtpadMat, OtpadObrada, ID_Par, Kupac, case when  nazivlinije in ( 'l10','l11') then 'Shareri' when  nazivlinije in ( 'l12.1','l12.2') then 'Okuma'else 'Standardne Linije'   end  linija,
CAST((((ObradaA * CijenaObradaA) + (ObradaB * CijenaObradaB) + (ObradaC * CijenaObradaC) + (Obrada3 * CijenaObrada3)) * KolicinaOK) AS Float) AS Iznos 
FROM EvidNormi('2015-03-01', '2015-03-10', 0)
) x1
group by kupac,linija
order by kupac,linija

select sum(kolicinaok)
FROM EvidNormi('2016-09-01', '2016-12-10', 0)
where nazivpro like '%Z-581079.12-3105.IR.TR2-W220%' and BrojRN ='08/1351'


select sum(kolicinaok)
FROM EvidNormi('2016-12-30', '2016-12-30', 0)
where id_par in ( 121300,121301,121310)
and hala = 1


select sum(norma)
FROM EvidNormi('2016-12-30', '2016-12-30', 0)
where hala = 1



select sum(kolicinaok)   --sum(kolicinaok)
FROM EvidNormi('2016-12-30', '2016-12-30', 0)
where hala = 1


order by linija


--kysuce

--select datum,brojrn,linija,nazivpro,kolicinanar as naruceno,sum(kolicinaok) izraðeno,norma,(datepart(week,datum)-1) weeknumber
select datum,nazivpro,orderno,kolicinanar,sum(kolicinaok) qty,sum(otpadmat)Otpadmat
FROM EvidNormi('2016-12-1', '2016-12-31', 0)
--where BrojRN ='08/1328'
where id_par=121273
group  by datum,nazivpro,orderno,kolicinanar
--group by datum,brojrn,linija,nazivpro,brojrn,KolicinaNar,norma
order by datum


select *
FROM EvidNormi('2016-12-3', '2016-12-3', 0)
--where BrojRN ='08/1328'
where id_par=121273
--group  by datum,nazivpro,orderno,kolicinanar
--group by datum,brojrn,linija,nazivpro,brojrn,KolicinaNar,norma
order by datum



select x1.weeknumber,sum(izraðeno),avg(izraðeno)
from (
select (datepart(week,datum)-1) weeknumber,sum(kolicinaok) izraðeno,avg(kolicinaok) avg,datum
FROM EvidNormi('2016-12-01', '2016-12-31', 0)
--where BrojRN ='08/1328'
where id_par=8752
and month(datum)=12
and kolicinaok!=0
group by datum
) x1
group by weeknumber
order by weeknumber



use feroapp
select *
FROM EvidNormi('2016-12-01', '2016-12-30', 0)


select x1.hala,x1.norma,x1.komada, convert( decimal(10,2),x1.komada*100.00/x1.norma) OstvarenoPosto
from (
select hala,sum(norma) norma,SUM(KOLICINAok) komada, avg(KOLICINAok/norma) ostvareno
FROM EvidNormi('2016-11-28', '2016-12-28', 0)
group by hala
) x1
order by hala




--sona

select datum,nazivpro,orderno,kolicinanar,sum(kolicinaok) qty,sum(otpadmat) Otpadmat,sum(otpadobrada) otpadobrade, substring(nazivpro,4,4) mat1
FROM EvidNormi('2016-12-23', '2016-12-23', 0)
where id_par in ( 121300,121301,121310)
group  by datum,nazivpro,orderno,kolicinanar
order by datum



--debrecin FAG, Šæuric

--select datum,brojrn,linija,nazivpro,kolicinanar as naruceno,sum(kolicinaok) izraðeno,norma,(datepart(week,datum)-1) weeknumber
--select datum,nazivpro,orderno,kolicinanar,sum(kolicinaok) qty,sum(otpadmat)Otpadmat

select datum,sum(kolicinaok) qty
FROM EvidNormi('2016-12-1', '2016-12-31', 0)
where id_par= 221452
group  by datum
order by datum



-- zastoji linija

select *
FROM EvidNormi('2016-12-27', '2016-12-27', 0)
where linija='20' and hala=3
order by datum

--- evidencija normi rada

select x1.*,enr.Napomena1,R.ID_Fink,R.ID_Firme from
EvidencijaNormiRadnici enr 
INNER join (
SELECT LINIJA,id_radnika,RADNIK,VRIJEMEOD,VRIJEMEDO,NORMA,KOLICINAOK,DATUMUNOSA,vrijemeunosa
FROM [FeroApp].[dbo].[EvidencijaNormiSta]

) x1 on x1.ID_Radnika=enr.ID_Radnika
LEFT JOIN RADNICI R ON R.ID_Radnika=X1.ID_RADNIKA
WHERE X1.RADNIK LIKE '%DRENŠKI%'
AND X1.DATUMUNOSA=enr.datumunosa
and x1.datumunosa='1/17/2017'


select enr.* from
EvidencijaNormiRadnici enr 
where datumunoSA='01/19/2017'
AND RADNIK LIKE '%Gašp%'

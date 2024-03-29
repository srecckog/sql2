/****** Script for SelectTopNRows command from SSMS  ******/
select * -- SUM(kolicinaok)
from evidnormi('2017-07-01','2018-07-20',0)
where tekstcheck01=1 and VrijemeOdTC01=VrijemeDoTC01

select SUM(kolicinaok)
from evidnormi('2017-06-20','2018-06-20',0)
where gotovo=1 and kupac like '%SONA%'






where kupac like '%sona%' and gotovo=1


order by kupac



SELECT TOP 1000 [ID_EPS]

select ez.*
  FROM [FeroApp].[dbo].[EvidencijaProizvodnjeSta] es
  left join [FeroApp].[dbo].[EvidencijaProizvodnjezag] ez on es.ID_EPZ=ez.ID_EPZ


  left join evidencijaproizvodnjezag ez on es.ID_EPz=ez.ID_EPz


USE  FeroApp

select x1.nazivpar,sum(x1.kolicinaok) ukupo_kom,sum(x1.otpadobrada) otpadobrada, sum(x1.otpadmaterijal)otpadmat
from (

SELECT EPZ.BrojRN, NDV.ID_Par AS Kupac,p.NazivPar,eps.* 
       FROM EvidencijaProizvodnjeSta EPS
       LEFT JOIN EvidencijaProizvodnjeZag EPZ ON EPS.ID_EPZ = EPZ.ID_EPZ 
       LEFT JOIN NarudzbeDetaljnoView NDV ON EPZ.BrojRN = NDV.BrojRN 
	   left join Partneri p on p.ID_Par=ndv.id_par			
       WHERE EPS.Datum = '2017-06-21' 
	   and ndv.id_par=274
	   ) x1
	   group by nazivpar

-- evidencija normi
-- provjeriti obrade
select x1.nazivpar,sum(x1.kolicinaok) ukupo_kom,sum(x1.otpadobrada) otpadobrada, sum(x1.otpadmaterijal)otpadmat
--select sum(x1.kolicinaok)
from (
SELECT EPZ.BrojRN,ndv.BazniRN, NDV.ID_Par AS Kupac,ndv.obrada1,ndv.obrada2,ndv.obrada3,ndv.obrada4,p.NazivPar,eps.* 
       FROM EvidencijaProizvodnjeSta EPS
       LEFT JOIN EvidencijaProizvodnjeZag EPZ ON EPS.ID_EPZ = EPZ.ID_EPZ 
       LEFT JOIN NarudzbeDetaljnoView NDV ON EPZ.BrojRN = NDV.BrojRN 
	   left join Partneri p on p.ID_Par=ndv.id_par			
       WHERE EPS.Datum = '2017-06-21' 
	   and ndv.id_par=274 --and ( BazniRN=1 and ( obrada1=1 or obrada3=1)
	   ) x1
	   group by nazivpar

------------------ evidencija normi - gedrehte ringe 3
-- Realizacija
select kupac,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where gotovo=1 and kupac like '%Austria%' and obrada3=0
group by kupac,VrstaNarudzbe
union all
-- SONA
select kupac,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%SONA%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Romania
select kupac,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat, sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%Romania%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' - Prstenovi',sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' - Valjci',sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%Technolo%' AND gotovo=1 and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-20','2017-06-20',0)
where gotovo=1 and  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%'
group by kupac,VrstaNarudzbe






--sona

SELECT ENV.BrojRN, ENV.Radnik, ENV.Radnik2, ENV.Datum, ENV.Hala, ENV.Linija, (CASE WHEN ENV.ObradaA = 1 THEN '+' ELSE '' END), (CASE WHEN ENV.ObradaB = 1 THEN '+' ELSE '' END), 
       (CASE WHEN ENV.ObradaC = 1 THEN '+' ELSE '' END), ENV.Norma, ENV.KolicinaOK, ENV.OtpadMat, ENV.OtpadObrada, PRO.ZavrsnaObrada, PRO.NazivPro, (CASE WHEN MAT.OmjerPro = 2 THEN 'TURM' ELSE '' END) AS Turm 
       FROM EvidencijaNormiView ENV 
           LEFT JOIN Proizvodi PRO ON ENV.ID_Pro = PRO.ID_Pro 
           LEFT JOIN Materijali MAT ON ENV.ID_Mat = MAT.ID_Mat 
       WHERE ENV.Datum BETWEEN '2017-06-20' AND '2017-06-20' AND BrojRN IN(SELECT NDV.BrojRN FROM NarudzbeDetaljnoView NDV WHERE NDV.ID_Par =121301 ) 
       ORDER BY ENV.Datum, ENV.Hala, ENV.Linija



-- Škart
select kupac,sum(kolicinaok) kolicinaok, sum(OtpadObrada) otpadobrada ,sum(OtpadMat) otpadmat,Turm
from evidnormi('2017-06-20','2017-06-20',0)
where gotovo=1 and kupac like '%Austria%' and obrada3>=0
group by kupac,turm
union all
select kupac,sum(kolicinaok) kolicinaok, sum(OtpadObrada) otpadobrada ,sum(OtpadMat) otpadmat,turm
from evidnormi('2017-06-20','2017-06-20',0)
where gotovo=1 and kupac not like '%Austria%' 
group by kupac,turm
--------------
select *
from evidnormi('2017-06-20','2017-06-20',0)
where gotovo=1 and kupac like '%FAG%' 




union all
-- ostali
select kupac,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat,sum(TekstCheck01) broj_stelanja
from evidnormi('2017-06-21','2017-06-21',0)
where gotovo=1 and  kupac not like '%Austria%' 
group by kupac




select *
from evidnormi('2017-06-21','2017-06-21',0)
where gotovo=1 and kupac like '%SONA%'


-- vlado gedrehte ringe 3
USE FeroApp
select sum(kolicinaok)
from (

SELECT Turm, ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, SUM(KolicinaOK) AS KolicinaOK, UkupnoKolicinaOK, NespecificiranaKolOK, 
      SUM(OtpadObrada) AS OtpadObrada, SUM(OtpadMat) AS OtpadMat, (SELECT NazivPar FROM Partneri WHERE ID_Par = (SELECT ID_Par FROM NarudzbeZag WHERE ID_NarZ = (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = EvidNormi.BrojRN))) AS Kupac ,
	  obrada3
      FROM EvidNormi('2017-06-21', '2017-06-21', 1) --WHERE Gotovo = 1  and obrada3=0
	  where kupac like '%Austria%' 
      GROUP BY Turm, obrada3,ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, UkupnoKolicinaOK, NespecificiranaKolOK,obradac 
	  --ORDER BY BrojRN
	  )x1
	  
	use fxapp
	  select *
	  from ldp_aktivnost  


select *
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%TECHNO%' AND OBRADAA=1

-- GEDREHTE RINGE 1, FAG
SELECT SUM(X1.SOK)
FROM (
SELECT NazivLinije, Linija, Turm, ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, Norma, SUM(KolicinaOK) SOK, UkupnoKolicinaOK, NespecificiranaKolOK, 
       SUM(OtpadObrada) OO, SUM(OtpadMat) OM, (SELECT NazivPar FROM Partneri WHERE ID_Par = (SELECT ID_Par FROM NarudzbeZag WHERE ID_NarZ = (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = EvidNormi.BrojRN))) AS Kupac 
       FROM EvidNormi('2017-06-20','2017-06-20', 1) 
       WHERE KUPAC LIKE '%fag%'
       GROUP BY NazivLinije, Linija, Turm, ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, Norma, UkupnoKolicinaOK, NespecificiranaKolOK 
	   --ORDER BY Linija
	   ) X1

	   SELECT NazivPar FROM Partneri WHERE ID_Par =247
	   SELECT * FROM Partneri WHERE NazivPar like '%FAG%'


	   select *
	   from evidnormi('2017-06-20','2017-06-20',0)
	   where kupac like '%technolog%' and gotovo=1 and VrstaNarudzbe like '%prsten%'



select *
from evidnormi('2017-06-20','2017-06-20',0)
where  kupac LIKE '%Romania%' AND OBRADAA=1
and TekstCheck01=1



group by kupac,VrstaNarudzbe
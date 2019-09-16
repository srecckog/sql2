
-- evidencija normi po proizvodu  14.10.2016
select distinct top 20 x1.Hala,x1.Linija,x1.Norma
from (
select top 100 es.BrojRN,es.Linija,es.Norma,ez.Hala,es.ID_ENZ
from narudzbesta n
left join Proizvodi p on p.ID_Pro=n.ID_Pro
left join EvidencijaNormiSta es on es.BrojRn=n.BrojRN1
left join EvidencijaNormizag ez on es.ID_ENZ=ez.ID_ENZ 
where p.NazivPro like '%F-805937.01-3005.IR.TR1-W220-W240F-HLA%'
and es.Norma>1
group by ez.hala,es.linija,es.brojrn,es.Norma,es.ID_ENZ 
order by es.ID_ENZ desc
) x1






select *
from NarudzbeSta n
where brojrn1='4037/2016'

left join EvidencijaNormiSta es on es.
where brojrn1= '4468/2016'
-- 10.10.2016


select id_narz,SUBSTRING(id_narz, CHARINDEX('/',id_narz) + 1, LEN(id_narz)),KolicinaNar,datumisporuke,BrojRN1
from narudzbesta ns


select id_narz,KolicinaNar,datumisporuke,BrojRN1
from narudzbesta ns
where id_narz in ( 17759652,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5174599,
5169241,
5169241,
5169241,
5169241
)



select n.*,p.*
from narudzbesta n
left join proizvodi p on n.ID_Pro=p.ID_Pro
where n.BrojRN='3546/2016'


select sum(norma),sum(kolicinaok)
from evidencijanormista
where brojrn='3523/2016'

select *
from evidencijanormista
where brojrn LIKE '4468/2016'


--select * --sum(norma),sum(kolicinaok)
--from evidencijanormizag
--where brojrn='3501/2016'

select sum(norma),sum(kolicinaok)
from evidnormi('2016-07-01','2016-10-31',0)
where brojrn='3795/2016'


select *
from evidnormi('2016-07-01','2016-10-31',0)
where nazivpro like '%IR.32311-B-0024%'


where brojrn='3795/2016'



	SELECT sum(s.kolicinaok),count(*)
	  FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z
	  left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ
	  where brojrn='4485/2016'

	SELECT  z.*,s.*
	  FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z
	  left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ
	  where brojrn='4506/2016'

	  
	SELECT max(s.datumunosa) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where brojrn='3302/2016'
	SELECT s.*,z.* FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where brojrn='3302/2016'


	  select *
	  from EvidencijaProizvodnjezag EP
	  left join narudzbesta ns on ep.

select *
from evidencijarn('Prsteni')


where brojrn='4485/2016'

select *
from NarudzbeDetaljnoView
where brojrn1='IK194/16'


select sum(kolicinaok) Ukol from evidencijanormista where brojrn='3525/2016'

select sum(s.KolicinaOK) as Ukol from evidencijaproizvodnjesta s left join evidencijaproizvodnjezag z on s.ID_EPZ=z.ID_EPZ where z.BrojRN='3516/2016'
select count(*) from evidencijaproizvodnjesta s left join evidencijaproizvodnjezag z on s.ID_EPZ=z.ID_EPZ where z.BrojRN='3516/2016'

select * from evidencijanormista where brojrn='4468/2016'
select * from evidencijaproizvodnjesta

SELECT s.KolicinaOK,s.OtpadMaterijal,s.OtpadObrada,z.BrojRN
FROM narudzbesta,[EvidencijaProizvodnjeZag] z 
left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ 
left join  narudzbesta n on n.BazniRN=z.BrojRN




USE FeroApp

SELECT TJ.*, 0 AS SpremnoTok 
	FROM TmpJanjic TJ
		LEFT JOIN NarudzbeZag NarZ ON TJ.OrderNo = NarZ.OrderNo 
	WHERE TJ.VrstaDok = 'DI'
UNION
SELECT TJ.*, 
	ISNULL((SELECT SUM(ISNULL(EPS.KolicinaOK, 0)) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN((SELECT NS1.BrojRN1 FROM NarudzbeSta NS1 WHERE NS1.ID_NarZ = NarZ.ID_NarZ AND NS1.Obrada1 = 1 AND NS1.Isporuceno = 0 AND ISNULL(NS1.BrojRN1, '') <> '' )))), 0) AS SpremnoTok 
	FROM TmpJanjic TJ
		LEFT JOIN NarudzbeZag NarZ ON TJ.OrderNo = NarZ.OrderNo 
	WHERE TJ.VrstaDok = 'Order'
UNION
SELECT TJ.*, 0 	
	FROM TmpJanjic TJ
		LEFT JOIN NarudzbeZag NarZ ON TJ.OrderNo = NarZ.OrderNo 
	WHERE TJ.VrstaDok IS NULL
	ORDER BY TJ.ID

select *
from evidencijaproizvodnjesta s 
left join evidencijaproizvodnjezag z on s.ID_EPZ=z.ID_EPZ 
where z.BrojRN='4095/2016' and status=0

select *
from evidencijaproizvodnjezag s 
where brojrn='4037/2016'



select x4.*,sum(kss.Kolicina) Ukupna_kolicina,
 (SELECT ISNULL(SUM(ISNULL(KolicinaOK, 0)), 0) AS Kolicina FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = x4.BrojRN)) AS Tokareno_sveukupno 
 --, sum(es.KolicinaOK) toakreno
from (

select x3.kratkinaziv,x3.TezinaProKom,sum(x3.Kolicina) as kolicina ,x3.brojrn, p.NazivPro,n.kolicinanar ,x3.smjena

from (
select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* 
from (
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  
FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag]
WHERE DATUM='2016-09-12' ) x1 
 left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ 
 ) x3 

 left join narudzbesta n on n.BrojRN=x3.brojrn
 left join proizvodi p on p.ID_Pro=n.ID_Pro 
 group by x3.kratkinaziv,x3.TezinaProKom,x3.brojrn,p.NazivPro,n.kolicinanar,x3.smjena  ) x4
 LEFT JOIN kalionicaknjigasmjenesta kss on kss.BrojRN=x4.BrojRN
 --LEFT join EvidencijaProizvodnjezag  ez on ez.BrojRN=x4.BrojRN
 --LEFT join EvidencijaProizvodnjesta  es on es.ID_EPz=ez.ID_EPZ --and es.Status=1
  group by x4.kratkinaziv,x4.TezinaProKom,x4.brojrn, x4.NazivPro,x4.kolicinanar,x4.kolicina,x4.smjena


select * from KalionicaKnjigaSmjenesta 
select * from KalionicaKnjigaSmjenezag --where BrojRN='3546/2016'
select * from narudzbesta where BrojRN='3546/2016'


select s.*,z.*
from kalionicaknjigasmjenezag z 
left join KalionicaKnjigaSmjeneSta s on s.ID_KKSZ=z.ID_KKSZ
where z.Datum='2016-09-13' and smjena=3

select n.*,p.*
from narudzbesta n
left join proizvodi p on n.ID_Pro=p.ID_Pro
where n.BrojRN='3546/2016'




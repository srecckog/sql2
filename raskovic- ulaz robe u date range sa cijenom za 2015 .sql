USE FeroApp
select x1.NazivMat,sum(kolicina) kolicina
from (
SELECT VrstaDokumenta, BrojDokumenta, DatumDokumenta, DatumUlaza, ID_Par, ID_SKL, ID_MAT, NazivMat, (CASE WHEN VrstaOtpisa = 'Komadno' THEN round(cast(cijenaKom as float),2) ELSE round(cast(CijenaKg as float),2) END) AS CijenaJM, jm,
CAST(KolicinaInventura AS float) AS Kolicina 
 FROM UlazRobeDetaljnoView 
 WHERE DatumUlaza BETWEEN '2016-01-01' AND '2016-12-31' AND ID_SKL IN(103,22,303) AND VrstaUR = 'UlazULR'
 ) x1
 group by  x1.NazivMat
 order by nazivmat
 
-- sve cijene u HRK
USE FeroApp
SELECT X1.VrstaDokumenta, X1.BrojDokumenta, X1.DatumDokumenta, x1.DatumUlaza, x1.ID_Par, x1.ID_SKL, x1.ID_MAT, x1.NazivMat, case when valuta='EUR' THEN round(x1.cIjenajM*TECAJVALUTE,2) ELSE x1.CIJENAJM END CijenamHRK -- , valuta,tecajvalute,jm
FROM (

SELECT VrstaDokumenta, BrojDokumenta, DatumDokumenta, DatumUlaza, ID_Par, ID_SKL, ID_MAT, NazivMat, (CASE WHEN VrstaOtpisa = 'Komadno' THEN round(cast(cijenaKom as float),2) ELSE round(cast(CijenaKg as float),2) END) AS CijenaJM, valuta,tecajvalute,jm,
CAST(KolicinaInventura AS float) AS Kolicina 
 FROM UlazRobeDetaljnoView 
 WHERE DatumUlaza BETWEEN '2016-01-01' AND '2016-12-31' AND ID_SKL IN(103,22,303) AND VrstaUR = 'UlazULR'
 and id_mat='276901'
order by nazivmat

 ) X1
 w
 order by NazivMat,id_mat



 
--USE FeroApp
--SELECT *
-- FROM UlazRobeDetaljnoView 
-- WHERE DatumUlaza BETWEEN '2016-01-01' AND '2016-12-31' AND ID_SKL IN(103,22,303) AND VrstaUR = 'UlazULR'
-- order by id_skl,NazivMat
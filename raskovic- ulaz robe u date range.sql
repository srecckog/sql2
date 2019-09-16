
 USE FeroApp

 SELECT VrstaDokumenta, BrojDokumenta, DatumDokumenta, DatumUlaza, ID_Par, ID_SKL, ID_MAT, NazivMat,
 CAST(KolicinaInventura AS float) AS Kolicina 
 FROM UlazRobeDetaljnoView 
WHERE DatumUlaza BETWEEN '2016-01-01' AND '2016-12-31' AND ID_SKL IN(130,22,303) AND VrstaUR = 'UlazULR'
-- WHERE DatumUlaza BETWEEN '2016-01-01' AND '2016-12-31' AND  VrstaUR = 'UlazULR'

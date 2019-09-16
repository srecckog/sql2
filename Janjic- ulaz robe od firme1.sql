
USE FeroApp

SELECT VrstaDokumenta, BrojDokumenta, DatumDokumenta, DatumUlaza, ID_MAT, NazivMat, CAST(KolicinaInventura AS Float) AS Kolicina, CAST(CijenaKom AS float) AS Cijena 
       FROM UlazRobeDetaljnoView 
       WHERE ID_Par = 221136 
       AND DatumUlaza >= '2016-01-01'

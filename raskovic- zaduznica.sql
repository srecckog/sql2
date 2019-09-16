USE FeroApp

SELECT VrstaDokumenta, BrojDokumenta, DatumIzlaza, ID_Mat, NazivMat, CAST(Kolicina AS float) AS Kolicina 
       FROM IzlazRobeDetaljnoView 
       WHERE VrstaDokumenta = 'Zadužnica' 
       AND DatumIzlaza BETWEEN '2016-09-01' AND '2016-09-30' 
       AND ID_Mat IN(275188,276706,276835,276904,276901,277141,276902,276819,276789,275713,276835,276875,276724,276929,276826,275190,275189)

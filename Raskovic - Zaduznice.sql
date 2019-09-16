USE FeroApp

SELECT ID_IZR, VrstaDokumenta, BrojDokumenta, DatumIzlaza, ID_Mat, NazivMat, CAST(Kolicina AS float) AS Kolicina 
       FROM IzlazRobeDetaljnoView 
       WHERE DatumIzlaza BETWEEN '2016-06-01' AND '2016-06-30' 
       AND VrstaDokumenta = 'Zadužnica' 
       ORDER BY DatumIzlaza, BrojDokumenta



	   
SELECT ID_IZR, VrstaDokumenta, BrojDokumenta, DatumIzlaza, ID_Mat, NazivMat, CAST(Kolicina AS float) AS Kolicina 
       FROM IzlazRobeDetaljnoView 
       WHERE DatumIzlaza BETWEEN '2016-10-01' AND '2016-10-31' 
       AND VrstaDokumenta = 'Zadužnica' 
	   and id_mat in (
	   275188,
276706	,
276835	,
 276904 ,
276901  ,
 277141 ,
 276902 ,
 276819 ,
 276789 ,
 275713 ,
276835  ,
 276875 ,
276724	,
276929	,
276826	,
275190	,
276893  ,
275339  ,
277416  ,
275376  ,
275189	)


       ORDER BY DatumIzlaza, BrojDokumenta
SELECT ID_FS, VrstaFakture, BrojFakture, DatumFakture, RedniBroj, ID_Mat, CAST(KolicinaMat AS float) AS KolicinaMat, CAST(CijenaMatKom AS float) AS CijenaMat, ID_Pro, CAST(KolicinaPro AS float) AS KolicinaPro, CAST(CijenaProKom AS float) AS CijenaPro
FROM FaktureDetaljnoView
WHERE ID_Ulp IN(

SELECT ID_Ulp 
FROM UlazProizvoda 
WHERE ID_IZR IN(SELECT ID_Izr 
FROM IzlazRobe 
WHERE ID_ULR = 53373)
)


select *
from IzlazRobe

SELECT *
FROM UlazProizvoda 
WHERE ID_IZR IN(SELECT ID_Izr 
FROM IzlazRobe 
WHERE ID_ULR = 53373)

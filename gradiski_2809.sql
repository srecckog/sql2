use feroapp
DECLARE @Od date
DECLARE @Do date
SET DATEFORMAT dmy 
SET @Od='1.9.2017'
SET @Do='27.9.2017'

select x1.*,fakt-kupactrazi  razlika
from (
SELECT NS.BrojRN ,
      CAST(SUM(NS.KolicinaNar) AS float) AS KupacTrazi,
      CAST(ISNULL((SELECT SUM(ISNULL(FS.KolicinaPro, 0)) FROM FaktureSta FS WHERE FS.BrojRN = NS.BrojRN),0) AS FLOAT) AS FAKT,
      MAX(ns.DatumIsporuke) as DatumIsporuke
FROM NarudzbeSta NS
      LEFT JOIN NarudzbeZag NZ ON NS.ID_NarZ = NZ.ID_NarZ
WHERE NS.DatumIsporuke BETWEEN @Od AND @Do
      AND NZ.ID_Par = '121273'
GROUP BY NS.BrojRN, NS.DatumIsporuke
) x1
where (fakt-kupactrazi)<0
ORDER BY x1.DatumIsporuke

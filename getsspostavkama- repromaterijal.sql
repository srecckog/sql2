-- localhost, Stanje skladista , repromaterijal, po stavkama  getsspostavkama.asp
select sum(x1.vrijednost)
from (

SELECT (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) AS Grupacija, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR_Kn.ID_MAT) AS Naziv,
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Loan' END) AS Vlasnistvo, DatumUlaza, CAST(SUM(SaldoKolicina) AS Float) AS Kolicina,
JM, CAST(SUM(Vrijednost) AS Float) AS Vrijednost, BrojMaterijala, VrstaMat, VrstaOtpisa, VrstaIzracuna, TarifniBroj, KolicinaInventura, BrojSarze, Proizvodjac,
BrojPrimke, VrstaDokumenta, BrojDokumenta, DatumDokumenta, JCD, DatumJCD, (SELECT NazivPar FROM Partneri WHERE ID_Par = StanjeULR_Kn.ID_Par) AS Partneri,
VrstaPakiranja, SUM(SaldoPakiranja) AS BrojPakiranja, ID_SKL, BrojPolja, Valuta, TecajValute, KolicinaDokument

FROM StanjeULR_Kn('2016-05-29')

WHERE VrstaUR <> 'Povrat'
AND SaldoKolicina <> 0
AND Neaktivno = 0
AND Neaktivno = 0
and vrstamat='Repromaterijal'
GROUP BY DatumUlaza, ID_MAT, CijenaKom, VlasnistvoFX, VrstaOtpisa, CijenaKg, JM, BrojMaterijala, VrstaMat, VrstaIzracuna, TarifniBroj, KolicinaInventura,
BrojSarze , Proizvodjac, BrojPrimke, VrstaDokumenta, BrojDokumenta, DatumDokumenta, JCD, DatumJCD, ID_Par, VrstaPakiranja, ID_SKL, BrojPolja,
Valuta, TecajValute, KolicinaDokument
ORDER BY CASE WHEN (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) IS NULL THEN 'ZZZZZ' ELSE (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) END, Naziv, DatumUlaza
)x1
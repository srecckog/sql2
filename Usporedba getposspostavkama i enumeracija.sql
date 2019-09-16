--- localhost, repromaterijal, po stavkama

select x1.grupacija,x1.vlasnistvo,sum(x1.kolicina)
from(

SELECT (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) AS Grupacija, ID_MAT, 
(SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR_Kn.ID_MAT) AS Naziv,
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Loan' END) AS Vlasnistvo, 
DatumUlaza, 
CAST(SUM(SaldoKolicina) AS Float) AS Kolicina,
JM, 
CAST(SUM(Vrijednost) AS Float) AS Vrijednost,
 BrojMaterijala,
  VrstaMat,
   VrstaOtpisa,
    VrstaIzracuna,
	 TarifniBroj, 
	 KolicinaInventura, 
	 BrojSarze,
	  Proizvodjac,
BrojPrimke,
 VrstaDokumenta,
  BrojDokumenta,
   DatumDokumenta, 
   JCD,
    DatumJCD,
	 (SELECT NazivPar FROM Partneri WHERE ID_Par = StanjeULR_Kn.ID_Par) AS Partneri,
VrstaPakiranja,
 SUM(SaldoPakiranja) AS BrojPakiranja, 
 ID_SKL,
  BrojPolja,
   Valuta,
    TecajValute, 
	KolicinaDokument

FROM StanjeULR_Kn('2016-05-29')

WHERE VrstaUR <> 'Povrat'
AND SaldoKolicina <> 0
AND Neaktivno = 0
--and grupacija=NUll
and vrstamat='Repromaterijal'
GROUP BY DatumUlaza, ID_MAT, CijenaKom, VlasnistvoFX, VrstaOtpisa, CijenaKg, JM, BrojMaterijala, VrstaMat, VrstaIzracuna, TarifniBroj, KolicinaInventura,
BrojSarze , Proizvodjac, BrojPrimke, VrstaDokumenta, BrojDokumenta, DatumDokumenta, JCD, DatumJCD, ID_Par, VrstaPakiranja, ID_SKL, BrojPolja,
Valuta, TecajValute, KolicinaDokument
--ORDER BY CASE WHEN (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) IS NULL THEN 'ZZZZZ' ELSE (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) END, Naziv, DatumUlaza

) x1
--where x1.grupacijnull
group by x1.Grupacija ,x1.vlasnistvo
order by x1.grupacija



--- ldp enumeracija , skladiste.xlsm

select sum(x2.saldo)
from (

SELECT 
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, 
VrstaOtpisa, 
id_mat,
(SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR.ID_MAT) AS Naziv, 
SUM(CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) AS Saldo, 
VrstaMat 
                                    FROM StanjeULR('2016-05-29') 
                                    WHERE (CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) <> 0 AND VrstaUR <> 'Povrat' 
									and VrstaMat ='Repromaterijal'
                                    AND Neaktivno = 0 
                                    GROUP BY VlasnistvoFX, Id_mat,VrstaOtpisa ,VrstaMat

									) x2


-- popis skladista sa nazivom grupacija  
select id_skl,nazivskladista,opisskladista,konto,vrsta,grupacija
from skladista
order by grupacija

------------------
-- Stanje repromaterijala po grupacijama    localhost\skladiste\kumulativ\repromaterijal
  SELECT 
  Grupacija,
  SUM((CASE WHEN VlasnistvoFX = 1  and VrstaOtpisa='Komadno' THEN SaldoKolicina ELSE 0 END)) AS KolicinaFX,
  SUM((CASE WHEN VlasnistvoFX = 1  and VrstaOtpisa='Tezinski' THEN SaldoTezina ELSE 0 END)) AS TezinaFX, 
  SUM((CASE WHEN VlasnistvoFX = 0  and VrstaOtpisa='Komadno' THEN SaldoKolicina ELSE 0 END)) AS KolicinaLoan,
  SUM((CASE WHEN VlasnistvoFX = 0  and VrstaOtpisa='Tezinski' THEN SaldoTezina ELSE 0 END)) AS TezinaLoan,
  SUM((CASE WHEN VlasnistvoFX = 1 THEN Vrijednost ELSE 0 END)) AS KnFX,
  SUM((CASE WHEN VlasnistvoFX = 0 THEN Vrijednost ELSE 0 END)) AS KnLoan
  FROM StanjeULR_Kn_Grupacije('2016-05-29')
  WHERE VrstaUR <> 'Povrat' AND SaldoKolicina <> 0
  AND Neaktivno = 0
  GROUP BY Grupacija 
  ORDER BY Grupacija
  ------------------

  ----------------------------------------------------------------------------------
  -----------------version 2  localhost, repromaterijal, po stavkama  --------------

select s.NazivSkladista, x1.grupacija, x1.vlasnistvo, x1.vrstamat, sum(x1.kolicina), sum(x1.vrijednost)
from(

SELECT (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) AS Grupacija, ID_MAT, 
(SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR_Kn.ID_MAT) AS Naziv,
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Loan' END) AS Vlasnistvo, 
DatumUlaza, 
CAST(SUM(SaldoKolicina) AS Float) AS Kolicina,
JM, 
CAST(SUM(Vrijednost) AS Float) AS Vrijednost,
 BrojMaterijala,
  VrstaMat,
   VrstaOtpisa,
    VrstaIzracuna,
	 TarifniBroj, 
	 KolicinaInventura, 
	 BrojSarze,
	  Proizvodjac,
BrojPrimke,
 VrstaDokumenta,
  BrojDokumenta,
   DatumDokumenta, 
   JCD,
    DatumJCD,
	 (SELECT NazivPar FROM Partneri WHERE ID_Par = StanjeULR_Kn.ID_Par) AS Partneri,
VrstaPakiranja,
 SUM(SaldoPakiranja) AS BrojPakiranja, 
 ID_SKL,
  BrojPolja,
   Valuta,
    TecajValute, 
	KolicinaDokument

FROM StanjeULR_Kn('2016-05-29')

WHERE VrstaUR <> 'Povrat'
AND SaldoKolicina <> 0
AND Neaktivno = 0
--and grupacija=NUll
--vrstamat='Repromaterijal'
GROUP BY DatumUlaza, ID_MAT, CijenaKom, VlasnistvoFX, VrstaOtpisa, CijenaKg, JM, BrojMaterijala, VrstaMat, VrstaIzracuna, TarifniBroj, KolicinaInventura,
BrojSarze , Proizvodjac, BrojPrimke, VrstaDokumenta, BrojDokumenta, DatumDokumenta, JCD, DatumJCD, ID_Par, VrstaPakiranja, ID_SKL, BrojPolja,
Valuta, TecajValute, KolicinaDokument
--ORDER BY CASE WHEN (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) IS NULL THEN 'ZZZZZ' ELSE (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULR_Kn.ID_SKL) END, Naziv, DatumUlaza

) x1
left join skladista s on s.id_skl=x1.ID_SKL 
--where x1.grupacijnull
group by x1.Grupacija ,x1.vlasnistvo,s.NazivSkladista ,x1.vrstamat
order by x1.grupacija,NazivSkladista



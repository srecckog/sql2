USE FeroApp

SELECT Turm, ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, SUM(KolicinaOK) AS KolicinaOK, UkupnoKolicinaOK, NespecificiranaKolOK, 
      SUM(OtpadObrada) AS OtpadObrade, SUM(OtpadMat) AS OtpadMat, 
	  (SELECT NazivPar FROM Partneri WHERE ID_Par = (SELECT ID_Par FROM NarudzbeZag WHERE ID_NarZ = (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = EvidNormi.BrojRN))) AS Kupac, FakturnaOznakaObrade, Cijevasti 
      FROM EvidNormi('2018-09-07', '2018-09-07', 1) WHERE Gotovo = 1 
      GROUP BY Turm, ID_Pro, LoanPosao, BrojRN, DatumIsporuke, NazivPro, NazivMat, KolicinaNar, OrderNo, UkupnoKolicinaOK, NespecificiranaKolOK, FakturnaOznakaObrade, Cijevasti ORDER BY BrojRN

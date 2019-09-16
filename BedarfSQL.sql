USE FeroApp;

WITH MyTmpTable AS(
SELECT BrojRN, DatumIsporuke, ISNULL((SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = NarudzbeSta.BrojRN), 0) AS ID_ENZ, 
       (SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NarudzbeSta.BrojRN)) AS Potokareno, 
	   (SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NarudzbeSta.BrojRN) AND EPS.Status = 0) AS PotokarenoSpremno, 
       (SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NarudzbeSta.BrojRN2)) AS Zakaljeno, 
       (SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NarudzbeSta.BrojRN3)) AS TvrdoTok 
       FROM NarudzbeSta 
       WHERE ID_NarZ = (SELECT NarudzbeZag.ID_NarZ FROM NarudzbeZag WHERE NarudzbeZag.OrderNo = 18448447
) 
       AND Obrada1 = 1 
       AND Aktivno = 1 
       AND BazniRN = 1)

SELECT TOP 1 * FROM MyTmpTable WHERE ID_ENZ <> 0 ORDER BY DatumIsporuke DESC


select *
from Materijali
where nazivmat like '%Z-581079.12-3105.IR.TR2-W220%'

select *
from proizvodi
where NazivPro like  '%Z-581079.12-3105.IR.TR2-W220%'
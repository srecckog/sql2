
Use FeroApp

SET DATEFORMAT dmy
SELECT
      SU.BrojRN,
      SU.NazivPro,
	  su.Grupacija,
      FORMAT(SUM(SU.SaldoKolPro), '#0') AS KolicinaPro
FROM StanjeULP_Kn_Grupacije('25.03.2019',0) SU
WHERE SaldoKolPro <> 0
      AND Neaktivno = 0
      AND Grupacija='INA KYSUCE - KUÆIŠTA'
      GROUP BY SU.BrojRN,SU.NazivPro,su.Grupacija
      ORDER BY SU.BrojRN

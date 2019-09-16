USE FeroApp

SELECT PN.* 
	FROM ProizvodneNorme PN
		LEFT JOIN NarudzbeSta NS ON '13/5389' = NS.BrojRN 
		LEFT JOIN Proizvodi PRO ON NS.ID_Pro = PRO.ID_Pro 
	WHERE PN.Hala = '1' 
		AND PN.Linija = 'HURCO' 
		AND PN.ID_PRO = NS.ID_Pro 
		AND (CASE WHEN (PRO.ObradaA = 1 AND PN.ObradaA = 1) THEN PN.ObradaA WHEN (PRO.ObradaB = 1 AND PN.ObradaB = 1) THEN PN.ObradaB WHEN (PRO.ObradaC = 1 AND PN.ObradaC = 1) THEN PN.ObradaA ELSE PN.ObradaA END) = 1
		AND PN.ID_Mat = NS.ID_Mat 
	ORDER BY PN.Norma DESC

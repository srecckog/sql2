select s.*
from Narudzbezag z
left join NarudzbeSta s on z.id_narz = s.id_narz
where brojrn1='1413/2018'


      SELECT NarZ.ID_Par, ENS.linija, ENZ.Datum, (CASE PRO.ZavrsnaPoprObrada WHEN PRO.VrstaObradeB THEN ENS.ObradaB WHEN PRO.VrstaObradeC THEN ENS.ObradaC WHEN PRO.VrstaObradeD THEN ENS.ObradaD WHEN PRO.VrstaObradeE THEN ENS.ObradaE WHEN PRO.VrstaObradeF THEN ENS.ObradaF WHEN PRO.VrstaObradeG THEN ENS.ObradaG WHEN PRO.VrstaObradeH THEN ENS.ObradaH WHEN PRO.VrstaObradeI THEN ENS.ObradaI ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
        PRO.ID_Pro, PRO.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN
        FROM EvidencijaNormiSta ENS 
            INNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
            INNER JOIN NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
            INNER JOIN NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
            INNER JOIN Proizvodi PRO ON NarS.ID_Pro = PRO.ID_Pro 
        WHERE ENZ.Datum BETWEEN '2018-03-28' AND '2018-03-28'
            AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1 and enz.smjena=1


select ens.*
from EvidencijaNormiSta ENS 
iNNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
where linija like '%09-M%'

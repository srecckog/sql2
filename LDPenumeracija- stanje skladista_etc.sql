
-- ovo se koristi u \\voditelj pogona\skladiste.xlsm    - sirovci FX01  , repromaterijal 
SELECT (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, VrstaOtpisa,  
                                        SUM(CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) AS Saldo, VrstaMat 
                                    FROM StanjeULR('2016-05-29') 
                                    WHERE (CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) <> 0 AND VrstaUR <> 'Povrat' 
									and VrstaMat ='repromaterijal'
                                    AND Neaktivno = 0 
                                    GROUP BY VlasnistvoFX, VrstaOtpisa , VrstaMat
use feroapp
SELECT 
(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, VrstaOtpisa,  
                                    SUM(CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) AS Saldo, VrstaMat 
                                    FROM StanjeULR(CONVERT(datetime, '" + day.ToString("dd.MM.yyyy") + "', 104)) 
                                    WHERE (CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) <> 0 AND VrstaUR <> 'Povrat' 
                                    AND Neaktivno = 0 
                                    GROUP BY VlasnistvoFX, VrstaOtpisa , VrstaMat
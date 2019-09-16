USE FeroApp

SELECT * FROM StanjeULR('2017-07-27') WHERE ID_SKL = 118 AND VrstaUR <> 'Povrat' AND (CASE WHEN VrstaOtpisa = 'Tezinski' THEN SaldoTezina ELSE SaldoKolicina END) <> 0

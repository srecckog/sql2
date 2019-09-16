insert into repromaterijal (id_skl, nazivskladista, kolicina,tezina,vrijednost,datum) 

SELECT x1.id_skl  ,x1.nazivskladista,cast( sum(saldokolicina) as decimal (10,2)) kolicina,cast( sum(saldotezina) as decimal (10,2))  tezina,cast(x2.vrijednost as decimal(10,2)) vrijednost, getdate() datum
from (

SELECT  st.id_skl, s1.nazivskladista,case when jm='mm' then  saldokolicina/1000 else saldokolicina end saldokolicina,saldotezina
FROM feroapp.dbo.StanjeULR(getdate()) st
left join feroapp.dbo.skladista s1 on s1.id_skl=st.id_skl
WHERE VrstaUR <> 'Povrat' AND (CASE WHEN VrstaOtpisa = 'Tezinski' THEN SaldoTezina ELSE SaldoKolicina END) <> 0
and st.id_skl in ( 334,	371,	350,	327,	358,	300,308,	390,361,	394,	392,	252,	153,	155,	118,	39)


) x1

left join (

SELECT x1.id_skl,cast( sum(x1.vrijednost/x1.tecaj) as decimal(18,2)) vrijednost 
from ( select id_skl,vrijednost,(select tecajeur from feroapp.dbo.tecajnalista where dantecaja=(select max(dantecaja) from feroapp.dbo.tecajnalista )) as tecaj
       FROM feroapp.dbo.StanjeULR_Kn(getdate()) SULR 	   
       WHERE SULR.ID_SKL IN(334, 371, 350, 327, 358, 300, 308, 390, 361, 394, 392, 252, 153, 155, 118, 39) 
             AND (CASE WHEN SULR.VrstaOtpisa = 'Tezinski' THEN SULR.SaldoTezina ELSE SULR.SaldoKolicina END) <> 0
		)x1
		group by x1.id_skl
) x2 on x2.id_skl=x1.id_skl
group by x1.id_skl,x2.vrijednost,nazivskladista




ID radnika - thr_prsn (acRegno)
Ime i prezime - thr_prsn (acName i acSurname)
Radno mjesto - acJob iz thr_PrsnJobEval 
Datum zaposlenja - thr_prsn (acDateEnter)
Staž u FX i TB ukupno - ne postoji mjesto gdje je zapisan ovaj podatak i izračunava se svaki puta kada je potreban. Računa se na temelju adDate iz thr_prsnjob do danas.
Satnica neto u kn - thr_prsnjob - ali nema kronologije
Satna osnova   ->  anWrk23 
Satna Osn.NED -> anWrk24        
Satna Osn.VN-> anWrk25           
Satna Osn.BLAGD -> anWrk26    
Satna Osn.BN  -> anWrk27    
Isteg ugovora - adEmployedTo iz thr_PrsnJob
Mjesto troška - thr_prsnjob (acdept ili acCostDrv)
 
Bolovanje, stimulacija i destimulacija se nalaze u prometnim tablicama obzirom da se mijenjaju iz mjeseca u mjesec. Tablica u kojoj se nalazi obračunata plaća je tHR_SlryCalcSum (dodaci na plaću su anExtras a odbici su anDeduction) i thr_SlryCalcET (obračunata plaća po svakoj pojedinoj vrst zarade (acET) analitički). Vrste zarade (bolovanje, stimulacije, destimulacije i sl.) zapisane su u thr_SetSlryET.
 

select *
from thr_prsnjob
where acworker like '%posavac%'
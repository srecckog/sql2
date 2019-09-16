select p.acregno ID,p.acworker PrezimeIme,p.addatebirth DatumRoðenja,j.acCostDrv MT,j.adEmployedTo OdredenoDo 
from tHR_Prsn p 
left join thr_prsnjob j on p.acworker = j.acworker 
where j.acemploymenttype like '%- odre%' 
and p.addateexit is null 
and ( (j.adEmployedTo>='2017-09-01' and j.adEmployedTo<='2017-09-30' ) )
and j.adDateEnd is null
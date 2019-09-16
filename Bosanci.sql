select cast(acregno as int) as id, acname, acsurname, j.acCostDrv, j.acDept, d.acnumber, j.acjob, '' radni_staz, j.adDate, '' sifra_rm, p.acstreet, acpost, '' vrijeme, accity, j.acFieldSA vrsta_isplate, adDateExit 
from thr_prsn p 
left join thr_prsnjob j on p.acworker = j.acworker 
left join thr_prsnadddoc d on d.acWorker = p.acworker and d.actype = 8 where d.actype=8 and p.acregno= 900005 
order by cast(acregno as int) desc


select *
from thr_prsnadddoc


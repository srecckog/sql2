use [PantheonFxAt]
select cast( acregno as int ) as id,acname,acsurname,j.acCostDrv,j.acDept,d.acnumber,j.acjob,'' radni_staz,p.adDateEnter,'' sifra_rm,p.acstreet,acpost,'' vrijeme,accity,j.acFieldSA vrsta_isplate,adDateExit
from thr_prsn p
left join thr_prsnjob j on p.acworker=j.acworker
left join thr_prsnadddoc d on d.acWorker=p.acworker and d.actype=8
order by cast( acregno as int ) desc
--order by j.acfieldsa



select *
from thr_prsnjob
where acworker like '%1487%' or acworker like '%1023%' 


select cast(acregno as int ) as id,acname,acsurname,j.acCostDrv,j.acDept,d.acnumber,j.acjob,'' radni_staz,p.adDateEnter,'' sifra_rm,p.acstreet,acpost,'' vrijeme,accity,j.acFieldSA vrsta_isplate, adDateExit from thr_prsn p left join thr_prsnjob j on p.acworker = j.acworker left join thr_prsnadddoc d on d.acWorker = p.acworker and d.actype = 8 order by cast(acregno as int) desc 


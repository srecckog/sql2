-- provjera mjesta troška
use [PantheonFxAt]
select p.*,p.acworker,j.acdept,j.accostdrv
from thr_prsn p
left join tHR_Prsnjob j on j.acworker=p.acworker
where accostdrv='' and p.addateexit is null

use [PantheonTKB]
select p.acworker,j.acdept,j.accostdrv
from thr_prsn p
left join tHR_Prsnjob j on j.acworker=p.acworker
where accostdrv='' and p.addateexit is null


  select acworker,count(*)
  from back_thrprsnadddoc
  where actype=8 
  group by acworker
  having count(*)>1
 


 delete from thr_prsnadddoc where acworker in (
  
  select 
  from thr_prsnadddoc
  where acworker in (
 
 select acworker
 from (
  select acworker,count(*) broj
  from thr_prsnadddoc
  where actype=8 
  group by acworker
  having count(*)>1
 ) x1
 
  ) 
  and anid=2
    )
  and anid=2



  insert into thr_prsnadddoc
  (
  [acWorker]
      ,[anId]
      ,[acType]
      ,[acActive]
      ,[acNumber]
      ,[acSerialNo]
      ,[acIssuer]
      ,[acCityIssue]
      ,[adDateIssue]
      ,[adDateValid]
      ,[acCategory]
      ,[acNote]
      ,[anUserIns]
      ,[anUserChg]
      ,[acInsuredNo]
       )

	   select 
	   [acWorker]
      ,[anId]
      ,[acType]
      ,[acActive]
      ,[acNumber]
      ,[acSerialNo]
      ,[acIssuer]
      ,[acCityIssue]
      ,[adDateIssue]
      ,[adDateValid]
      ,[acCategory]
      ,[acNote]
      ,[anUserIns]
      ,[anUserChg]
      ,[acInsuredNo]
  
  from back_thrprsnadddoc
  where acworker in (
 
 select acworker
 from (

  select acworker,count(*) broj
  from back_thrprsnadddoc
  where actype=8 
  group by acworker
  having count(*)>1
 ) x1
 
  ) 
  and anid=1
    
  


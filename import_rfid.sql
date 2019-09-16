select *
from thr_prsnadddoc
where actype=8
order by anqid


insert into adddco (acworker,acnumber,anid,actype,acactive,anuserins,anuserchg,adtimeins,adtimechg,acnumber)

from(


select prezimex+' '+imex+' ('+radnikid+')' as acworker,rfid acnumber, 2 anid,8 actype,'T' acactive,1 anuserins,1 anuserchg,getdate() adtimeins,getdate() adtimechg
from kartice_fx
where len(rfid)>0
and radnikid not in ( 1475,393,1476)

--and len(rfid)>14

)



select x1.*
from (
select prezimex+' '+imex+' ('+radnikid+')' as acworker,rfid acnumber, 2 anid,8 actype,'T' acactive,1 anuserins,1 anuserchg,getdate() adtimeins,getdate() adtimechg
from kartice_fx
where len(rfid)>0
and radnikid not in ( 1475,393,1476)
) x1
where x1.acworker
not in 
(
select acworker
from thr_prsnadddoc
)

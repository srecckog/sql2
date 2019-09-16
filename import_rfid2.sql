select *
from thr_prsnadddoc
where actype=8
order by anqid


insert into thr_adddoc (acworker,acnumber,anid,actype,acactive,anuserins,anuserchg,adtimeins,adtimechg,acnumber)
from(
select prezimex+' '+imex+' ('+radnikid+')' as acworker,rfid acnumber, 2 anid,8 actype,'T' acactive,1 anuserins,1 anuserchg,getdate() adtimeins,getdate() adtimechg
from kartice_fx
where len(rfid)>0
and radnikid not in ( 1475,393,1476)
--and len(rfid)>14
)


insert into thr_prsnadddoc (acworker,acnumber,anid,actype,acactive,anuserins,anuserchg,adtimeins,adtimechg)
select x1.*
from (
select prezimex+' '+imex+' ('+radnikid+')' as acworker,rfid acnumber, 2 anid,8 actype,'T' acactive,1 anuserins,1 anuserchg,getdate() adtimeins,getdate() adtimechg
from radnici_tkb
where len(rfid)>0
and radnikid not in ( 61,62,63)
) x1
where x1.acworker
not in 
(
select acworker
from thr_prsnadddoc
)





insert into thr_prsnadddoc (acworker,acnumber,anid,actype,acactive,anuserins,anuserchg,adtimeins,adtimechg)


select x1.*
from (
select prezimex+' '+imex+' ('+radnikid+')' as acworker,rfid acnumber, 2 anid,8 actype,'T' acactive,1 anuserins,1 anuserchg,getdate() adtimeins,getdate() adtimechg
from radnici_tkb
where len(rfid)>0
and radnikid not in (64 )
) x1
where x1.acworker
not in 
(
select acworker
from thr_prsnadddoc
where actype=8
--order by acworker
)
and x1.acworker in
(
select acworker
from thr_prsn
--where acregno=990
)



update thr_prsnadddoc set acnumber='0'+acnumber where len(acnumber)=11 and actype=8


select *
from thr_prsn
where acregno=990


select *
from thr_prsnadddoc
where acworker like '%1472%'
and acworker in 
(
select acworker
from thr_prsn
where acworker like '%1472%'
)




select *
from thr_prsnadddoc
order by acworker
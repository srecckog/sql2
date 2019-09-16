select acworker,acnoten,acregno
from thr_prsn
where acregno=1173

--update thr_prsn set acnoten='123456789012345' where acregno=1173


update thr_prsn set acnoten=j.rfid
from
(
select radnikid,rfid
from kartice
--from kartice_tb
) j
inner join thr_prsn p on p.acregno=j.radnikid

update thr_prsn set acnoten='' where acregno=1469
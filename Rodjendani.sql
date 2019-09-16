select *
from thr_prsn
where day(addatebirth)>=day(getdate()) and month(addatebirth)=month(getdate())
and acactive='T'
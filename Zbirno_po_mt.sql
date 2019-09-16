use [PantheonFxAt]
select count(*) broj_djelatnika,accostdrv
from thr_prsnjob
where addateend is null
group by accostdrv


select acworker,accostdrv
from thr_prsnjob
where addateend is null
and accostdrv=700
order by accostdrv,acworker


use rfind
select *
from kompetencije

-- 716 šteleri

use [192.168.0.5].[rfind]
select *
from MJESTOTROSKA


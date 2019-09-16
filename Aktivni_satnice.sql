Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
use rfind
select x1.* ,b.neto Neto_satnica
from (
select 'AT' Poduzece,acWorker ime,ACDEPT lokacija,ACCOSTDRV mt,acFieldSA vrstaisplate,cast(anWrk23 as decimal(12,3)) Bruto_satnica
from [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob
wheRE ACFIELDSA='S'
AND adDateEnd IS NULL
union all
select 'TKB' Poduzece,acWorker ime,ACDEPT lokacija,ACCOSTDRV mt,acFieldSA vrstaisplate,cast(anWrk23 as decimal(12,3)) satnica
from [192.168.0.6].PantheonTKB.dbo.thr_prsnjob
wheRE ACFIELDSA='S'
AND adDateEnd IS NULL
) x1
left join rfind.dbo.brutonetosatnice b on x1.bruto_satnica=b.bruto


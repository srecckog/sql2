--Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.5",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
Exec sp_helpserver

use [PantheonFxAt]
select *
from thr_prsn
where addateexit is not null
and acregno not in (

select id_fink
from [fxserver].[feroapp].dbo.radnici
where neradi=1
and id_firme=1
)




select *
from [fxserver].[feroapp].dbo.radnici
where id_fink =1386




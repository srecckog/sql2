Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";

select rtrim('AT'+acregno) as id1,p.acworker ime,j.adDate datumzaposlenja,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,j.addateend datumodlaska,'AT' poduzece
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where ( j.adDateEnd is null  or datediff(d,j.addateend,getdate())<60) and rtrim(p.acregno) not  in ('','0000')
union all
select rtrim('TKB'+acregno) as id1,p2.acworker ime,j2.adDate datumzaposlenja,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,j2.addateend datumodlaska,'TKB' poduzece
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where ( j2.adDateEnd is null  or datediff(d,j2.addateend,getdate())<60) and rtrim(p2.acregno) not  in ('','0000')
order by id1
Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
declare @dat1 date='2019-03-01' -- datum odlaska

select *
from (
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'AT' poduzece,j.acfieldsa
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where (j.adDateEnd is null or j.addateend>@dat1) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'TKB' poduzece,j2.acfieldsa
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where (j2.adDateEnd is null or j2.addateend>@dat1) and rtrim(p2.acregno) not  in ('','0000')
)y1
--where addateend is not null
order by id


-- provjera mjesta troška
select p.*
from radnici_ r
left join 
(
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,j.acfieldsa VrstaIsplate,'FX' poduzece
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where j.adDateEnd is null and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,j2.acfieldsa VrstaIsplate,'TKB' poduzece
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where j2.adDateEnd is null and rtrim(p2.acregno) not  in ('','0000')

) p on r.id=p.id


where r.neradi=0 and r.mt!=p.mt


--use [PantheonTKB]
--select *
--from dbo.thr_prsnjob p2


select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,j.acfieldsa,'FX' poduzece
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker


select *
from [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob

-- order by odjel
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'AT' poduzece
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
where j.adDateEnd is null and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'TKB' poduzece
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
where j2.adDateEnd is null and rtrim(p2.acregno) not  in ('','0000')
order by j.acdept,p.acworker

----------------
-- RFID KARTICE
-----------------
Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
declare @dat1 date='2011-03-01' -- datum odlaska

select *
from (
select acregno id,p.acworker ime,j.adDate datumzaposlenja,j.addateend,j.acCostDrv MT,j.acdept lokacija,j.acjob RadnoMjesto,'AT' poduzece,d.acactive,d.acnumber,d.adtimeins,d.adtimechg
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn p
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j on p.acworker=j.acworker
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsnadddoc d on d.acworker=P.acworker and d.actype=8
where (j.adDateEnd is null ) and rtrim(p.acregno) not  in ('','0000')
union all
select acregno id,p2.acworker ime,j2.adDate datumzaposlenja,j2.addateend,j2.acCostDrv mt,j2.acdept loakcija,j2.acjob RadnoMjesto,'TKB' poduzece,d.acactive,d.acnumber,d.adtimeins,d.adtimechg
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p2
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j2 on p2.acworker=j2.acworker
left join [192.168.0.6].PantheonTKB.dbo.thr_prsnadddoc d on p2.acworker=d.acworker and d.actype=8
where (j2.adDateEnd is null ) and rtrim(p2.acregno) not  in ('','0000')
)y1
--where addateend is not null
order by id


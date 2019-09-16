use [PantheonFxAt]
select p.acWorker,p.adDateEnter datum_zaposljavanja,e.accostdrv,e.acjob
from thr_prsn p
left join thr_prsnjob e on e.acworker=p.acworker
where addateenter>='2016-07-26' and addateexit is null
union all
select p.acWorker,p.adDateEnter datum_zaposljavanja,e.accostdrv,e.acjob
from [PantheonTKB].dbo.thr_prsn p
left join thr_prsnjob e on e.acworker=p.acworker
where addateenter>='2016-07-26' and addateexit is null
and e.accostdrv in ( 700,702)
order by acworker





select *
from thr_prsnjob

-- trenutno zaposleno
select count(*)
from (
select * into []
select p.acWorker,p.adDateEnter datum_zaposljavanja,e.accostdrv,e.acjob,'FX' Poduzece
from [PantheonFxAt].dbo.thr_prsn p
left join [PantheonFxAt].dbo.thr_prsnjob e on e.acworker=p.acworker
where  addateexit is null and charindex('(',p.acworker)>0
union all
select p.acWorker,p.adDateEnter datum_zaposljavanja,e.accostdrv,e.acjob,'TB' Poduzece
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob e on e.acworker=p.acworker
where  addateexit is null and charindex('(',p.acworker)>0
order by acworker

) x1

order by acworker



select *
from [PantheonFxAt].dbo.thr_prsn p
left join [PantheonFxAt].dbo.thr_prsnjob e on e.acworker=p.acworker
where  p.acregno=1125



select *
from [PantheonFxAt].dbo.thr_prsnjob p
where  charindex('1125',acworker)>0

select *
from [PantheonFxAt].dbo.thr_prsn p
where  charindex('1125',acworker)>0



SELECT
   acworker
FROM
    (
    select
       acworker, count(*) OVER (PARTITION BY acworker) as cnt    
from [PantheonFxAt].dbo.thr_prsnjob p


    ) T
ORDER BY
   cnt DESC



-- trenutno zaposleno
select count(*)
from (

select p.acregno,p.acWorker,p.adDateEnter datum_zaposljavanja,'FX' Poduzece
from [PantheonFxAt].dbo.thr_prsn p
where  addateexit is null and charindex('(',p.acworker)>0 
union all
select p.acregno,p.acWorker,p.adDateEnter datum_zaposljavanja,'TB' Poduzece
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob e on e.acworker=p.acworker
where  addateexit is null and charindex('(',p.acworker)>0
order by acworker
) x1




select count(*)
from (

Exec sp_addlinkedsrvlogin @rmtsrvname="fxserver",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9."

select *
from [fx1server].rfind.dbo.radnici_



select * into panth_radnici
from (
select p.acregno id,p.acWorker,p.adDateEnter datum_zaposljavanja,'FX' Poduzece,e.accostdrv mt
from [PantheonFxAt].dbo.thr_prsn p
left join [PantheonFxAt].dbo.thr_prsnjob e on e.acworker=p.acworker
where  addateexit is null and charindex('(',p.acworker)>0  and e.addateend is null
union all
select p.acregno,p.acWorker,p.adDateEnter datum_zaposljavanja,'TB' Poduzece,e.accostdrv mt
from [PantheonTKB].dbo.thr_prsn p
left join [PantheonTKB].dbo.thr_prsnjob e on e.acworker=p.acworker
where  addateexit is null and charindex('(',p.acworker)>0  and e.addateend is null
--order by acworker
) x1



order by acworker




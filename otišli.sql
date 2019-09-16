select *
from feroapp.dbo.radnici
where ime like '%LENAC%'


select k.id,k.prezimeime,k.funkcija,k.projekt,k.hala,k.linija,k.mjesto_troska,k.vještine,k.školovanje_posto,k.radnomjesto,k.datumzaposlenja,k.istek_ugovora,k.staz,j.danodlaska,k.godisnji_ostalo 
from kompetencije k 
left join ( 
select * 
from fxsap.dbo.plansatirada 
where danodlaska != '' and danodlaska<(dateadd(day,30,getdate())) and danodlaska> (dateadd(day, -30, getdate()))  and danodlaska is not NULL ) j on j.radnikid = k.id 
where projekt not in ('xNERADI', 'xNa odlasku') and j.danodlaska is not null 
order by PrezimeIme desc 


select *
from kompetencije
where projekt like '%odlasku%'
order by istek_ugovora


Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
select x1.acregno id,x1.acworker prezimeime,x1.addateenter datumdolaska,x1.addateend datumodlaska,x1.acjob radnomjesto,x1.acdept lokacija,x1.accostdrv mjestotroška
from (
select p.acregno,p.acworker,p.addateenter,j.addateend,j.acjob,j.acdept,j.accostdrv
from [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsn p on p.acworker=j.acworker
where j.addateend between '2018-04-01' and '2018-05-10'
union all
select p.acregno,p.acworker,p.addateenter,j.addateend,j.acjob,j.acdept,j.accostdrv
from [192.168.0.6].PantheonTKB.dbo.thr_prsnjob j
left join [192.168.0.6].PantheonTKB.dbo.thr_prsn p on p.acworker=j.acworker
where j.addateend between '2018-04-01' and '2018-05-10'
) x1
order by x1.acworker

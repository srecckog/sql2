use rfind

select x1.rbroj,x1.idradnika,x1.datum,x1.dosao,x1.otisao,x2.mindt,x2.maxdt from (
select *
from pregledvremena
where dosao=otisao
and year(dosao)!=1900
and smjena=1 )x1
left join
(
select  u.extid,convert(varchar(10),e.dt,104) datum,min(e.dt) mindt, max(e.dt) maxdt
from event e 
left join [user] u on u.oid=e.[user]
--where u.extid=1173
group by u.extid,convert(varchar(10),e.dt,104) 
--order by convert(varchar(10),e.dt,104) 
) x2 on x2.extid=x1.idradnika and convert(varchar(10),x1.datum,104)=x2.datum
where month(x1.datum)=6



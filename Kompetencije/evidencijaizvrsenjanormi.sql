use feroapp
select r1.id,e.datum,e.linija,e.hala,e.radnik,e.brojrn,e.norma,e.kolicinaok,case when kolicinaok>=norma then 1 else 0 end as normadane,e.otpadobrada,napomena1,e.id_pro,p.nazivpro,e.vrijemeod,e.vrijemedo
from evidencijanormiview e
left join radnici r on r.id_radnika=e.id_radnika
left join rfind.dbo.radnici_ r1 on r1.id=r.id_fink
left join Proizvodi p on p.id_pro=e.id_pro
where r1.id is not null
--and month(e.datum)=5 and year(e.datum)=2017
order by r1.id,e.datum desc


select *
from evidencijanormiview

select e.datum,e.linija,e.hala,e.brojrn,e.norma,e.kolicinaok,case when kolicinaok>= norma then 1 else 0 end as normadane,e.otpadobrada,napomena1,e.id_pro,p.nazivpro,e.vrijemeod,e.vrijemedo
from evidencijanormiview e left join radnici r on r.id_radnika = e.id_radnika left join rfind.dbo.radnici_ r1 on r1.id = r.id_fink left join Proizvodi p on p.id_pro = e.id_pro where r1.id is not null and r1.id= 1276  order by r1.id, e.datum desc

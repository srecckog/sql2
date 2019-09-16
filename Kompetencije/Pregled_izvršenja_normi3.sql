--select r.id_radnika,d.id_fink,d.ime,l.max,l.kolicina,l.hala,l.smjena,l.linija,l.datum


select l.*


select x1.id_fink , x1.norma_pl , x1.kolicina , x1.radnik , x1.hala , x1.smjena, x1.linija,x1.datum from (
select distinct l.id,l.max as norma_pl,l.kolicina,l.datum,l.hala,l.smjena,l.linija,n.id_pro,d.id_fink,l.radnik
from evidnormi( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ,0) n
left join evidnormirada( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ) r on n.datum=r.datum and n.brojrn=r.brojrn and n.hala=r.hala and n.smjena=r.smjena and n.linija=r.linija 
left join [fxsql2].fxapp.dbo.ldp_aktivnost_view l on l.proizvod=n.nazivpro and l.datum=r.datum and r.hala=l.hala and r.smjena=l.smjena and r.linija=l.linija and l.id_partner=n.id_par
left join radnici d on r.id_radnika=d.id_radnika
where l.kolicina>0
--and r.id_radnika=161
--and l.datum='2017-04-23'
) x1
order by x1.radnik







select *
from proizvodi
where id_pro in ( 941137,941136)


select *
from radnici
where id_radnika=161


select *
from ldp_aktivnost


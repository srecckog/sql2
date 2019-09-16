use feroapp
select x2.id_fink , avg(x2.ukupna_kol/(x2.norma+0.01)*100) as posto
from (

select e.radnik,e.id_radnika,e.datum,e.norma,x1.KolicinaOK,(e.kolicinaok+isnull(x1.KolicinaOK,0)) ukupna_kol, r.ID_Fink,e.hala,e.linija,e.brojrn
from evidencijanormiview E
left JOIN 
(

select hala,linija,smjena,norma,kolicinaok,brojrn,datum
from evidencijanormiview
where radnik=''
) X1 ON X1.HALA=E.HALA AND x1.smjena=e.smjena and x1.linija=e.linija and x1.brojrn=e.brojrn and x1.datum=e.datum
left join radnici r on r.id_radnika=e.id_radnika
where e.radnik<>''
and month(e.datum)=5 and year(e.datum)=2017
order by radnik,datum


) x2
where id_fink is not null
group by x2.id_fink
order by x2.ID_Fink





where radnik like '%GAŠPARIÆ%'

select hala,linija,smjena,norma,kolicinaok
from evidnormi('2017-03-03','2017-03-03',0)
where radnik=''




where linija='19' and hala=1


select *
from evidnormi('2017-03-01','2017-05-31',0) E
where norma=1 and kolicinaok>1
order by e.radnik

select *
from evidencijanormiview e
where norma=1 and kolicinaok>1
order by e.datum,e.radnik


select e.radnik,e.id_radnika,e.datum,e.kolicinaok,e.norma,x1.KolicinaOK,(e.kolicinaok+isnull(x1.KolicinaOK,0)) ukupna_kol, r.ID_Fink,e.hala,e.linija,e.brojrn



exec sp_addlinkedserver @server="FXSql2";
Exec sp_addlinkedsrvlogin @rmtsrvname="FXsql2",@useself=false, @rmtuser="sa", @rmtpassword="banana22";


select j.id_radnika,l.[max],l.hala,l.datum,l.kolicina,l.norma,r.id_fink,j.radnik
from FXSql2.fxapp.dbo.ldp_aktivnost_view l
left join (

select * from feroapp.dbo.EvidencijaNormiView 

) j on l.hala=j.hala and l.datum=j.datum and j.linija=l.linija and j.smjena=l.smjena 
left join radnici r on r.ID_Radnika=j.id_radnika
where l.datum='2017-03-18'
order by radnik



use rfind
select *
from radnici_
where id =5

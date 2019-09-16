-- nedolasci nedjeljom 2017-03
  UPDATE
    kompetencije0305
SET
    nedolascinedjeljom = 1
FROM
	pregledvremena j
   
INNER JOIN
    kompetencije0305 k
ON 
    j.idradnika=k.id
  
  where datepart(dw, j.datum)=7
  and year(j.dosao)=1900
  and month(j.datum)=3
  and j.radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Slubeni put') AND j.HALA!='Reija'

 ----- nedolasci subotom 2017-03
  UPDATE
    kompetencije0305
SET
    nedolascisubotom = 1
FROM
	pregledvremena j
   
INNER JOIN
    kompetencije0305 k
ON 
    j.idradnika=k.id
  
  where datepart(dw, j.datum)=6
  and year(j.dosao)=1900
  and month(j.datum)=3
  and j.radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Slubeni put') AND j.HALA!='Reija'
----------------------------------
-- kasni,prerano_otisao,nedostaje
----------------------------------
  use rfind
  select p.idradnika,r.prezime,r.ime,r.poduzece,sum(kasni) kasni,sum(preranootisao) po, sum(kasni+preranootisao) nedostaje_pl,sum((480-ukupno_minuta)) nedostaje_do8 into temp1
    --select *
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where month(datum)=3
  and year(dosao)!=1900 and dosao!=otisao
  and r.FixnaIsplata=0
  and r.neradi=0
  and (480-Ukupno_minuta)>0
  --and idradnika=1301
  group by p.idradnika,r.prezime,r.ime,r.poduzece
  order by sum(480-ukupno_minuta)
  ------------------------------------------------
  UPDATE
    kompetencije0305
SET
    kasni = j.kasni,
	PreranoOtisao=j.po,
	NedostajeDo8sati=j.nedostaje_do8
FROM
	temp1 j     -- tablica nastala iz querya stat_bo2.sql
   
INNER JOIN
    kompetencije0305 k
ON 
    j.idradnika=k.id
  
----------------------
- zamjena null sa space ili 0
-
------------
 UPDATE
    kompetencije0305
SET
    kasni = isnull(kasni,0),
	PreranoOtisao=isnull(preranootisao,0),
	NedostajeDo8sati=isnull(NedostajeDo8sati,0),
    NedolasciNedjeljom=isnull(NedolasciNedjeljom,0),
    NedolasciSubotom=isnull(NedolasciSubotom,0),
	Napomena=isnull(Napomena,'')
---------------------------

	--UPDATE
 --   kompetencije0305
	--set napomena=''
	--where napomena='0'

------------------------
. ispunjenje norme
------------------------
  use rfind
  select round(avg(x1.kolicinaok/(x1.norma+0.01))*100,2) norma_posto,id_fink,radnik into Norma_3
  from ( 
  
  select es.linija,es.ID_ENS,es.ID_ENZ,es.id_radnika,es.radnik,es.kolicinaok,es.norma,r.id_fink,ez.Datum
  from feroapp.[dbo].[EvidencijaNormista] es
  left join fxserver.feroapp.[dbo].[EvidencijaNormizag] ez on ez.id_enz = es.id_enz
  left join feroapp.[dbo].radnici r on r.id_radnika=es.ID_radnika
  where year(datum)=2017 and month(datum)=3
  and es.id_radnika not in ( 0)
  and es.norma>1
  and es.radnik like '%GAŠPARI%'
  
    ) x1
  group by x1.id_fink,x1.radnik
  order by id_fink,radnik



  select *
  from [dbo].[EvidencijaNormista] es
  where ID_Radnika=1506

------------------------
. ispunjenje norme
------------------------
  use rfind
  select round(avg(x1.kolicinaok/(x1.norma+0.01))*100,2) norma_posto,id_fink,radnik into Norma_3
  from ( 
  
  select r.id_fink,ez.Datum,sum(kolicinaok),es.norma,es.radnik
  from feroapp.[dbo].[EvidencijaNormista] es
  left join fxserver.feroapp.[dbo].[EvidencijaNormizag] ez on ez.id_enz = es.id_enz
  left join feroapp.[dbo].radnici r on r.id_radnika=es.ID_radnika
  where year(datum)=2017 and month(datum)=3
  and es.id_radnika not in ( 0)
  and es.norma>=0
  and es.radnik like '%GAŠPARI%'
  group by  r.id_fink,ez.Datum,es.norma,es.radnik
  order by radnik,datum



  group by r.id_fink,ez.datum,es.norma,es.radnik

  
    ) x1
  group by x1.id_fink,x1.radnik
  order by id_fink,radnik

  ---------------------------------
exec sp_addlinkedserver @server="FXSql2";
Exec sp_addlinkedsrvlogin @rmtsrvname="FXsql2",@useself=false, @rmtuser="sa", @rmtpassword="banana22";

select kolicina , max , norma , datum , CAST( YEAR(DATUM) as varchar(4))+'-'+cast( MONTH(DATUM) as varchar(2)) period into norma_3
from fxsql2.fxapp.dbo.ldp_aktivnost_view
where month(datum)=3 and year(datum)=2017
--and radnik like '%GAŠPARIÆ%'
and norma>0 AND KOLICINA>0
order by datum

------------------------
select *
  from feroapp.[dbo].[EvidencijaNormista] es
  left join fxserver.feroapp.[dbo].[EvidencijaNormizag] ez on ez.id_enz = es.id_enz
  left join feroapp.[dbo].radnici r on r.id_radnika=es.ID_radnika
  where year(datum)=2017 and month(datum)=3
  --and es.id_radnika not in ( 0)
  and es.norma>=0
  --and es.radnik like '%GAŠPARI%'
  --and id_fink=1310
 -- group by  r.id_fink,ez.Datum,es.norma,es.radnik
  order by radnik,datum

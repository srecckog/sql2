use rfind
select x1.*
from(
select distinct k.id,k.prezimeime,k.funkcija,k.projekt,k.hala,k.linija,k.mjesto_troska,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=2) ar,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=14) ir,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=39) turm,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=15) vc_hurco,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=12) porche,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=16) sherer,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=17) okuma,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=18) puma_tt,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=19) iv,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=20) emag,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=21) valjci,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=22) pile,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=23) wupertal_prsten,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=24) iwk,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=25) pakiranje_iwk,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=38) membrane,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=26) skf,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=27) pakiranje_skf,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=28) glodanje_skf,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=29) vise_vretenasta,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=30) stupna,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=31) narezivanje_navoja,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=32) sona,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=33) [3494],
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=34) gt600,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=35) kontrolaprstena100posto,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=36) kontrolaporoznosti,
(select count(*) from radnicivjestine v where v.idradnika=k.id and idvjestine=37) kontrolasona100posto,
k.DatumZaposlenja,
k.napomena
from kompetencije k  
) x1
order by id


--where x1.id 
--in (
--select distinct idradnika
--from radnicivjestine
--where idvjestine in ( 11)
--)
--order by x1.prezimeime


--select *
--from radnicivjestine
--where idvjestine=11
--order by idradnika




--select *
--from (
--select idradnika,'14' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--union all
--select idradnika,'39' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--union all
--select idradnika,'2' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--) x1
--order by idradnika


--select * into radnicivjestine0910
--from radnicivjestine


--insert into radnicivjestine ( idradnika,idvjestine,Firma) 
--select *
--from (
--select idradnika,'14' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--union all
--select idradnika,'39' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--union all
--select idradnika,'2' idvjestina,firma
--from radnicivjestine
--where idvjestine=11
--) x1


--select *
--from radnicivjestine
--where idradnika=5

--delete from radnicivjestine where idvjestine=11





--case when rv.idvjestine=24 then '1'  else '0' end iwk,
--case when rv.idvjestine=25 then '1'  else '0' end pakiranje_iwk,
--case when rv.idvjestine=26 then '1'  else '0' end skf,
--case when rv.idvjestine=27 then '1'  else '0' end pakiranje_skf,
--case when rv.idvjestine=28 then '1'  else '0' end glodanje_skf,
--case when rv.idvjestine=29 then '1'  else '0' end vise_vretenasta,
--case when rv.idvjestine=30 then '1'  else '0' end stupna,
--case when rv.idvjestine=31 then '1'  else '0' end narezivanje_navoja,
--case when rv.idvjestine=32 then '1'  else '0' end sona,
--case when rv.idvjestine=33 then '1'  else '0' end [3494],
--case when rv.idvjestine=34 then '1'  else '0' end gt600,
--case when rv.idvjestine=35 then '1'  else '0' end kontrolaprstena100posto,
--case when rv.idvjestine=36 then '1'  else '0' end kontrolaporoznosti,
--case when rv.idvjestine=37 then '1'  else '0' end kontrolasona100posto,
--k.staz,
--k.napomena
--from kompetencije k  
--where rv.idvjestine in (34,11,32)
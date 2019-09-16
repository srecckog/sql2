--bdf hala3
declare @dat1 date='2019-03-01'
declare @dat2 date='2019-03-04'

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'TOK' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)    --BDF
and linija not in ('GT600-1','GT600-2','GT600-3','GT600-4','GT600-5','VC510') and obrada3=0
) x1
group by datum,kupac,id_par

UNION ALL

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'DO' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)    --BDF
and (linija in ('VC510')  or linija like '09%')
) x1
group by datum,kupac,id_par

union all

-- sona sve hale
select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'TOK' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where id_par in ( 121301)  -- SONA
and linija not in ('GT600-1','GT600-2','GT600-3', 'GT600-4','GT600-5') and obrada3=0
) x1
group by datum,kupac,id_par

UNION ALL

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'DO' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where id_par in ( 121301)  -- SONA
and linija in ('GT600-1','GT600-2','GT600-3', 'GT600-4','GT600-5') 
) x1
group by datum,kupac,id_par
order by datum,kupac


--declare @dat1 date='2019-03-01'
--declare @dat2 date='2019-03-01'
-- mjeseèni kumulativni izvještaj
-- bdf hala3
select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'TOK' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)             --BDF
and linija not in ('GT600-1','GT600-2','GT600-3','GT600-4','GT600-5','VC510') and obrada3=0
) x1
group by year(datum)*100+month(datum),kupac,id_par

UNION ALL

select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'DO' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)             --BDF
and (linija in ('VC510') OR obrada3=1 or linija like '09%')
) x1
group by year(datum)*100+month(datum),kupac,id_par


union all
-- sona sve hale
select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'TOK' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where id_par in (121301)					-- SONA
and (linija not in ('GT600-1','GT600-2','GT600-3','GT600-4','GT600-5','VC510') and obrada3=0)
) x1
group by year(datum)*100+month(datum),kupac,id_par

UNION ALL

select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'DO' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from evidnormi(@dat1,@dat2,0)
where id_par in (121301)					-- SONA
and linija in ('GT600-1','GT600-2','GT600-3','GT600-4','GT600-5','VC510') and obrada3=0
) x1
group by year(datum)*100+month(datum),kupac,id_par
order by year(datum)*100+month(datum),kupac





select *
from evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121301,121400)
and linija not in ('GT600-1','GT600-2','GT600-3','GT600-4','GT600-5') and obrada3=0
--group by datum,kupac,id_par
order by datum,kupac

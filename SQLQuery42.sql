USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Realizacija]    Script Date: 4.10.2018. 19:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- broj linija            dat1 , dat2 , 2
-- korekcija broja linija dat1 , dat2 , 22
-- id =11  proizvedeno komada SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG_DSR(@dat1, @dat2)
-- id=112 proizvedeno komada  SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG_DSR(@dat1, @dat2)
-- =============================================
ALTER PROCEDURE [dbo].[Realizacija]
	-- Add the parameters for the stored procedure here
	@dat1 varchar(12),
	@dat2 varchar(12),
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
 
------------------ evidencija normi - gedrehte ringe 3
-- Realizacija
-- BDF

if @id=1   -- komada,broj_štelanja

begin 
select kupac,VrstaNarudzbe, sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost, sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac like '%Austria%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) e
where kupac like '%Austria%' and obrada3=0
group by kupac,VrstaNarudzbe
union all
-- SONA
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%SONA%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- KYSUCE
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%KYSUCE%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%KYSUCE%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schweinfuurt
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Schwein%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SCHWEINFURT%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- FERRO PREISS
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Ferro-Preis%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Ferro-Preis%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Brasil
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Brasil%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Romania
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Romania%' AND  TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' AND OBRADAA=1
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%prsteni%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe
UNION ALL
-- ostali
select kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' and kupac not LIKE '%Ferro-Preis%' and kupac NOT LIKE '%SCHWEINFURT%' AND KUPAC NOT LIKE '%Brasil%' AND KUPAC NOT LIKE '%KYSUCE%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac not LIKE '%KYSUCE%' and kupac not LIKE '%Ferro-Preis%' and kupac NOT LIKE '%SCHWEINFURT%' AND KUPAC Not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%'
group by kupac,VrstaNarudzbe
END

if @id=10   -- komada,broj_štelanja, po halama

begin 
select hala,kupac,VrstaNarudzbe, sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost, sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac like '%Austria%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac like '%Austria%' and obrada3=0
group by hala,kupac,VrstaNarudzbe
union all
-- SONA
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%SONA%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- KYSUCE
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%KYSUCE%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%KYSUCE%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- Schweinfuurt
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Schwein%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SCHWEINFURT%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- FERRO PREISS
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Ferro-Preis%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Ferro-Preis%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- Brasil
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Brasil%' AND TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- Romania
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Romania%' AND  TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' AND OBRADAA=1
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, prsteni
select hala,kupac+' Prsteni',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%prsteni%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%prsteni%'
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- Schaeffler Technologies, valjci
select hala,kupac+' Valjci',VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select *  from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' AND VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by hala,kupac,VrstaNarudzbe
UNION ALL
-- ostali
select hala,kupac,VrstaNarudzbe,sum((obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok) vrijednost,sum(kolicinaok) kolicinaok, (select count(*)  from ( select * from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 ) where  kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' and kupac not LIKE '%Ferro-Preis%' and kupac NOT LIKE '%SCHWEINFURT%' AND KUPAC NOT LIKE '%Brasil%' AND KUPAC NOT LIKE '%KYSUCE%' and TekstCheck01=1 ) x1 ) as broj_stelanja
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac not LIKE '%KYSUCE%' and kupac not LIKE '%Ferro-Preis%' and kupac NOT LIKE '%SCHWEINFURT%' AND KUPAC Not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%'
group by hala,kupac,VrstaNarudzbe
END


--else if @id=11 -- evidencija proizvedenog po kupcima

--SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno(@dat1, @dat2)

else if @id=11 -- evidencija proizvedenog po kupcima

--SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno(@dat1, @dat2)
SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG_DSR(@dat1, @dat2)


else if @id=111 -- SONA

begin
select sum(kolicinaok) kolicinaok
from (
SELECT ENV.BrojRN, ENV.Radnik, ENV.Radnik2, ENV.Datum, ENV.Hala, ENV.Linija, (CASE WHEN ENV.ObradaA = 1 THEN '+' ELSE '' END) tok, (CASE WHEN ENV.ObradaB = 1 THEN '+' ELSE '' END) glo, 
       (CASE WHEN ENV.ObradaC = 1 THEN '+' ELSE '' END) obc, ENV.Norma, ENV.KolicinaOK, ENV.OtpadMat, ENV.OtpadObrada, PRO.ZavrsnaObrada, PRO.NazivPro, (CASE WHEN MAT.OmjerPro = 2 THEN 'TURM' ELSE '' END) AS Turm 
       FROM feroapp.dbo.EvidencijaNormiView ENV 
           LEFT JOIN feroapp.dbo.Proizvodi PRO ON ENV.ID_Pro = PRO.ID_Pro 
           LEFT JOIN feroapp.dbo.Materijali MAT ON ENV.ID_Mat = MAT.ID_Mat 
       WHERE ENV.Datum BETWEEN @dat1 AND @dat2 AND BrojRN IN(SELECT NDV.BrojRN FROM feroapp.dbo.NarudzbeDetaljnoView NDV WHERE NDV.ID_Par =121301) 
	   and env.obradab=0
	   ) x1
end

else if @id=112 -- 

begin

SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG_DSR(@dat1, @dat2)

end


else if @id=12
begin


select count(*) broj_štelanja,p.KratkiNaziviKupca kupac,x.vrstanarudzbe
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and pocetak >@dat1 and ( kraj<@dat2 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.KratkiNaziviKupca,x.vrstanarudzbe
order by p.KratkiNaziviKupca

end


else if @id=13      -- planirano=norma iz evidencije normi, dnevni izvještaj za sve hale

begin

-- old version, bez korekcija normi ( isti proizvod različit rn)
--select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
--from feroapp.dbo.evidnormi(@dat1,@dat2,0)
--where linija  not in ('GT600-1','GT600-2','VC510','HURCO') 
--GROUP BY KUPAC,vrstanarudzbe
--union all
--select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
--from feroapp.dbo.evidnormi(@dat1,@dat2,0)
--where linija in ('GT600-1','GT600-2','VC510','HURCO') 
--GROUP BY KUPAC,vrstanarudzbe
--order by kupac

select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe

union all

select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe
order by kupac


end


else if @id=131      -- planirano=norma iz evidencije normi, PO POGONIMA

begin

-- old version, bez korekcija normi ( isti proizvod različit rn)
--select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
--from feroapp.dbo.evidnormi(@dat1,@dat2,0)
--where linija  not in ('GT600-1','GT600-2','VC510','HURCO') 
--GROUP BY KUPAC,vrstanarudzbe
--union all
--select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
--from feroapp.dbo.evidnormi(@dat1,@dat2,0)
--where linija in ('GT600-1','GT600-2','VC510','HURCO') 
--GROUP BY KUPAC,vrstanarudzbe
--order by kupac


select HALA,kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY HALA,KUPAC,vrstanarudzbe

union all

select hala,kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY hala,KUPAC,vrstanarudzbe
order by hala,kupac


end

else if @id <0  -- evidencija proizvedenog po kupcima i po smjenama

SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno_SG(@dat1, @dat2, abs(@id))

else if @id=14  -- izvjestaj za fxextranet, proizvedena kolicina i norma.

begin

select b1.*,b2.norma
from (
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','GT600-1','GT600-2','GT600-3')
and e.obrada3=0 
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','GT600-1','GT600-2','GT600-3') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
) x1
group by VrstaNarudzbe,kupac,id_par
) b1
left join (
select kupac,vrstanarudzbe,sum(norma) norma,'TOK' vo,id_par
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe,id_par

union all

select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo,id_par
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('GT600-1','GT600-2','GT600-3','VC510','HURCO') 
GROUP BY KUPAC,vrstanarudzbe,id_par
) b2 on b1.id_par=b2.id_par and b1.vo=b2.vo
order by id_par

end


else if @id=2 -- kupac, broj_linija  od 25.01.

begin
select kupac,vrstanarudzbe,count(*) broj_linija
from (
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.vrstanarudzbe
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
--where p.Vrsta='Linija' and ( linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')  ) and obrada3=0
--where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
--and p.broj not in ('GT600-1','GT600-2','VC510','HURCO')
-----where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
-----and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%' AND p.naziv<>'L9' and p.naziv not like '%CINC%') --AND ( KUPAC IS NOT NULL )
where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%'  and p.naziv not like '%CINC%') --AND
and not (p.naziv='L9' and p.hala='3')
and not (p.naziv='L12.1' )
) x1
--where ( x1.hala in ( 1,3))
) x2
group by kupac,vrstanarudzbe
order by kupac
end


else if @id=201111 -- kupac, broj_linija po halama do 25.01.

begin
select hala,kupac,vrstanarudzbe,count(*) broj_linija
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1, @dat2 , 0 )
where  obrada3=0 and KolicinaOK > 0
and linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,kupac,vrstanarudzbe
order by kupac
end

else if @id=20 -- kupac, broj_linija  od 25.01.

begin
select kupac,halal hala,vrstanarudzbe,count(*) broj_linija
from (
select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,x1.vrstanarudzbe
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
--where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
--and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and p.NAZIV not like '%L9 - MORIS%' AND ( KUPAC IS NOT NULL )
-----where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
-----and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%' AND p.naziv<>'L9' and p.naziv not like '%CINC%') --AND ( KUPAC IS NOT NULL )
where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%'  and p.naziv not like '%CINC%') --AND
and not (p.naziv='L9' and p.hala='3')

) x1
) x2
group by kupac,halal,vrstanarudzbe
order by kupac
end


else if @id=227777 -- kupac, korekcija broja_linija do 25.01.

begin 

select '_Ukupno' kupac,sum(trajanje) ukupnotr
from (
select case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
union all
select kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by kupac
order by kupac
end

else if @id=221   -- kupac, korekcija broja linija od 23.03.

begin

select distinct x1.naziv,x1.halal,x1.hala,'_Ukupno' kupac,sum(case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end) ukupnotr
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%'  and p.naziv not like '%CINC%') --AND
and not (p.naziv='L9' and p.hala='3')
and not (p.naziv='L12.1' )
) x1
group by x1.naziv,x1.halal,x1.hala

union all

select distinct x1.naziv,x1.halal,x1.hala,x1.kupac,sum(case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end) ukupnotr
from (
select p.naziv,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Linija' and ( (linija nOt in ('GT600-1','GT600-2','VC510','HURCO') AND E.OBRADA3<>10 )  OR E.LINIJA IS NULL) 
and p.broj not in ('GT600-1','GT600-2','VC510','HURCO') and ( p.NAZIV not like '%L9 - MORIS%'  and p.naziv not like '%CINC%') --AND
and not (p.naziv='L9' and p.hala='3')
and not (p.naziv='L12.1' )
) x1
group by x1.naziv,x1.halal,x1.hala,x1.kupac
order by hala,naziv,kupac

end


else if @id=22 -- kupac, korekcija broja_linija od 25.01.

begin 

select '_Ukupno' kupac,sum(trajanje) ukupnotr
from (
select case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
--WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
union all
select kupac,sum(trajanje) ukupnotr
from (
select kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by kupac
order by kupac
end


else if @id=220 -- kupac, korekcija broja_linija po halama

begin 

select hala,'_Ukupno' kupac,sum(trajanje) ukupnotr
from (

select e1.hala,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(
select hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 )
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by hala,linija
having count(*)>1
) x2
left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')

) x1
group by x1.hala

union all

select hala,kupac,sum(trajanje) ukupnotr
from (

select e1.hala,kupac,case when vrijemedo>vrijemeod then DATEDIFF(n,vrijemeod,vrijemedo) else DATEDIFF(n,vrijemeod,vrijemedo) +1440 end trajanje
from(

select x1.hala,linija,count(*) kol
from(
select distinct kupac,hala,linija,VrstaNarudzbe
from feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e2
WHERE linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')
) x1
group by x1.hala,linija
having count(*)>1

) x2

left join feroapp.dbo.evidnormi( @dat1 , @dat2,0 ) e1 on e1.hala=x2.hala and e1.linija=x2.linija
WHERE e1.linija nOt in ('GT600-1','GT600-2','EMAG','VC510','HURCO')

) x1


group by hala,kupac
order by kupac

end



else if @id=3  -- komada,broj_škart obrade i materijala, za sve hale

begin 
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac like '%Austria%' 
group by hala,kupac,VrstaNarudzbe,turm
union all
-- SONA
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' 
group by kupac,VrstaNarudzbe,turm
union all
-- Brasil
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Kysuce kućište
select kupac+' Kućište',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Kysuce%' and VrstaNarudzbe like '%Ku%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Kysuce prsten
select kupac+' Prsten',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Kysuce%' and VrstaNarudzbe like '%Prsten%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Romania
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' 
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, prsteni
select kupac+' Prsteni',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%'  and VrstaNarudzbe like '%prsteni%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, valjci
select kupac+' Valjci',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by kupac,VrstaNarudzbe,turm
UNION ALL
-- ostali
select kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%' AND KUPAC NOT LIKE '%Kysuce%'
group by kupac,VrstaNarudzbe,turm
END

else if @id=31  -- komada,broj_škart obrade i materijala po halama

begin 
select hala,kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac like '%Austria%' 
group by hala,kupac,VrstaNarudzbe,turm
union all
-- SONA
select hala,kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%SONA%' 
group by hala,kupac,VrstaNarudzbe,turm
union all
-- Brasil
select hala,kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Brasil%' 
group by hala,kupac,VrstaNarudzbe,turm
UNION ALL
-- Kysuce kućište
select hala,kupac+' Kućište',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Kysuce%' and VrstaNarudzbe like '%ku%'
group by hala,kupac,VrstaNarudzbe,turm
UNION ALL
-- Kysuce prsten
select hala,kupac+' Prsten',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Kysuce%' and VrstaNarudzbe like '%Prsten%'
group by hala,kupac,VrstaNarudzbe,turm
UNION ALL
-- Romania
select hala,kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Romania%' 
group by hala,kupac,VrstaNarudzbe,turm

-- Schaeffler Technologies, prsteni
select hala,kupac+' Prsteni',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%'  and VrstaNarudzbe like '%prsteni%'
group by hala,kupac,VrstaNarudzbe,turm
UNION ALL
-- Schaeffler Technologies, valjci
select hala,kupac+' Valjci',turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where  kupac LIKE '%Technolo%' and VrstaNarudzbe like '%valjci%' and vrstanarudzbe like '%valjci%'
group by hala,kupac,VrstaNarudzbe,turm
UNION ALL
-- ostali
select hala,kupac,turm,sum(kolicinaok) kolicinaok, sum(otpadobrada) otpadobrada,sum(otpadmat) otpadmat
from feroapp.dbo.evidnormi( @dat1 , @dat2 , 0 )
where kupac not like '%Austria%' AND KUPAC NOT LIKE '%SONA%'  AND KUPAC NOT LIKE '%ROMANIA%' AND KUPAC NOT LIKE '%TECHNOLOGI%' AND KUPAC NOT LIKE '%Brasil%' AND KUPAC NOT LIKE '%Kysuce%'
group by hala,kupac,VrstaNarudzbe,turm
END


else if @id=4  -- kaliona  komada,pec   

begin 

select sum(x1.tezinaprokom*kolicina) tezina,pec
from (
select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM>=@dat1 and datum<=@dat2) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
) x1
group by pec


end

else if @id=41  -- kaliona  broj sarzi

begin 


select pec,count(brojsarze) brojsarzi
from(
select distinct x2.pec,brojsarze from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM=@dat1 ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ 
) x1
group by pec
end

else if @id=5  -- realizacija ukupno
begin 

select sum(v1) vrijednost,sum(kolicinaok) kolicina
from (
select (( obradaa*CijenaObradaA+obradab*CijenaObradab+obradac*CijenaObradac)*kolicinaok ) as v1,kolicinaok
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
) x1

end


else if @id=6 -- realizacija kaliona

begin 
  
  Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.8",@useself=false, @rmtuser="sa", @rmtpassword="banana22"



---- list dnevne proizvodnje excel
--SELECT PEC,SUM(KOLICINA) komada,SUM(KOLICINA*TEZINAPROKOM) tezina
--FROM (
--select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
--from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
--SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
--WHERE DATUM=@dat1) x1 
--left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
--group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
--) X1
--GROUP BY PEC

--  use feroapp

   select 'Sve' pec, sum(kolicinaok*tezinaprokom) tezina
  from (
SELECT kolicinaok,   ISNULL((SELECT TezinaPro FROM [FeroApp].[dbo].[Proizvodi] WHERE ID_Pro = (SELECT ID_Pro FROM [FeroApp].[dbo].[NarudzbeSta] WHERE BrojRN = (SELECT BrojRN FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] ez WHERE ev.ID_EPZ = ez.ID_EPZ))), 0) AS TezinaProKom 
        FROM [FeroApp].[dbo].[EvidencijaProizvodnjeView] ev
        WHERE (Datum >= @dat1 and Datum <= @dat2)
        AND Linija = 'TO' 
	) x1


end

else if @id=61			-- kaliona za dpr, id_par,kolicinaok,tezinaprokom

	begin
		select id_par,kolicinaok, ISNULL((SELECT TezinaPro FROM [FeroApp].[dbo].[Proizvodi] WHERE ID_Pro = (SELECT ID_Pro FROM [FeroApp].[dbo].[NarudzbeSta] WHERE BrojRN = (SELECT BrojRN FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] ez WHERE ev.ID_EPZ = ez.ID_EPZ))), 0) AS TezinaProKom ,datum
		from [FeroApp].[dbo].[EvidencijaProizvodnjeView] ev
		WHERE (Datum >= @dat1 and Datum <= @dat2 )
	end


else if @id=7  -- stanje materijala,količinski

begin

SELECT id_skl,sum(saldokolicina) kolicina,sum(saldotezina) tezina
from (
SELECT  id_skl, case when jm='mm' then  saldokolicina/1000 else saldokolicina end saldokolicina,saldotezina
FROM feroapp.dbo.StanjeULR(@dat1) 
WHERE VrstaUR <> 'Povrat' AND (CASE WHEN VrstaOtpisa = 'Tezinski' THEN SaldoTezina ELSE SaldoKolicina END) <> 0
and id_skl in ( 334,	371,	350,	327,	358,	300,308,	390,361,	394,	392,	252,	153,	155,	118,	39)
) x1
group by id_skl
end

else if @id=71  -- stanje materijala, vrijednosno

begin

SELECT x1.id_skl,cast( sum(x1.vrijednost/x1.tecaj) as decimal(18,2)) vrijednost 
from ( select id_skl,vrijednost,(select tecajeur from feroapp.dbo.tecajnalista where dantecaja=(select max(dantecaja) from feroapp.dbo.tecajnalista )) as tecaj
       FROM feroapp.dbo.StanjeULR_Kn('2199-12-31') SULR 	   
       WHERE SULR.ID_SKL IN(334, 371, 350, 327, 358, 300, 308, 390, 361, 394, 392, 252, 153, 155, 118, 39) 
             AND (CASE WHEN SULR.VrstaOtpisa = 'Tezinski' THEN SULR.SaldoTezina ELSE SULR.SaldoKolicina END) <> 0
		)x1
group by id_skl

end


else if @id=8 -- lager gotove robe , komada

begin

select x1.id_par,p.NazivPar, vrstanar,sum(Spremno_kontrola ) komada
from(
	SELECT  NarudzbeZag.VrstaNar,narudzbezag.id_par,EvidencijaNormiView.BrojRN, EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NarudzbeSta.KolicinaNar, SUM(EvidencijaNormiView.KolicinaOK) AS Potokareno_steleri, 
      ISNULL(SSEP.NapravljenoPro, 0) AS Potokareno_kontrola, ISNULL(SSEP.IsporucenoPro, 0) AS Isporuceno_kontrola, ISNULL(SSEP.SpremnoPro, 0) AS Spremno_kontrola 
      FROM feroapp.dbo.EvidencijaNormiView 
        INNER JOIN feroapp.dbo.Proizvodi ON EvidencijaNormiView.ID_Pro = Proizvodi.ID_Pro 
        INNER JOIN feroapp.dbo.NarudzbeSta ON EvidencijaNormiView.BrojRN = NarudzbeSta.BrojRN 
        INNER JOIN feroapp.dbo.NarudzbeZag ON NarudzbeSta.ID_NarZ = NarudzbeZag.ID_NarZ 
        FULL OUTER JOIN feroapp.dbo.SumeStatusaEvidPro(9) SSEP ON EvidencijaNormiView.BrojRN = SSEP.BrojRN 
      WHERE EvidencijaNormiView.BrojRN IN(SELECT feroapp.dbo.NarudzbeDetaljnoView.BrojRN FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.ID_Par = narudzbezag.id_par AND NarudzbeDetaljnoView.Isporuceno = 0) 
        AND EvidencijaNormiView.ObradaA = 1         
      GROUP BY  narudzbezag.id_par,NarudzbeZag.VrstaNar,EvidencijaNormiView.BrojRN, EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NarudzbeSta.KolicinaNar, SSEP.NapravljenoPro, SSEP.IsporucenoPro, SSEP.SpremnoPro
	  ) x1
	  left join feroapp.dbo.partneri p on p.id_par=x1.id_par
	  group by x1.id_par,vrstanar,p.nazivpar
end

else if @id=9

begin
SELECT * FROM feroapp.dbo.EvidencijaProizvedenoFakturirano_Zbirno(@dat1, @dat2) z
where id_par in ( select id_par from planiranje.dbo.grupekupci )
end


end

USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[LDP_RECALC]    Script Date: 15.8.2019. 8:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LDP_RECALC]
	-- Add the parameters for the stored procedure here
	@dat1 varchar(20),
	@dat2 varchar(20),
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @LINIJEDO VARCHAR(80)
	set @linijedo = concat('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
 
 
if @id < 4 -- ldp po smjenama i linijama

--select p.hala halal,p.naziv,x1.*
--from feroapp.dbo.proizvodnelinije p 
--left join 
--(
--select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup
--from (
--select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
--from
--(

--select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.smjena=(@id)

--) v
--left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
--left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

--where v.datum=@dat1 

--) r
--group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro
--) x1 on p.hala=x1.hala and p.broj=x1.linija
--where p.vrsta='Linija'
--order by x1.datum,x1.hala,x1.smjena,x1.linija,x1.id_pro,x1.brojrn

begin
select v.*,p.NazivPar kupac,pr.nazivpro,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, case when vrijemedo>vrijemeod then datediff(n,vrijemeod,vrijemedo) else datediff(n,vrijemeod,vrijemedo)+1440 end trajanje_erv, case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(n.Obrada1,0)+isnull(n.CijenaObrada2,0)*isnull(n.Obrada2,0)+isnull(n.CijenaObrada3,0)*isnull(n.Obrada3,0)) cijena,  e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost,e.napomena1 napomena
from feroapp.dbo.evidencijanormiview e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
left join
(
SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak >= @dat1 and  pocetak <= @dat2

) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro
where v.datum=@dat1 and smjena=@id
order by v.hala,v.smjena,v.linija
end

else if @id=10      -- Provjera normi , norma =1

begin
select datum,hala,linija,id_pro,id_mat,nazivpro,norma,sum(kolicinaok) kolicinaok,kupac
from feroapp.dbo.evidnormi(getdate()-5,getdate(),0)
where norma=1 and kolicinaok>0
group by datum,hala,linija,id_pro,id_mat,nazivpro,norma,kupac
end


else if @id=101      -- planirano=norma iz evidencije normi, tjedno

begin

select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from (

select kupac,vrstanarudzbe,sum(norma) norma,'T' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
GROUP BY KUPAC,vrstanarudzbe

union all

select kupac,vrstanarudzbe,sum(norma*-1) norma,'T' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
group by hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
) x1
group by hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
having count(*)=2 
) x2
GROUP BY KUPAC,vrstanarudzbe
) x3
group by kupac,vrstanarudzbe,vo

union all

select kupac,vrstanarudzbe,sum(norma),'DO' vo
from (
select kupac,vrstanarudzbe,sum(norma) norma,'DO' vo
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
GROUP BY KUPAC,vrstanarudzbe
union all
select kupac,vrstanarudzbe,sum(norma*-1) norma,'DO' vo
from (
select count(*) broj,hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
from (
select hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where linija  in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
group by hala,smjena,linija,id_pro,brojrn,norma,kupac,VrstaNarudzbe
) x1
group by hala,smjena,linija,id_pro,norma,kupac,VrstaNarudzbe
having count(*)=2 
) x2
GROUP BY KUPAC,vrstanarudzbe
) x3
group by kupac,vrstanarudzbe,vo
order by kupac
end

else if @id=102

begin

declare @dat11 varchar(20)
declare @dat12 varchar(20)
--set @dat11 = @dat1 + ' 6:00:00'
--set @dat12 = @dat2 + ' 6:00:00'

--select v.kupac,v.vrstanarudzbe,count(*) broj_stelanja
--from (
--select e.vrstanarudzbe ,e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
--from feroapp.dbo.evidnormi(@dat1,@dat1,0) e
--left join 
--(

--SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
--FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
--       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
--	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
--	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
--	   where pocetak>=@dat11 and  ( kraj<=@dat12 or kraj is null)
--	   --pl.broj='32'
--      --order by hala,naziv,pocetak
--) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
--where z.aktivnost like '%Štelanje%'
--)v
--group by kupac,vrstanarudzbe
--end



     set @dat11 = @dat1 + ' 06:00:00'
     set @dat12 = @dat2 + ' 06:00:00'  

--select v.kupac,v.vrstanarudzbe,count(*) broj_stelanja
--from (
--select e.vrstanarudzbe ,e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.smjena,e.linija,e.nazivpro,e.norma,e.kolicinaok,e.zavrsnaobrada,e.kupac,e.radnik,z.trajanje trajanjezastoja,z.aktivnost
--from feroapp.dbo.evidnormi(@dat1,@dat1,0) e
--left join 
--(

--SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
--FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
--       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
--	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
--	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
--	   where pocetak>=@dat11 and  ( kraj<=@dat12 or kraj is null)
	   
--) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
--where z.aktivnost like '%Štelanje%' and e.Smjena=@smjena
--)v
--group by kupac,vrstanarudzbe

select count(*) broj_stelanja,id_par,p.nazivpar kupac,x.vrstanarudzbe
from (
SELECT *, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
where aktivnost like '%ŠTEL%'
and ( pocetak >=@dat11  and pocetak<=@dat12)
--and pocetak >@dat11 and ( kraj<@dat12 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by p.NazivPar,x.vrstanarudzbe,id_par
order by p.nazivpar

end

else if @id=1020

begin

--declare @dat11 varchar(20)
--declare @dat12 varchar(20)

set @dat11 = @dat1 + ' 06:00:00'
set @dat12 = @dat2 + ' 06:00:00'  

select count(*) broj_stelanja,x.hala,id_par,p.nazivpar kupac,x.vrstanarudzbe
from (
SELECT pla.*,pl.hala, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
inner join feroapp.dbo.ProizvodneLinije pl  on pl.ID_PLI=pla.ID_PLI
where aktivnost like '%ŠTEL%'
and ( pocetak >=@dat11  and pocetak<=@dat12)
--and pocetak >@dat11 and ( kraj<@dat12 or kraj is null)
) x
left join feroapp.dbo.partneri p on p.ID_Par=x.kupac
group by x.hala,p.NazivPar,id_par,x.vrstanarudzbe
order by p.nazivpar

end

else if @id=4          -- ldp po radnicima, dnevni, ne vrijedi

begin 

select r.datum,r.hala,r.linija,sum(r.norma) norma,r.radnik,r.nazivpro,sum(kolicinaok) kolicina,sum(planirano) planirano,r.napomena,r.kupac,isnull(r.Aktivnost,'')+':'+str(trajanjezastoja)+' min.' aktivnost
from (
select v.*,p.NazivPar kupac,pr.nazivpro,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, case when vrijemedo>vrijemeod then datediff(n,vrijemeod,vrijemedo) else datediff(n,vrijemeod,vrijemedo)+1440 end trajanje_erv, case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok, e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost,e.napomena1 napomena
from feroapp.dbo.evidencijanormiview e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
left join
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>=@dat1 and  kraj<@dat2

) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1

) r
group by r.datum,r.hala,r.linija,r.nazivpro,r.radnik,r.napomena,r.kupac,isnull(r.Aktivnost,'')+':'+str(trajanjezastoja)+' min.'
order by r.datum,r.hala,r.linija

end

else if @id=41			 -- ldp po radnicima, dnevni, novi, sa efektivnim radnim vremenom

begin

     set @dat11 = @dat1 + ' 06:00:00'
     set @dat12 = @dat2 + ' 06:00:00'  


select e.*, z.naziv, z.hala, z.aktivnost, z.trajanje, z.pocetak, z.kraj, z.napomena
from rfind.dbo.evidnormiradad(@dat1,@dat2) e
left join (
SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   where ( pocetak >=@dat11  and pocetak<=@dat12) ) z on z.hala=e.hala and z.broj=e.linija 

order by radnik

end


else if @id=51111          -- ldp po linijama, dnevni, do 25.1.

begin 
select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
from
(

select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.kolicinaok>0

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 

) r
group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro
order by r.datum,r.hala,r.smjena,r.linija,r.id_pro,r.brojrn
end
---------------------

else if @id=5          -- ldp po linijama, dnevni, od 25.1.2018

begin 

select p.hala halal,p.naziv,x1.*
from feroapp.dbo.proizvodnelinije p 
left join 
(
select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup,tt,napomena
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1, v.obrada3 tt
from
(

select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.obrada3 
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.kolicinaok>0

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 

) r
group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro,r.tt,r.napomena
) x1 on p.hala=x1.hala and p.broj=x1.linija
where p.vrsta='Stroj' --and p.naziv not like '%**%'
order by x1.datum,x1.hala,x1.smjena,x1.linija,x1.id_pro,x1.brojrn


end
---------------------

else if @id>=11 and @id<=13          -- ldp po linijama, smjenski od 25.01.

begin

select p.hala halal,p.naziv,x1.*
from feroapp.dbo.proizvodnelinije p 
left join 
(
select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,r.kolicinaok kolicinaok,r.linija,r.kupac,norma,r.nazivpro,r.cijena,(kolicinaok*r.cijena) kolicina,isnull(r.erv,0) erv,norma1 normukup,obrada3
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
from
(

select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.obrada3
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.smjena=(@id-10)
where e.smjena=(@id-10)

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 

) r
--group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro,r.obrada3 
) x1 on p.hala=x1.hala and p.broj=x1.linija
where p.vrsta='Stroj' --and p.naziv not like '%**%'
order by x1.datum,x1.hala,x1.smjena,x1.linija,x1.id_pro,x1.brojrn


--select p.hala halal,p.naziv,x1.*
--from feroapp.dbo.proizvodnelinije p 
--left join 
--(
--select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup,obrada3
--from (
--select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
--from
--(

--select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.obrada3
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.smjena=(@id-10)

--) v
--left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
--left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

--where v.datum=@dat1 

--) r
--group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro,r.obrada3 
--) x1 on p.hala=x1.hala and p.broj=x1.linija
--where p.vrsta='Linija'
--order by x1.datum,x1.hala,x1.smjena,x1.linija,x1.id_pro,x1.brojrn




--select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,sum(r.kolicinaok) kolicinaok,r.linija,r.kupac,sum(r.norma) norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(isnull(r.erv,0)) erv,sum(norma1) normukup
--from (
--select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
--from
--(

--select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN 
--where smjena=(@id-10)
----where e.kolicinaok>0

--) v
--left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
--left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

--where v.datum=@dat1 

--) r
--group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro
--order by r.datum,r.hala,r.smjena,r.linija,r.id_pro,r.brojrn



---- old
--begin 
--select r.datum,r.hala,r.kolicinaok,r.smjena,r.linija,r.kupac,r.norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,r.napomena,r.planirano
--from (
--select v.*,p.NazivPar kupac,pr.nazivpro
--from
--(

--select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,e.napomena1 napomena,case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
----where e.gotovo=1

--) v
--left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
--left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

--where v.datum=@dat1 and smjena=(@id-10)

--) r
--group by r.datum,r.hala,r.linija,r.nazivpro,r.cijena,r.napomena,r.kolicinaok,r.norma,r.kupac,r.smjena,r.planirano
--order by r.datum,r.hala,r.linija
end

else if @id=1234

--declare @dat1 date='2018-04-11'
--declare @dat2 date='2018-04-11'
--declare @id int=11

begin 
select p.hala halal,p.naziv,x1.*
from feroapp.dbo.proizvodnelinije p 
left join 
(
select r.datum,r.hala,r.id_pro,r.smjena,r.brojrn,r.kolicinaok kolicinaok,r.linija,r.kupac,norma,r.nazivpro,r.cijena,(kolicinaok*r.cijena) kolicina,isnull(r.erv,0) erv,norma1 normukup,obrada3
from (
select v.*,case when vrijemedo>=vrijemeod then datediff(n,vrijemeod,vrijemedo) when vrijemedo<vrijemeod then datediff(n,vrijemeod,vrijemedo)+1440 end  erv,p.NazivPar kupac,pr.nazivpro,480 norma1
from
(

select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.obrada3
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where e.smjena=(@id-10)
where e.smjena=(1)

) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 

) r
--group by r.datum,r.hala,r.linija,r.brojrn,r.nazivpro,r.cijena,r.kupac,r.smjena,r.id_pro,r.obrada3 
) x1 on p.hala=x1.hala and p.broj=x1.linija
where p.vrsta='Linija'
order by x1.datum,x1.hala,x1.smjena,x1.linija,x1.id_pro,x1.brojrn
end



else if @id=500          -- ldp po linijama, dnevni, staro

begin 

select r.datum,r.hala,r.kolicinaok,r.linija,r.kupac,r.norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(planirano) planirano,r.napomena
from (
select v.*,p.NazivPar kupac,pr.nazivpro,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, case when vrijemedo>vrijemeod then datediff(n,vrijemeod,vrijemedo) else datediff(n,vrijemeod,vrijemedo)+1440 end trajanje_erv, case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost,e.napomena1 napomena
from feroapp.dbo.evidencijanormiview e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
left join
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>=@dat1 and  kraj<@dat2

) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1

) r
group by r.datum,r.hala,r.linija,r.nazivpro,r.cijena,r.napomena,r.kolicinaok,r.norma,r.kupac
order by r.datum,r.hala,r.linija

end

else if @id=6          -- pregled štelanja

begin

--declare @dat1 varchar(20)='2017-08-30 06:00'
--declare @dat2 varchar(20)='2017-08-31 06:00'

--select hala,naziv,aktivnost,pocetak,kraj,trajanje_minuta,brojrn,napomena,username,nazivpar,vrstanarudzbe, cast(  b.norma*(trajanje_minuta/(420+0.001)) as integer) izgubljeno
select hala,naziv,aktivnost,pocetak,kraj,trajanje_minuta,brojrn,napomena,username,nazivpar,vrstanarudzbe, 0 izgubljeno
from(

select a.*,p.NazivPar,n.id_pro,pn.norma
from (
SELECT pl.hala,pl.Naziv,pl.broj, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost not like '%ŠTEL%'
where aktivnost not like '%999%'
and (pocetak >=@dat1  and pocetak <=@dat2)
) a
left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
left join feroapp.dbo.narudzbesta n on n.brojrn=a.brojrn
left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pn.hala=a.hala and pn.linija=a.broj
) b
order by b.nazivpar,b.hala,b.Naziv


--select a.*,p.NazivPar
--from (
--SELECT pl.hala,pl.Naziv, pla.aktivnost,pla.pocetak,pla.kraj,datediff(n,pocetak,kraj) trajanje_minuta,pla.BrojRN,pla.Napomena,pla.UserName, (SELECT NZ.ID_Par FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS Kupac ,(SELECT NZ.vrstanar FROM feroapp.dbo.NarudzbeZag NZ WHERE NZ.ID_NarZ = (SELECT NS.ID_NarZ FROM feroapp.dbo.NarudzbeSta NS WHERE NS.BrojRN = PLA.BrojRN)) AS vrstanarudzbe 
--FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLA 
--LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLA.ID_PLI = PL.ID_PLI 
--where aktivnost like '%ŠTEL%'
--and (pocetak >=@dat1  and pocetak <=@dat2)
--) a
--left join feroapp.dbo.partneri p on p.ID_Par=a.kupac
----group by p.nazivpar,a.vrstanarudzbe,a.hala,a.naziv
--order by p.nazivpar,a.hala,a.Naziv
--end
end


else if @id=61111          -- pregled linija koje ne rade,dsr, do 25.01.

begin

select x1.kupac,vrstanarudzbe,count(*) broj_linija
from (
select distinct linija,kupac,VrstaNarudzbe
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where kolicinaok=0
) x1
group by kupac,VrstaNarudzbe
end

else if @id=61          -- pregled linija koje ne rade,dsr

begin

select 'A' hala,kupac,id_par,vrstanarudzbe,count(*) broj_linija
from (
select distinct x1.parent_pli,x1.halal,x1.hala,x1.kupac,x1.id_par,x1.VrstaNarudzbe
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.hala is null  and linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and p.parent_pli not in ( 71,72)
and e.obrada3=0
) x1

union all

select distinct x1.parent_pli,x1.halal,x1.hala,x1.kupac,x1.id_par,x1.VrstaNarudzbe
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.hala is not null  and linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and p.parent_pli not in ( 71,72)
and e.obrada3=0
) x1 

inner join (

select kupac, id_par,parent_pli,hala,count(*) broj
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
inner join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.kolicinaok=0  and linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0
and p.parent_pli not in ( 71,72)

) x1
group by kupac,id_par, parent_pli,hala
having count(*)=3
) x2 on x2.id_par=x1.id_par and x2.parent_pli=x1.parent_pli and x2.hala=x1.hala
) x3
group by kupac,id_par,VrstaNarudzbe

end

else if @id=610          -- pregled linija koje ne rade,dsr, po pogonima

begin

select hala,kupac,id_par,vrstanarudzbe,count(*) broj_linija
from (
select distinct x1.parent_pli,x1.halal,x1.hala,x1.kupac,x1.id_par,x1.VrstaNarudzbe
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.hala is null  and linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0
and p.parent_pli not in ( 71,72)
) x1

union all

select distinct x1.parent_pli,x1.halal,x1.hala,x1.kupac,x1.id_par,x1.VrstaNarudzbe
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
left join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.hala is not null and  linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0
) x1 

inner join (

select kupac, id_par,parent_pli,hala,count(*) broj
from (
select p.parent_pli,p.hala halal,e.*
from feroapp.dbo.proizvodnelinije p
inner join feroapp.dbo.evidnormi( @dat1, @dat2 , 0 ) e on p.broj=e.linija and p.hala=e.hala
where p.Vrsta='Stroj' and e.kolicinaok=0  and linija  not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and p.parent_pli not in ( 71,72)
and e.obrada3=0
) x1
group by kupac, id_par,parent_pli,hala
having count(*)=3
) x2 on x2.id_par=x1.id_par and x2.parent_pli=x1.parent_pli and x2.hala=x1.hala
) x3
group by kupac,id_par,hala,VrstaNarudzbe

end



else if @id=7          -- pregled odsustva

begin 

select datum,count(*) broj, 'Bolovanje' vrsta
from pregledvremena
where datum=@dat1
and radnomjesto in ('BO','B.O.','BO2') and hala not in ('Režija')
GROUP BY DATUM
UNION ALL
select datum,count(*) broj, 'GO' vrsta
from pregledvremena
where datum=@dat1
and radnomjesto in ('GO','G.O.') and hala not in ('Režija')
GROUP BY DATUM
union all
select datum,count(*) broj,'Ostalo' vrsta
from pregledvremena
where datum=@dat1 AND radnomjesto not in ('4. SMJENA') 
and dosao=otisao AND YEAR(DOSAO)=1900 AND radnomjesto NOT in ('BO','B.O.','BO2','go','G.O.','GO') and hala not in ('Režija')
GROUP BY DATUM

end

else if @id=71         -- pregled odsustva, popis imena

begin

select x1.*, mt.naziv mtroska
from(
select pv.datum,r.prezime,r.ime,r.mt ,pv.radnomjesto linija,pv.smjena,pv.hala, case when pv.radnomjesto in  ('BO','B.O.','BO2') then 'Bolovanje' when pv.radnomjesto in  ('GO','G.O.') then 'Godišnji' when pv.radnomjesto not in  ('BO','B.O.','GO','G.O.','4. SMJENA') then 'Nije došao'end vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE PV.OTISAO=PV.DOSAO and year(pv.dosao)=1900
and datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') 
UNION ALL
select pv.datum,r.prezime,r.ime,r.mt,pv.radnomjesto linija,pv.smjena,pv.hala, ('Kasni '+cast( pv.kasni as varchar)+' minuta, dosao u '+cast( pv.dosao as varchar)) vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') AND PV.kasni>0
) x1
left join MjestoTroska mt on mt.id=x1.mt
where x1.hala<>'Režija'
order by x1.hala,x1.Smjena,x1.linija
end

else if @id=77    -- lager gotove robe

begin
	 select sum(komada) ukupno

	 from(
select case when zavrsnaobrada='Tokarenje' then spremnot_pro
            when zavrsnaobrada='Kaljenje' then  spremnok_pro
			when zavrsnaobrada='Tvrdo tokarenje' then spremnott_pro
			when zavrsnaobrada='Brušenje' then spremnobr_pro
			end komada
from(
      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN, (SELECT NarudzbeDetaljnoView.OrderNo FROM NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 
      (SELECT NarudzbeSta.ID_NarZ FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Prsteni', 'Neisporuceno', 0) 
      WHERE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Par = 274 
      AND (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 
      UNION ALL
      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN, (SELECT NarudzbeDetaljnoView.OrderNo FROM NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 
      (SELECT NarudzbeSta.ID_NarZ FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Prsteni', 'Neisporuceno', 1) 
      WHERE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Par = 274 
      AND (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 
	  ) x1
 	  )x2
 end
	   
else if @id=72         -- pregled odsustva, popis imena

begin

select count(*) broj,x1.vrsta, mt.naziv mtroska
from(

select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala, case when pv.radnomjesto in  ('BO','B.O.','BO2') then 'Bolovanje' when pv.radnomjesto in  ('GO','G.O.') then 'Godišnji' when pv.radnomjesto not in  ('BO','B.O.','GO','G.O.','4. SMJENA') then 'Nije došao'end vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE PV.OTISAO=PV.DOSAO and year(pv.dosao)=1900
and datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') 
and hala not in ('Režija','Zona')
UNION ALL

select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala, ('Kasni '+cast( pv.kasni as varchar)+' minuta, dosao u '+cast( pv.dosao as varchar)) vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') AND PV.kasni>0
and hala not in ('Režija','Zona')
) x1
left join MjestoTroska mt on mt.id=x1.mt
group by mt.naziv,x1.vrsta
order by mt.naziv,x1.vrsta
end

else if @id=720         -- pregled odsustva, popis imena, po halama

begin

select count(*) broj,x1.vrsta, mt.naziv mtroska,hala
from(
select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala, case when pv.radnomjesto in  ('BO','B.O.','BO2') then 'Bolovanje' when pv.radnomjesto in  ('GO','G.O.') then 'Godišnji' when pv.radnomjesto not in  ('BO','B.O.','GO','G.O.','4. SMJENA') then 'Nije došao'end vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE PV.OTISAO=PV.DOSAO and year(pv.dosao)=1900
and datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') 
UNION ALL
select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala, ('Kasni '+cast( pv.kasni as varchar)+' minuta, dosao u '+cast( pv.dosao as varchar)) vrsta
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') AND PV.kasni>0
) x1
left join MjestoTroska mt on mt.id=x1.mt
where hala not in ('Režija','Zona')
group by mt.naziv,x1.vrsta,x1.hala
order by mt.naziv,x1.vrsta
end


	   
else if @id=73         -- pregled prisustva, popis imena

begin

select count(*) broj, mt.naziv mtroska
from(

select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE year(pv.dosao)!=1900
and datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') and pv.hala in ('1','3','Zona')
) x1
left join MjestoTroska mt on mt.id=x1.mt
group by mt.naziv

union all

select broj, 'Ukupno' mtroska
from (

select count(*) broj
from radnici_ 
where neradi=0 and mt in ( 700,702,712,710,713,716,701)

) x2


end

else if @id=730         -- pregled prisustva, popis imena, po halama

begin

select count(*) broj, hala , mt.naziv mtroska
from(

select pv.datum,r.prezime,r.ime,pv.radnomjesto linija,r.mt,pv.smjena,pv.hala
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
WHERE year(pv.dosao)!=1900
and datum=@dat1 AND pv.radnomjesto not in ('4. SMJENA') 
) x1
left join MjestoTroska mt on mt.id=x1.mt
group by mt.naziv,hala

union all

select broj, hala,'Ukupno' mtroska 
from (

select count(*) broj,case when lokacija='500' then '1' when lokacija='603' then '3' else '' end hala
from radnici_ 
where neradi=0 and mt in ( 700,702,712,710,713,716,701)
group by lokacija

) x2


end

else if @id=1120  -- proizvedena količina i vrijednost, dnevni izvjesta za sve hale

begin
--declare @datum1 date
--declare @datum2 date

--set @datum1='2017-12-10'
--set @datum2='2017-12-10';

    WITH MyTmpTable1 AS(
      SELECT NarZ.ID_Par,ens.linija, ENZ.Datum, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
        Proizvodi.ID_Pro, Proizvodi.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN,nars.CijenaObrada1,CijenaObrada2,CijenaObrada3
        FROM feroapp.dbo.EvidencijaNormiSta ENS 
            INNER JOIN feroapp.dbo.EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
            INNER JOIN feroapp.dbo.NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
            INNER JOIN feroapp.dbo.NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
            INNER JOIN feroapp.dbo.Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
        WHERE ENZ.Datum BETWEEN @Dat1 AND @Dat2
            AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1 )


		select sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada1) vrijednost,vrstapro,NazivPar kupac,'TOK' vo
			from mytmptable1 t1
			left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
			where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
			group by nazivpar,vrstapro
			union all
			select sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada2) vrijednost,vrstapro,NazivPar kupac,'DO' vo
			from mytmptable1 t1
			left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
			where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
			group by nazivpar,vrstapro
			order by nazivpar


			
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
) x1
group by VrstaNarudzbe,kupac
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
) x1
group by VrstaNarudzbe,kupac


end

else if @id=112  -- proizvedena količina i vrijednost, dnevni izvjesta za sve hale

begin
--declare @datum1 date
--declare @datum2 date

--set @datum1='2017-12-10'
--set @datum2='2017-12-10';

  --  WITH MyTmpTable1 AS(
  --    SELECT NarZ.ID_Par,ens.linija, ENZ.Datum, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
  --      Proizvodi.ID_Pro, Proizvodi.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN,nars.CijenaObrada1,CijenaObrada2,CijenaObrada3,(ens.obradaa*ISNULL(nars.CijenaObrada1,0)+ens.obradab*ISNULL(nars.CijenaObrada1b,0)+ens.obradaC*ISNULL(nars.CijenaObrada1C,0)) CIJENA
  --      FROM feroapp.dbo.EvidencijaNormiSta ENS 
  --          INNER JOIN feroapp.dbo.EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
  --          INNER JOIN feroapp.dbo.NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
  --          INNER JOIN feroapp.dbo.NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
  --          INNER JOIN feroapp.dbo.Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
  --      WHERE ENZ.Datum BETWEEN @Dat1 AND @Dat2
  --          AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1 )


		--select sum(kolicinaok) kolicina,sum(kolicinaok*cijena) vrijednost,vrstapro,NazivPar kupac,'TOK' vo
		--	from mytmptable1 t1
		--	left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
		--	where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3')
		--	group by nazivpar,vrstapro
		--	union all
		--	select sum(kolicinaok) kolicina,sum(kolicinaok*cijena) vrijednost,vrstapro,NazivPar kupac,'DO' vo
		--	from mytmptable1 t1
		--	left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
		--	where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3')
		--	group by nazivpar,vrstapro
		--	order by nazivpar

-- količina

select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0 
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') or e.obrada3 =1)
--and e.obrada3=0 and e.gotovo=1
) x1
group by VrstaNarudzbe,kupac,id_par
order by id_par

end

else if @id=1121   -- vrijednost

begin

select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'TOK' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0) +isnull(n.CijenaObrada1d,0)*isnull(e.Obradad,0)+isnull(n.CijenaObrada1e,0)*isnull(e.Obradae,0) +isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
) x1
group by VrstaNarudzbe,kupac,id_par
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,VrstaNarudzbe vrstapro,kupac,'DO' vo,id_par
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0) +isnull(n.CijenaObrada1d,0)*isnull(e.Obradad,0)+isnull(n.CijenaObrada1e,0)*isnull(e.Obradae,0) +isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
) x1
group by VrstaNarudzbe,kupac,id_par


end

else if @id=113  -- proizvedena količina po halama

begin
--declare @datum1 date
--declare @datum2 date

--set @datum1='2017-12-10'
--set @datum2='2017-12-10';

  --  WITH MyTmpTable1 AS(
  --    SELECT hala,NarZ.ID_Par,ens.linija, ENZ.Datum, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
  --      Proizvodi.ID_Pro, Proizvodi.VrstaPro, CAST(ISNULL(ENS.KolicinaOK, 0) AS int) AS KolicinaOK, ENS.BrojRN,nars.CijenaObrada1,CijenaObrada2,CijenaObrada3
  --      FROM feroapp.dbo.EvidencijaNormiSta ENS 
  --          INNER JOIN feroapp.dbo.EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
  --          INNER JOIN feroapp.dbo.NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
  --          INNER JOIN feroapp.dbo.NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
  --          INNER JOIN feroapp.dbo.Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
  --      WHERE ENZ.Datum BETWEEN @Dat1 AND @Dat2
  --          AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1 )


		--select hala,sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada1) vrijednost,vrstapro,NazivPar kupac,'TOK' vo
		--	from mytmptable1 t1
		--	left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
		--	where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3')
		--	group by hala,nazivpar,vrstapro
		--	union all
		--	select hala,sum(kolicinaok) kolicina,sum(kolicinaok*cijenaobrada2) vrijednost,vrstapro,NazivPar kupac,'DO' vo
		--	from mytmptable1 t1
		--	left join feroapp.dbo.partneri p on p.ID_Par=t1.ID_Par
		--	where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3')
		--	group by hala,nazivpar,vrstapro
		--	order by nazivpar

		
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,hala,VrstaNarudzbe vrstapro,id_par,kupac,'TOK' vo
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
and e.obrada3=0 
) x1
group by VrstaNarudzbe,kupac,id_par,hala
union all
select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,hala,VrstaNarudzbe vrstapro,id_par,kupac,'DO' vo
from (
select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  +isnull(e.CijenaObradad,0)*isnull(e.Obradad,0)+isnull(e.CijenaObradae,0)*isnull(e.Obradae,0)+isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
where ( linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') or e.obrada3=1 )
) x1
group by VrstaNarudzbe,kupac,id_par,hala
end

--else if @id=1131         -- vrijednost po halama

--begin
--select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,hala,VrstaNarudzbe vrstapro,kupac,'TOK' vo
--from (
--select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','INDEX','VC510','GT600-5')
--) x1
--group by VrstaNarudzbe,kupac,hala
--union all
--select sum(x1.kolicinaok) kolicina,sum(x1.kolicinaok*x1.cijena) vrijednost,hala,VrstaNarudzbe vrstapro,kupac,'DO' vo
--from (
--select e.datum,e.VrijemeOd,e.brojrn,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(e.CijenaObradaa,0)*isnull(e.Obradaa,0)+isnull(e.CijenaObradab,0)*isnull(e.Obradab,0)+isnull(e.CijenaObradac,0)*isnull(e.Obradac,0)  ++isnull(e.CijenaObrada3,0)*isnull(e.Obrada3,0) ) cijena,  e.id_par,e.radnik,e.napomena1 napomena,e.VrstaNarudzbe,Kupac
--from feroapp.dbo.evidnormi(@dat1,@dat2,0) e
--left join feroapp.dbo.narudzbesta n on n.brojrn=e.BrojRN
--where linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5')
--) x1
--group by VrstaNarudzbe,kupac,hala


--end
else if @id=100         -- pregled godisnjih,bolovanja,neopravdano
-- @dat1 = '7.2017
-- @dat2 = radnikid
-- @id = tip izvjestaja

begin
declare @mjes as int
declare @god as int
declare @rid as int
set @mjes = cast( SUBSTRING(@dat1, 1, CHARINDEX('.', @dat1)-1)  as integer)
set @god = cast( SUBSTRING(@dat1, CHARINDEX('.', @dat1) + 1, 1000)  as integer)
set @rid = cast(@dat2 as integer)

print @mjes
print @god
print @rid

select *
from fxsap.dbo.plansatirada
where mjesec=@mjes and godina=@god
and radnikid=@rid

--select count(*) broj ,'Bolovanja' vrsta
--from fxsap.dbo.plansatirada
--where mjesec=@mjes and godina=@god
--and (dan01='8b' or dan02='8b' or dan03='8b' or dan04='8b' or dan05='8b' or dan06='8b' or  dan07='8b' or dan08='8b' or dan09='8b' or dan10='8b' or dan11='8b' or dan12='8b' or  
--dan13='8b' or dan14='8b' or dan15='8b' or dan16='8b' or dan17='8b' or dan18='8b' or  dan19='8b' or dan20='8b' or dan21='8b' or dan22='8b' or dan23='8b' or dan24='8b' or  
--dan25='8b' or dan26='8b' or dan27='8b' or dan28='8b' or dan29='8b' or dan30='8b' or  dan31='8b' )
--and radnikid=@rid
--union all
--select count(*) broj ,'Godisnji' vrsta
--from fxsap.dbo.plansatirada
--where mjesec=@mjes and godina=@god
--and (dan01 in ('7g','5g') or dan02 in ('7g','5g') or dan03 in ('7g','5g') or dan04 in ('7g','5g') or dan05 in ('7g','5g') or dan06 in ('7g','5g') or  dan07 in ('7g','5g') or dan08 in ('7g','5g') or dan09 in ('7g','5g') or dan10 in ('7g','5g') or dan11 in ('7g','5g') or dan12 in ('7g','5g') or  
--dan13 in ('7g','5g') or dan14 in ('7g','5g') or dan15 in ('7g','5g') or dan16 in ('7g','5g') or dan17 in ('7g','5g') or dan18 in ('7g','5g') or  dan19 in ('7g','5g') or dan20 in ('7g','5g') or dan21 in ('7g','5g') or dan22 in ('7g','5g') or dan23 in ('7g','5g') or dan24 in ('7g','5g') or  
--dan25 in ('7g','5g') or dan26 in ('7g','5g') or dan27 in ('7g','5g') or dan28 in ('7g','5g') or dan29 in ('7g','5g') or dan30 in ('7g','5g') or  dan31 in ('7g','5g') )
--and radnikid=@rid
--union all
--select count(*) broj ,'Neopravdano' vrsta
--from fxsap.dbo.plansatirada
--where mjesec=@mjes and godina=@god
--and (dan01 in ('0e') or dan02 in ('0e') or dan03 in ('0e') or dan04 in ('0e') or dan05 in ('0e') or dan06 in ('0e') or  dan07 in ('0e') or dan08 in ('0e') or dan09 in ('0e') or dan10 in ('0e') or dan11 in ('0e') or dan12 in ('0e') or  
--dan13 in ('0e') or dan14 in ('0e') or dan15 in ('0e') or dan16 in ('0e') or dan17 in ('0e') or dan18 in ('0e') or  dan19 in ('0e') or dan20 in ('0e') or dan21 in ('0e') or dan22 in ('0e') or dan23 in ('0e') or dan24 in ('0e') or  
--dan25 in ('0e') or dan26 in ('0e') or dan27 in ('0e') or dan28 in ('0e') or dan29 in ('0e') or dan30 in ('0e') or  dan31 in ('0e') )
--and radnikid=@rid
end


else if @id=109   -- LGR , komada i vrijednost
begin
DECLARE @TmpGodina smallint, @TmpKvartal tinyint;

SET @TmpGodina = year( @dat1) ;

SET @TmpKvartal = datepart(q, @dat1) ;

WITH MyTmpTable1 AS(
SELECT SPL.ID_Par, SPL.Narucitelj, SPL.VrstaNar, SPL.VlasnistvoFX, SPL.Bazni_RN, SPL.Zavrsni_RN, SPL.ZavrsnaObrada, SPL.ID_Mat, SPL.OmjerPro, 
       (CASE SPL.ZavrsnaObrada WHEN 'Obrada #5' THEN SPL.ID_Pro_O5 WHEN 'Brusenje' THEN SPL.ID_Pro_BR WHEN 'Tvrdo tokarenje' THEN SPL.ID_Pro_TT WHEN 'Kaljenje' THEN SPL.ID_Pro_K ELSE SPL.ID_Pro_T END) AS ID_Pro, 
       (CASE SPL.ZavrsnaObrada WHEN 'Obrada #5' THEN SPL.SpremnoO5_Pro WHEN 'Brusenje' THEN SPL.SpremnoBR_Pro WHEN 'Tvrdo tokarenje' THEN SPL.SpremnoTT_Pro WHEN 'Kaljenje' THEN SPL.SpremnoK_Pro ELSE SPL.SpremnoT_Pro END) AS Spremno_kom 
       FROM feroapp.dbo.StanjeProizvodnjeList('*', 'Neisporuceno') SPL),
MyTmpTable2 AS(
SELECT *, 
       (SELECT TOP 1 FC.FakturnaCijena FROM (SELECT CAST((CASE @TmpKvartal WHEN 1 THEN FCP.CijenaProQ1 WHEN 2 THEN FCP.CijenaProQ2 WHEN 3 THEN FCP.CijenaProQ3 ELSE FCP.CijenaProQ4 END) AS float) AS FakturnaCijena FROM feroapp.dbo.FakturneCijeneProizvoda FCP WHERE FCP.Godina = @TmpGodina AND FCP.ID_Pro_Kup = (SELECT PRO.ID_Pro_Kup FROM feroapp.dbo.Proizvodi PRO WHERE PRO.ID_Pro = MTT1.ID_Pro) AND FCP.ID_Mat_Dob = (SELECT MAT.ID_Mat_Dob FROM feroapp.dbo.Materijali MAT WHERE MAT.ID_Mat = MTT1.ID_Mat)
                                                                     UNION ALL
                                                                     SELECT CAST((CASE @TmpKvartal WHEN 1 THEN FCP.CijenaProQ1 WHEN 2 THEN FCP.CijenaProQ2 WHEN 3 THEN FCP.CijenaProQ3 ELSE FCP.CijenaProQ4 END) AS float) AS FakturnaCijena FROM feroapp.dbo.FakturneCijeneProizvoda FCP WHERE FCP.Godina = @TmpGodina AND FCP.ID_Pro_Kup = (SELECT PRO.ID_Pro_Kup FROM feroapp.dbo.Proizvodi PRO WHERE PRO.ID_Pro = MTT1.ID_Pro)) FC) AS FakturnaCijena
       FROM MyTmpTable1 MTT1 WHERE Spremno_kom > 0) 

select id_par,sum(spremno_kom) komada,sum(spremno_kom*cijena) vrijednost,vrstanar
from(
select x1.id_par,vrstanar,x1.spremno_kom,isnull(x1.fakturnacijena , x1.cijenaobrade) cijena   -- cijena bez materijala
--select x1.id_par,vrstanar,x1.spremno_kom,isnull(x1.fakturnacijena,x1.vlasnistvofx*x1.cijenamat_kom+x1.cijenaobrade) cijena   -- cijena sa materijalom
from (
SELECT MTT2.ID_Par, MTT2.Narucitelj, MTT2.VrstaNar, MTT2.VlasnistvoFX, MTT2.Bazni_RN, MTT2.Zavrsni_RN, MTT2.ZavrsnaObrada, MTT2.ID_Mat, MTT2.ID_Pro, MTT2.Spremno_kom, (CASE WHEN ISNULL(NS.FakturnaCijena, 0) = 0 THEN MTT2.FakturnaCijena ELSE CAST(NS.FakturnaCijena AS float) END) AS FakturnaCijena, 
       ((ISNULL(NS.Obrada1, 0) * ISNULL(NS.CijenaObrada1, 0)) + (ISNULL(NS.Obrada2, 0) * ISNULL(NS.CijenaObrada2, 0)) + (ISNULL(NS.Obrada3, 0) * ISNULL(NS.CijenaObrada3, 0)) + (ISNULL(NS.Obrada4, 0) * ISNULL(NS.CijenaObrada4, 0)) + (ISNULL(NS.Obrada5, 0) * ISNULL(NS.CijenaObrada5, 0))) AS CijenaObrade, 
       (SELECT TOP 1 CAST(ULR.CijenaKom / MTT2.OmjerPro AS float) FROM feroapp.dbo.UlazRobe ULR WHERE ULR.ID_MAT = MTT2.ID_Mat ORDER BY ULR.ID_ULR DESC) AS CijenaMat_kom 
       FROM MyTmpTable2 MTT2 
             LEFT JOIN feroapp.dbo.NarudzbeSta NS ON MTT2.Bazni_RN = NS.BrojRN 
       WHERE MTT2.VrstaNar IN('Prsteni', 'Zupcanici', 'Kucista', 'Valjcici')  ) x1
	   ) x2
	   group by id_par,vrstanar
end


else if @id=110         -- Lager gotove robe

begin 

declare @kupac as int
set @kupac = cast(@dat1 as integer)

	 select sum(komada) komada,id_par,vrstan
	 from(
select case when zavrsnaobrada='Tokarenje' then spremnot_pro
            when zavrsnaobrada='Kaljenje' then  spremnok_pro
			when zavrsnaobrada='Tvrdo tokarenje' then spremnott_pro
			when zavrsnaobrada='Brušenje' then spremnobr_pro
			end komada,id_par,vrstan
from(

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Prsteni' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Prsteni', 'Neisporuceno', 0) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

      UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Prsteni' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Prsteni', 'Neisporuceno', 1) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

	  union all
	 -- valjcici
	  SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Valjcici' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Valjcici', 'Neisporuceno', 0) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

      UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Valjcici' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Valjcici', 'Neisporuceno', 1) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

	  UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Kucista' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Kucista', 'Neisporuceno', 0) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

	  UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Kucista' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Kucista', 'Neisporuceno', 1) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

      UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Zupcanici' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Zupcanici', 'Neisporuceno', 0) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

	  UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Zupcanici' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Zupcanici', 'Neisporuceno', 1) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Puse' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Puse', 'Neisporuceno', 0) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 

	  UNION ALL

      SELECT feroapp.dbo.StanjeProizvodnjeListPrepak.Bazni_RN,id_par, (SELECT NarudzbeDetaljnoView.OrderNo FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Narudzba, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Mat, 'Puse' vrstan,
      (SELECT NarudzbeSta.ID_NarZ FROM feroapp.dbo.NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS NarudzbaFull, 
      (SELECT Proizvodi.NazivPro FROM feroapp.dbo.Proizvodi WHERE feroapp.dbo.Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)) AS Proizvod, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.BaznaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeT_kg, feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pak, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeK_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeTT_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje , feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pak, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.PakiranjeBR_kg, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.KolicinaNar, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoK_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoTT_Pro, feroapp.dbo.StanjeProizvodnjeListPrepak.IsporucenoBR_Pro, 
      ISNULL((SELECT Proizvodi.TezinaPro FROM feroapp.dbo.Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_K WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_TT WHEN feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada = 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_BR ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.ID_Pro_T END)),0) AS TezinaProKom, 
      feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, 
      (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
      (SELECT max(s.datum) FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z left join feroapp.dbo.EvidencijaProizvodnjeSta s on s.ID_EPZ=z.ID_EPZ where BrojRN = (CASE feroapp.dbo.StanjeProizvodnjeListPrepak.ZavrsnaObrada WHEN 'Brusenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Kaljenje ELSE feroapp.dbo.StanjeProizvodnjeListPrepak.RN_Tokarenje END)) AS Datumproizvodnje, 
      DatumIsporuke 
      FROM feroapp.dbo.StanjeProizvodnjeListPrepak('Puse', 'Neisporuceno', 1) 
      WHERE (feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoK_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoTT_Pro <> 0 OR feroapp.dbo.StanjeProizvodnjeListPrepak.SpremnoBR_Pro <> 0) 



	  ) x1
      --ORDER BY feroapp.dbo.StanjeProizvodnjeListPrepak.VlasnistvoFX, Proizvod
	  )x2
	  group by id_par,vrstan

end


-- planiranje share 
-- 2019-03-04
-- izvještaj za Tonija po danima
else if @id=998
begin

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'TOK' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)    --BDF
and linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') and obrada3=0
) x1
group by datum,kupac,id_par

UNION ALL

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'DO' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)    --BDF
and (linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')  or linija like '09%')
) x1
group by datum,kupac,id_par

union all

-- sona sve hale
select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'TOK' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where id_par in ( 121301)  -- SONA
and linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') and obrada3=0
) x1
group by datum,kupac,id_par

UNION ALL

select datum,kupac,id_par,sum(kolicinaok) kolicina,cast( sum(cijena) as float)  vrijednost,'DO' VO
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where id_par in ( 121301)  -- SONA
and linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4')
) x1
group by datum,kupac,id_par
order by datum,kupac

end

-- planiranje share 
-- 2019-03-04
-- izvještaj za Tonija po mjesecima

else if @id=999

begin
select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'TOK' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)             --BDF
and linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') and obrada3=0
) x1
group by year(datum)*100+month(datum),kupac,id_par

UNION ALL

select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'DO' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where hala=3 and id_par in ( 274,121278)             --BDF
and (linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') OR obrada3=1 or linija like '09%')
) x1
group by year(datum)*100+month(datum),kupac,id_par


union all
-- sona sve hale
select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'TOK' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where id_par in (121301)					-- SONA
and (linija not in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') and obrada3=0)
) x1
group by year(datum)*100+month(datum),kupac,id_par

UNION ALL

select year(datum)*100+month(datum) ggggmm,sum(kolicinaok) kolicina,kupac,id_par,cast( sum(cijena) as float) vrijednost, 'DO' vo
from (
select datum,kolicinaok,kupac,id_par,kolicinaok*( obrada3*CijenaObrada3+obradaa*cijenaobradaa+obradab*CijenaObradaB+obradac*CijenaObradaC+obradad*CijenaObradaD+obradae*CijenaObradaE+obradaf*CijenaObradaF+obradag*CijenaObradaG+obradah*CijenaObradaH) cijena
from feroapp.dbo.evidnormi(@dat1,@dat2,0)
where id_par in (121301)					-- SONA
and linija in ('HURCO','VC510','INDEX','GT600-1','GT600-2','GT600-3','EMAG','GT600-4','GT600-5','Pila1','Pila2','Pila3','Pila4') and obrada3=0
) x1
group by year(datum)*100+month(datum),kupac,id_par
order by year(datum)*100+month(datum),kupac


end


else if @id>1000          -- ldp po linijama, smjenski,staro
begin 

declare @smj int = @id-10
print 'tewtrewtrew'


select r.datum,r.hala,r.kolicinaok,r.smjena,r.linija,r.kupac,r.norma,r.nazivpro,r.cijena,sum(kolicinaok*r.cijena) kolicina,sum(planirano) planirano,r.napomena
from (
select v.*,p.NazivPar kupac,pr.nazivpro,round((v.norma/480.00*trajanjezastoja),0) nedostajekomada, case when vrijemedo>vrijemeod then datediff(n,vrijemeod,vrijemedo) else datediff(n,vrijemeod,vrijemedo)+1440 end trajanje_erv, case when vrijemedo > vrijemeod then (datediff(n,vrijemeod,vrijemedo)*norma/480 ) else  ((1440+datediff(n,vrijemeod,vrijemedo))*norma/480 ) end planirano
from
(
select e.datum,e.VrijemeOd,e.VrijemeDo,e.hala,e.id_pro,e.smjena,e.linija,e.norma,e.kolicinaok,(isnull(n.CijenaObrada1,0)*isnull(e.Obradaa,0)+isnull(n.CijenaObrada2,0)*isnull(e.Obradab,0)+isnull(n.CijenaObrada3,0)*isnull(e.Obradac,0)*0) cijena,  e.id_par,e.radnik,z.trajanje trajanjezastoja,z.aktivnost,e.napomena1 napomena
from feroapp.dbo.evidencijanormiview e
left join feroapp.dbo.narudzbesta n on n.brojrn1=e.BrojRN
left join
(

SELECT PL.Naziv, PL.Hala,pl.broj, PLIA.* , datediff(n,pocetak,kraj) trajanje,pn.norma,n.id_pro
FROM feroapp.dbo.ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN feroapp.dbo.ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
	   left join feroapp.dbo.narudzbesta n on n.brojrn1=plia.brojrn
	   left join feroapp.dbo.proizvodnenorme pn on pn.id_pro=n.id_pro and pl.hala=pn.hala and pl.broj=pn.Linija
	   where pocetak>=@dat1 and  kraj<@dat2

) z on z.hala=e.hala and z.broj=e.linija and e.id_pro=z.id_pro
) v
left join feroapp.dbo.partneri p on p.ID_Par=v.id_par
left join feroapp.dbo.proizvodi pr on pr.ID_pro=v.id_pro

where v.datum=@dat1 and v.smjena=@smj

) r
group by r.datum,r.hala,r.linija,r.nazivpro,r.cijena,r.napomena,r.kolicinaok,r.norma,r.kupac,r.smjena
order by r.datum,r.hala,r.linija

end


end
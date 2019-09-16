declare @dan1 varchar(7)
declare @mjesec1 varchar(2)
declare @godina1 varchar(4)
declare @datum1 varchar(16)
declare @sql1 varchar(350)
declare @sql2 varchar(850)
declare @sql3 varchar(850)
declare @sql4 varchar(950)
declare @sql5 varchar(950)
declare @sql6 varchar(290)
set @datum1 = '2019-09-9'
set @dan1 = 'dan09'
set @mjesec1='9'
set @godina1='2019'

--set @sql3='select neradi,firma,mt,radnikid,ime,'+@dan1+',dosao,otisao,ukupno_minuta,sati,smjena,RadnoMjesto from (select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.'+@dan1+',v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto from  fxsap.dbo.plansatirada2 p inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='''+@datum1+''' where mjesec='+@mjesec1+' and godina='+@godina1+' and v.ukupno_minuta>60 and r1.username=''sbiscan'' and p.mt not in ( 702,710,713,704) ) x1 where sati>8 order by ime'
--print @sql3
--execute (@sql3)


---------------------------------------------
-- nije 1% i nije 0e
---------------------------------
set @sql1='select 1 tip,firma,radnikid,ime,mt,'+@dan1+', v.ukupno_minuta/60 sati,v.dosao,v.otisao,v.smjena,v.radnomjesto from fxsap.dbo.plansatirada p left join rfind.dbo.pregledvremena v on p.radnikid=v.idradnika and v.datum='+quotename(@datum1,'''')+' where mjesec='+@mjesec1+' and godina='+@godina1+' and '+@dan1+'  not like ''1%'' and '+@dan1+' not in ( ''0j'',''7g'',''8b'',''0e'',''5g'')'
print @sql1
execute (@sql1)
-------------------------------------
--   ima upisano 0e ili null i došao
-------------------------------------
set @sql2='select 2 tip,p.firma,p.radnikid,p.ime,p.mt,p.'+@dan1+',v.dosao,v.otisao,v.ukupno_minuta/60 sati,v.smjena,v.radnomjesto from  fxsap.dbo.plansatirada p left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='''+@datum1+ ''' where mjesec='+@mjesec1+' and godina='+@godina1+' and ( year(v.dosao)!=1900 or v.ukupno_minuta>60 ) and p.mt not in ( 710,713,704) and ( p.'+@dan1+' is null or p.'+@dan1+' =''0e'') order by ime'
print @sql2
execute (@sql2)
--------------------------------
--  radio više od 8 sati ili je upisano 1j:1p etc.
--------------------------------
set @sql3='select 3 tip,firma,radnikid,ime,mt,'+@dan1+',dosao,otisao,sati,smjena,RadnoMjesto,napomena,''Radili više od 8 sati'' vrsta from (select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.'+@dan1+',v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto,v.napomena,v.hala from  fxsap.dbo.plansatirada p  left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='''+@datum1+''' where mjesec='+@mjesec1+' and godina='+@godina1+' and v.ukupno_minuta>60 and p.sifrarm!=''Režija'' and p.mt not in ( 710,713,704) ) x1 where sati>8  or ( '+@dan1+'=''1j:1p'' OR '+@dan1+'=''1j:1n'' OR '+@dan1+'=''1p:1n'') order by ime'
--set @sql3='select neradi,firma,mt,radnikid,ime,'+@dan1+',dosao,otisao,ukupno_minuta,sati,smjena,RadnoMjesto from (select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.'+@dan1+',v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto from  rfind.dbo.plansatirada2 p inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='''+@datum1+''' where mjesec='+@mjesec1+' and godina='+@godina1+' and v.ukupno_minuta>60 and r1.username=''sbiscan'' and p.mt not in ( 702,710,713,704) ) x1 where sati>8 order by ime'
print @sql3
execute (@sql3)
--------------------------------
--  krivo se registrirao, šteler ga nije zapisao
--------------------------------
set @sql4='select 4 tip,firma,radnikid,ime,mt,'+@dan1+',dosao,otisao,sati,smjena,RadnoMjesto from (select r.neradi,p.firma,p.mt,p.radnikid,p.ime,p.'+@dan1+',v.dosao,v.otisao,v.ukupno_minuta,v.ukupno_minuta/60 sati,v.smjena,v.RadnoMjesto from  fxsap.dbo.plansatirada p inner join fxsap.dbo.psruserlist r1 on  p.RadnikID=r1.RadnikID and p.firma=r1.firma left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma  left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='''+@datum1+''' where mjesec='+@mjesec1+' and godina='+@godina1+' and v.dosao=v.otisao and year(v.dosao)!=1900 and r1.username=''sbiscan'' and p.mt not in ( 702,710,713,704) and ( '+@dan1+' is null or '+@dan1+'=''0e'')   ) x1 order by ime'
print @sql4
execute (@sql4)
----------------------------------------------------------------
-- imaju upisano 0e,null ili prazno a registrirali su se taj dan
-----------------------------------------------------------------
set @sql5='select 5 tip,firma,radnikid,ime,mt,'+@dan1+' from fxsap.dbo.plansatirada p  where mjesec='+@mjesec1+' and godina='+@godina1+' and ('+@dan1+' =''0e'' or '+@dan1+' is null or '+@dan1+'='''') and SifraRM not like ''Režija'' and radnikid in ( select extid from ( select b.extid, count(*) broj from rfind.dbo.event e left join rfind.dbo.badge b on e.No= b.BadgeNo  left join rfind.[dbo].[User] u on u.extid=b.extid left join rfind.dbo.eventtype t on e.EventType=t.Code left join rfind.dbo.reader r on r.id=e.device_id WHERE E.[USER] IS NOT NULL and e.eventtype!=''SP23'' and DATEPART(HOUR, e.dt)>6 and year(e.dt)=year('''+@datum1+''') and month(e.dt)=month('''+@datum1+''') and day(e.dt)=day('''+@datum1+''') group by b.extid )x1 where broj>1 ) '
print @sql5
execute (@sql5)

--
--  ima upisano 2 pune smjene
--
set @sql6='select 6 tip,firma,radnikid,ime,mt,godina,mjesec, '+@dan1+', 0 napomena from fxsap.dbo.plansatirada where mjesec= '+@mjesec1+' and godina= '+@godina1+ ' and ( '+@dan1+'=''1j:1p'' OR '+@dan1+'=''1j:1n'' OR '+@dan1+'=''1p:1n'')   '
print @sql6
execute (@sql6)


---- nije dosao
--select 7 tip,r.prezime,r.ime,dan22,' Nije se dobro registrirao' napomena,pv.*
--from rfind.dbo.pregledvremena pv
--left join fxsap.dbo.plansatirada p on p.RadnikID=pv.idradnika 
--left join rfind.dbo.radnici_ r on r.id=pv.idradnika
--where datum=@datum1
--and PV.radnomjesto not in ('G.O.','BO','B.O.','BO2','4. SMJENA','OTKAZI')
--and mjesec=@mjesec1 and godina=@godina1
--and dosao=otisao and ( year(dosao)!=1900 or year(otisao)!=1900)


--select *
--from fxsap.dbo.plansatirada
--where ime like '%PERU%' and godina=2019
--order by godina,mjesec desc


-- režija i ima upisano 0e
select 8 tip,radnikid,ime,dan21,' Režija, ima 0e ili null' napomena
from fxsap.dbo.plansatirada
where mjesec=@mjesec1 and godina=@godina1
--and radnikid=128
and sifrarm='Režija'
and (@dan1 is null or @dan1='0e')
order by ime,godina,mjesec desc


--update rfind.dbo.plansatirada2 
--set dan01='0j',
--dan02='0j',
--dan03='0j',
--dan04='0j',
--dan05='0j',
--dan06='0j',
--dan07='0j',
--dan08='0j',
--dan09='0j',
--dan10='0j',
--dan11='0j',
--dan12='0j',
--dan14='0j',
--dan15='0j',
--dan16='0j',
--dan17='0j',
--dan18='0j',
--dan19='0j',
--dan20='0j',
--dan21='0j',
--dan22='0j',
--dan23='0j',
--dan24='0j',
--dan25='0j',
--dan26='0j',
--dan27='0j',
--dan28='0j',
--dan29='0j',
--dan30='0j',
--dan31='0j',


--update fxsap.dbo.plansatirada set dan01='0y'  where mjesec=5 and godina=2019 and dan01='0e'

--select *
--from fxsap.dbo.plansatirada
--where mjesec=5 and godina=2019
--and radnikid=122

--select *
--from radnici_
--where id=8122

--select *
--from feroapp.dbo.radnici

--delete from rfind.dbo.pregledvremena where datum>='2019-9-10'


--select *
--from pregledvremena
--where datum='2019-05-21'
--and idradnika=1481

--use rfind
--update pregledvremena set dosao='2019-6-7 7:18:00',otisao='2019-6-7 7:51:00' where idradnika=1173 and datum='2019-6-7'
--update pregledvremena set ukupno_minuta=DATEDIFF(mi,dosao,otisao),kasni=0,PreranoOtisao=0 where idradnika=1173 and datum='2019-6-7'

--rfind.dbo.satniceoznake1 '2019-07-01'
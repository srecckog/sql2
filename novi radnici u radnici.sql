-- kontrola i update novih djelatnika
select *
from feroapp.dbo.radnici
where id_firme=1
order by id_fink desc

-- dodavanje novih iz TKB u radnici
insert into feroapp.dbo.radnici (id_fink,id_firme,ime,sifrarm,hala,radnastroju,steler,kontrola,bravar,pilar,neradi)
select id,case when poduzece='Feroimpex' then 1 else 3 end poduzece,prezime+' '+ime as ime,sifrarm,case when lokacija=500 then 1 else 3 end hala,1 radnastroju,0 steler,0 kontrola,0 bravar,0 pilar,0 neradi
from rfind.dbo.radnici_
where id>96    -- pazi na id
and poduzece='Tokabu'

-- dodavanje novih iz AT u radnici
insert into feroapp.dbo.radnici (id_fink,id_firme,ime,sifrarm,hala,radnastroju,steler,kontrola,bravar,pilar,neradi)
select id,case when poduzece='Feroimpex' then 1 else 3 end poduzece,prezime+' '+ime as ime,sifrarm,case when lokacija=500 then 1 else 3 end hala,0 radnastroju,0 steler,0 kontrola,0 bravar,0 pilar,0 neradi
from rfind.dbo.radnici_
where id>1547 and id<8000    -- pazi na id
and poduzece='Feroimpex'

-- provjera dali su svi u satnicama
select *
from rfind.dbo.radnici_ r
where id not in 
(
select radnikid
from fxsap.dbo.plansatirada
where mjesec=3 and godina=2018
)
and r.neradi=0
and r.id<8000
order by id desc


--insert into feroapp.dbo.radnici 
--(id_fink,id_firme,ime,sifrarm,hala,radnastroju,steler,kontrola,bravar,pilar,neradi) 
--values(1523,1,'MALOVIÆ ADALBERT','Tok',1,1,0,0,0,0,0),
--(1524,1,'MATIJEVIÆ LUKA','Tok',1,1,0,0,0,0,0),
--(1525,1,'ERCEG IVAN','Tok',1,1,0,0,0,0,0),
--(1526,1,'MATEJIÆ DARIJO','Tok',1,1,0,0,0,0,0)

--update radnici set neradi=0,steler=0,kontrola=0,bravar=0,pilar=0 where id_radnika in ( 2005,2004,2003,2002,2001,2000,1999)

select *
from rfind.dbo.radnici_
where id=1544
order by id desc

use feroapp
update radnici set radnastroju =1,steler=0,kontrola=0,bravar=0,pilar=0,neradi=0 where id_fink in ( 1544)
--use feroapp
--delete from radnici where id_fink=1543 and hala=1


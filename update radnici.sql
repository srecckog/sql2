use feroapp
select *
from radnici
order by id_radnika desc


use rfind
select *
from radnici_
order by datumzaposlenja desc

--update radnici_ set sifrarm='proizvodnja',fixnaisplata=0,datumzaposlenja='2019-07-01' where id in ( 900071)

--update radnici_ set id_radnika=2259 where id=900071
--update radnici_ set id_radnika=2256 where id=1685
--update radnici_ set id_radnika=2255 where id=1679
--update radnici_ set id_radnika=2254 where id=1677
--update radnici_ set id_radnika=2253 where id=1683
--update radnici_ set id_radnika=2252 where id=1682
--update radnici_ set id_radnika=2251 where id=1678
--update radnici_ set id_radnika=2250 where id=1681
--update radnici_ set id_radnika=2249 where id=1684
--update radnici_ set id_radnika=2248 where id=1686
--update radnici_ set id_radnika=2247 where id=1687
--update radnici_ set id_radnika=2246 where id=1676


----delete from pregledvremena where datum>='2019-08-12'
--insert into radnici ( id_fink,id_firme,ime,sifrarm,hala,radnastroju,steler,kontrola,bravar,pilar,neradi,datumdolaska) 
--values( 900071,1,'PEJIÆ IVO','Proizvodnja',1,1,0,0,0,0,0,'2019-07-01')

select *
from radnici_
where id=8165

--delete from radnici_ where id=8165 and FixnaIsplata=1
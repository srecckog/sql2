-- provjera otišlih

select r.*
from otisli_fx o
left join radnici_ r on (r.id-8000)=cast( o.acregno as int)
where r.id>8000 and r.id<9000

select r.*
from otisli_tkb o
left join radnici_ r on (r.id-8000)=cast( o.acregno as int)
where r.id>8000 and r.id<9000

select *
from radnici_
order by datumprestanka desc


select r.id,r.prezime,r.ime,p.dosao,p.otisao
from radnici_ r
left join pregledvremena p on p.IDRadnika=r.id
where datum='2019-09-09' and r.datumprestanka is null
and year(p.dosao)=1900


select r.id,r.prezime,r.ime,max(e.dt)
from radnici_ r
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where r.neradi=0 and id<90000
group by r.id,r.prezime,r.ime

having max(e.dt)<'2019-09-09'
order by prezime




select *
from [user]
where lastname like 'GAŠP%'


select *
from event
where [user]=1227
order by dt desc

-- na godišnjem
select count(*)
from fxsap.dbo.plansatirada
where mjesec=9 and godina=2019 and dan13 like '%g'








--update radnici_ set neradi=1 where id=8165
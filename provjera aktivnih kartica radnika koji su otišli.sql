select r.id,r.prezime,r.ime,b.BadgeNo,b.Active,r.DatumPrestanka,r.Neradi
from Badge b
left join [user] u on b.ExtId=u.extid
left join radnici_ r on r.id=u.extid
where r.neradi=1 and b.active=1


begin transaction t1
update badge set active=0  where extid in 
(
select r.id
from Badge b
left join [user] u on b.ExtId=u.extid
left join radnici_ r on r.id=u.extid
where r.neradi=1 and b.active=1
)
--commit transaction



end 
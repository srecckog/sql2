select b.*
from badge b
left join [user] u on b.extid=u.extid
where lastname like 'VODO%'
order by lastname
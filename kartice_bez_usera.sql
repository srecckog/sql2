use rfind
select *
from event
--where [no] like '%B66'
where [user] is null
and [no] <> '00000000'
AND NO LIKE '%BB6'
order by dt desc
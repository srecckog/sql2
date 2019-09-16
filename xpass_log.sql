select DATEADD(ss,ndatetime,'01/01/1970') date,nuserid,tl.neventidn,u.susername,ed.sname,row_number() over (order by nuserid)
from tb_event_log tl
left join tb_user u on tl.nuserid=u.suserid
left join tb_event_data ed on ed.neventidn=tl.neventidn
where nuserid!=0
order by ndatetime desc

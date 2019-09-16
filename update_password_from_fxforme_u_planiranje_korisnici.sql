update planiranje.dbo.korisnici set password =j.userpassword
from
(
select username,userpassword
from FxFirme.dbo.AppUsers
) j
inner join korisnici p on p.ime=j.username

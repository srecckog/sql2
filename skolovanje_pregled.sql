select s.idradnika,i.prezime Prezime,i.ime Ime,s.Napomena Nazivškolovanja,s.Oddatuma,s.Dodatuma,s.Gotovo,s.Mentor,v.Naziv Vještina,r.Vrijednost Sposoban,s.IzmjenaOd,r.datumocjenjivanja DatumOcjenjivanja,r.Ocjenjivac
from skolovanje1 s
left join radnici_ i on i.id=s.idradnika
left join radnicivjestines r on r.idradnika=s.idradnika and s.idskolovanja=r.idskolovanja
left join vjestine v on v.id=r.idvjestine
where s.idradnika=277
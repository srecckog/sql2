use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,pv.rbroj,pv.dosao,pv.otisao,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,ukupno_minuta
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.otisao!=pv.dosao and year(pv.dosao)!=1900
AND datum>='2019-01-01'  and r.id=523
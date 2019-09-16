 Response.Write("Nema podataka")
        vratioizFUnkcije=unesiAktivnost(Request("DatumOd"), 0, "0", 1, "", 0, 0, 0, 0, 0, 0, "", "Aktivnost", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "KVAROVI", 1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "BOLOVANJA",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "MATERIJAL",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "ALATI-MJERE",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "IZOSTANCI",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "PODBAÈAJI",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "PREBAÈAJI",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "ŠKART MAT.",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "ŠKART OBR.",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "ŠTELANJA",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "REALIZACIJA",  1, "", 0, 0, 0, 0, 0, 0, "", "Manjkovi", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "PLANIRANO",  1, "", 0, 0, 0, 0, 0, 0, "", "Realizacija", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "REALIZIRANO",  1, "", 0, 0, 0, 0, 0, 0, "", "Realizacija", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        vracenoIzFunkcije=unesiAktivnost(Request("DatumOd"), 0, "IDEALNO",  1, "", 0, 0, 0, 0, 0, 0, "", "Realizacija", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)


		                if rsDetalji("TekstCheck01")=1 and Instr(1, TestCheckovi, "Štelanje")=0 then TestCheckovi="Štelanje/"
                        if rsDetalji("TekstCheck02")=1 and Instr(1, TestCheckovi, "Kraj serije")=0 then TestCheckovi=TestCheckovi & "Kraj serije/"
                        if rsDetalji("TekstCheck03")=1 and Instr(1, TestCheckovi, "Prekid serije")=0 then TestCheckovi=TestCheckovi & "Prekid serije/"
                        if rsDetalji("TekstCheck04")=1 and Instr(1, TestCheckovi, "Bolovanja")=0 then TestCheckovi=TestCheckovi & "Bolovanja/"
                        if rsDetalji("TekstCheck05")=1 and Instr(1, TestCheckovi, "Rad pod pauzom")=0 then TestCheckovi=TestCheckovi & "Rad pod pauzom/"
                        if rsDetalji("TekstCheck06")=1 and Instr(1, TestCheckovi, "Nema djelatnika")=0 then TestCheckovi=TestCheckovi & "Nema djelatnika/"
                        if rsDetalji("TekstCheck07")=1 and Instr(1, TestCheckovi, "Kvar stroja")=0 then TestCheckovi=TestCheckovi & "Kvar stroja/"
                        if rsDetalji("TekstCheck08")=1 and Instr(1, TestCheckovi, "Remont")=0 then TestCheckovi=TestCheckovi & "Remont/"
                        if rsDetalji("TekstCheck09")=1 and Instr(1, TestCheckovi, "Problem stezni alat")=0 then TestCheckovi=TestCheckovi & "Problem stezni alat/"
                        if rsDetalji("TekstCheck10")=1 and Instr(1, TestCheckovi, "Problem rezni alat")=0 then TestCheckovi=TestCheckovi & "Problem rezni alat/"
                        if rsDetalji("TekstCheck11")=1 and Instr(1, TestCheckovi, "Problem sa mjerama")=0 then TestCheckovi=TestCheckovi & "Problem sa mjerama/"
                        if rsDetalji("TekstCheck12")=1 and Instr(1, TestCheckovi, "Bez transportera")=0 then TestCheckovi=TestCheckovi & "Bez transportera/"
                        if rsDetalji("TekstCheck13")=1 and Instr(1, TestCheckovi, "Podbaèaj")=0 then TestCheckovi=TestCheckovi & "Podbaèaj/"
                        if rsDetalji("TekstCheck14")=1 and Instr(1, TestCheckovi, "Prebaèaj")=0 then TestCheckovi=TestCheckovi & "Prebaèaj/"
                        if rsDetalji("TekstCheck15")=1 and Instr(1, TestCheckovi, "Nema sirovine")=0 then TestCheckovi=TestCheckovi & "Nema sirovine/"
                        if rsDetalji("TekstCheck16")=1 and Instr(1, TestCheckovi, "Pripomoæ")=0 then TestCheckovi=TestCheckovi & "Pripomoæ/"
                        if rsDetalji("TekstCheck17")=1 and Instr(1, TestCheckovi, "Novi nalog")=0 then TestCheckovi=TestCheckovi & "Novi nalog/"
                        'if rsDetalji("TekstCheck18")=1 and Instr(1, TestCheckovi, "Nezaplanirana")=0 then TestCheckovi=TestCheckovi & "Nezaplanirana/"
                        'if rsDetalji("TekstCheck19")=1 and Instr(1, TestCheckovi, "Dorada")=0 then TestCheckovi=TestCheckovi & "Dorada/"
                        'if rsDetalji("TekstCheck20")=1 and Instr(1, TestCheckovi, "Problem sirov.mat")=0 then TestCheckovi=TestCheckovi & "Problem sirov.mat/"
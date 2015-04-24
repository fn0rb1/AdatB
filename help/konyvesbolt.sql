/*Könyvek:*/

				CREATE TABLE Konyv (
					ISBN NUMBER(13) PRIMARY KEY,
					cim VARCHAR2(100),
					kiado VARCHAR2(100),
					kiadas_eve NUMBER(4),
					oldalszam NUMBER(4),
					nyelv VARCHAR2(100),
					kotes VARCHAR2(20),
					meret VARCHAR2(2),
					kredit_ertek NUMBER(5),
					eladott_mennyiseg NUMBER(5),
					eladott_mennyiseg_boltban NUMBER(5)
				);
				
				CREATE TABLE Mufaj_Konyv(
					id_konyv NUMBER(13),
					mufaj VARCHAR2(100),
					CONSTRAINT mufaj_konyv_pk PRIMARY KEY(id_konyv, mufaj),
					CONSTRAINT mufaj_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE
				);
				
				CREATE TABLE Konyv_Szerzo(
					id_szerzo NUMBER(5) PRIMARY KEY,
					szerzo VARCHAR2(100)
				);
				
				CREATE TABLE Szerzo_Konyv(
					id_konyv NUMBER(13),
					id_szerzo NUMBER(5),
					CONSTRAINT szerzo_konyv_pk PRIMARY KEY(id_konyv, id_szerzo),
					CONSTRAINT szerzo_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT szerzo_konyv_szerzo_fk FOREIGN KEY(id_szerzo) REFERENCES Konyv_Szerzo(id_szerzo) ON DELETE CASCADE
				);

			
/*E-Könyvek:*/

				CREATE TABLE Ekonyv(
					ISBN NUMBER(13) PRIMARY KEY,
					cim VARCHAR2(100),
					kiadas_eve NUMBER(4),
					oldalszam NUMBER(4),
					nyelv VARCHAR2(100),
					formatum VARCHAR2(2),
					kredit_ertek NUMBER(5),
					eladott_mennyiseg NUMBER(5),
					eladott_mennyiseg_boltban NUMBER(5)
				);

				CREATE TABLE Mufaj_Ekonyv(
					id_ekonyv NUMBER(13),
					mufaj VARCHAR2(100),
					CONSTRAINT mufaj_ekonyv_pk PRIMARY KEY(id_ekonyv, mufaj),
					CONSTRAINT mufaj_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE
				);
								
				CREATE TABLE Ekonyv_Szerzo(
					id_szerzo NUMBER(5) PRIMARY KEY,
					szerzo VARCHAR2(100)
				);
				
				CREATE TABLE Szerzo_Ekonyv(
					id_ekonyv NUMBER(13),
					id_szerzo NUMBER(5),
					CONSTRAINT szerzo_ekonyv_pk PRIMARY KEY(id_ekonyv, id_szerzo),
					CONSTRAINT szerzo_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT szerzo_ekonyv_szerzo_fk FOREIGN KEY(id_szerzo) REFERENCES EKonyv_Szerzo(id_szerzo) ON DELETE CASCADE
				);


/*Filmek:*/

				CREATE TABLE Film(
					id_film VARCHAR2(20) PRIMARY KEY,
					cim VARCHAR2(100),
					kiadas_eve NUMBER(4),
					hossza NUMBER(4),
					nyelv VARCHAR2(100),
					leiras VARCHAR2(1000),
					kredit_ertek NUMBER(5),
					eladott_mennyiseg NUMBER(5),
					eladott_mennyiseg_boltban NUMBER(5)
				);
				
				CREATE TABLE Mufaj_Film(
					id_film VARCHAR2(20),
					mufaj VARCHAR2(100),
					CONSTRAINT mufaj_film_pk PRIMARY KEY(id_film, mufaj),
					CONSTRAINT mufaj_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE
				);
								
				CREATE TABLE Film_Rendezo(
					id_rendezo NUMBER(5) PRIMARY KEY,
					rebdezo VARCHAR2(100)
				);
				
				CREATE TABLE Rendezo(
					id_film VARCHAR2(20),
					id_rendezo NUMBER(5),
					CONSTRAINT rendezo_pk PRIMARY KEY(id_film, id_rendezo),
					CONSTRAINT rendezo_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
					CONSTRAINT rendezo_rendezo_fk FOREIGN KEY(id_rendezo) REFERENCES Film_Rendezo(id_rendezo) ON DELETE CASCADE
				);


/*Zenék:*/

				CREATE TABLE Zene(
					id_zene VARCHAR2(20) PRIMARY KEY,
					cim VARCHAR2(100),
					kiado VARCHAR2(100),
					kiadas_eve NUMBER(4),
					hossza NUMBER(4),
					kredit_ertek NUMBER(5),
					eladott_mennyiseg NUMBER(5),
					eladott_mennyiseg_boltban NUMBER(5)
				);
				
				CREATE TABLE Mufaj_Zene(
					id_zene VARCHAR2(20),
					mufaj VARCHAR2(100),
					CONSTRAINT mufaj_zene_pk PRIMARY KEY(id_zene, mufaj),
					CONSTRAINT mufaj_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE
				);
					
				CREATE TABLE Zene_Szerzo(
					id_szerzo NUMBER(5) PRIMARY KEY,
					szerzo VARCHAR2(100)
				);
				
				CREATE TABLE Szerzo_Zene(
					id_zene VARCHAR2(20),
					id_szerzo NUMBER(5),
					CONSTRAINT szerzo_zene_pk PRIMARY KEY(id_zene, id_szerzo),
					CONSTRAINT szerzo_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE,
					CONSTRAINT szerzo_zene_szerzo_fk FOREIGN KEY(id_szerzo) REFERENCES Zene_Szerzo(id_szerzo) ON DELETE CASCADE
				);

				
/*Település:*/

				CREATE TABLE Telepules (
					iranyitoszam NUMBER(4) PRIMARY KEY,
					varos VARCHAR2(100)
				);

/*Felhasználó:*/

				CREATE TABLE Felhasznalo (
					id_felhasznalo VARCHAR2(20) PRIMARY KEY,
					jelszo VARCHAR2(20),
					rendelesek_szama NUMBER(5) DEFAULT 0,
					torzsvasarlo NUMBER(1),
					szuletesi_datum TIMESTAMP,
					nev VARCHAR2(100),
					iranyitoszam NUMBER(4),
					utca VARCHAR2(50),
					hazszam VARCHAR2(10),
					admin NUMBER(1),
					CONSTRAINT felhasznalo_telepules_fk FOREIGN KEY(iranyitoszam) REFERENCES Telepules(iranyitoszam) ON DELETE CASCADE
				);

/*Aruház:*/

				CREATE TABLE Aruhaz(
					id_aruhaz NUMBER(5) PRIMARY KEY,
					nev VARCHAR2(100),
					iranyitoszam NUMBER(4),
					utca VARCHAR(20),
					hazszam VARCHAR2(10),
					telefon VARCHAR2(15),
					email VARCHAR2(50),
					boltban NUMBER(1),
					CONSTRAINT aruhaz_telepules_fk FOREIGN KEY(iranyitoszam) REFERENCES Telepules(iranyitoszam) ON DELETE CASCADE
				);

				CREATE TABLE Figyelmeztetes(
					id_figyelmeztetes NUMBER(5) PRIMARY KEY,
					id_konyv NUMBER(13),
					id_ekonyv NUMBER(13),
					id_film VARCHAR2(20),
					id_zene VARCHAR2(20),
					id_aruhaz NUMBER(5),
					datum TIMESTAMP,
					CONSTRAINT figy_aruha_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE,
					CONSTRAINT figy_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT figy_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT figy_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
					CONSTRAINT figy_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE
				);

				CREATE TABLE Raktar_Konyv(
					id_konyv NUMBER(13),
					id_aruhaz NUMBER(5),
					db NUMBER(10),
					CONSTRAINT raktar_konyv_pk PRIMARY KEY(id_konyv, id_aruhaz),
					CONSTRAINT raktar_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT raktar_konyv_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
				);

				CREATE TABLE Raktar_Ekonyv(
					id_ekonyv NUMBER(13),
					id_aruhaz NUMBER(5),
					db NUMBER(10),
					CONSTRAINT raktar_ekonyv_pk PRIMARY KEY(id_ekonyv, id_aruhaz),
					CONSTRAINT raktar_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT raktar_ekonyv_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
				);

				CREATE TABLE Raktar_Film(
					id_film VARCHAR2(20),
					id_aruhaz NUMBER(5),
					db NUMBER(10),
					CONSTRAINT raktar_film_pk PRIMARY KEY(id_film, id_aruhaz),
					CONSTRAINT raktar_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
					CONSTRAINT raktar_film_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
				);

				CREATE TABLE Raktar_Zene(
					id_zene VARCHAR2(20),
					id_aruhaz NUMBER(5),
					db NUMBER(10),
					CONSTRAINT raktar_zene_pk PRIMARY KEY(id_zene, id_aruhaz),
					CONSTRAINT raktar_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE,
					CONSTRAINT raktar_zene_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
				);
				

/*Vásárlások:*/
				CREATE TABLE Kosar(
					id_kosar NUMBER(5) PRIMARY KEY,
					id_konyv NUMBER(13),
					id_ekonyv NUMBER(13),
					id_film VARCHAR2(20),
					id_zene VARCHAR2(20),
					id_aruhaz NUMBER(5),
					id_felhasznalo VARCHAR2(20),
					db NUMBER(5),
					CONSTRAINT kosar_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT kosar_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT kosar_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
					CONSTRAINT kosar_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE,
					CONSTRAINT kosar_aruha_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE,
					CONSTRAINT kosar_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE
				);
				
				CREATE TABLE Szamla(
					id_szamla NUMBER(5) PRIMARY KEY,
					osszeg NUMBER(10)
				);
				
				CREATE TABLE Megrendeles(
					id_megrendeles NUMBER(5),
					id_termekek NUMBER(5),
					id_szamla NUMBER(5),
					id_konyv NUMBER(13),
					id_ekonyv NUMBER(13),
					id_film VARCHAR2(20),
					id_zene VARCHAR2(20),
					id_aruhaz NUMBER(5),
					id_felhasznalo VARCHAR2(20),
					db NUMBER(5),
					datum TIMESTAMP,
					boltban_futarral NUMBER(1),
					atveheto_futarnal NUMBER(1),
					CONSTRAINT megrend_pk PRIMARY KEY(id_megrendeles, id_termekek),
					CONSTRAINT megrend_szamla_fk FOREIGN KEY(id_szamla) REFERENCES Szamla(id_szamla) ON DELETE CASCADE,
					CONSTRAINT megrend_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT megrend_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(ISBN) ON DELETE CASCADE,
					CONSTRAINT megrend_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
					CONSTRAINT megrend_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE,
					CONSTRAINT megrend_aruha_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE,
					CONSTRAINT megrend_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE
				);
				
				
				
/*				
CREATE TABLE Megrendeles_Konyv(
	megrendeles_id_felhasznaloja NUMBER(20),
	id_konyv VARCHAR2(20),
	id_felhasznalo VARCHAR2(20),
	id_aruhaz NUMBER(5),
	db NUMBER(2),
	datum TIMESTAMP,
	boltba_futarral VARCHAR2(1),
	atveheto_futarnal NUMBER(1),
	CONSTRAINT megrendeles_konyv_pk PRIMARY KEY(megrendeles_id_felhasznaloja, id_konyv),
	CONSTRAINT megrendeles_konyv_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT megrendeles_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(id_konyv) ON DELETE CASCADE,
	CONSTRAINT megrendeles_konyv_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
);

CREATE TABLE Megrendeles_Ekonyv(
	megrendeles_id_felhasznaloja NUMBER(20),
	id_ekonyv VARCHAR2(20),
	db NUMBER(2),
	datum TIMESTAMP,
	id_felhasznalo VARCHAR2(20),
	id_aruhaz NUMBER(5),
	boltba_futarral VARCHAR2(1),
	atveheto_futarnal NUMBER(1),
	CONSTRAINT megrendeles_ekonyv_pk PRIMARY KEY(megrendeles_id_felhasznaloja, id_ekonyv),
	CONSTRAINT megrendeles_ekonyv_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT megrendeles_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(id_ekonyv) ON DELETE CASCADE,
	CONSTRAINT megrendeles_ekonyv_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
);

CREATE TABLE Megrendeles_Film(
	megrendeles_id_felhasznaloja NUMBER(20),
	id_film VARCHAR2(20),
	db NUMBER(2),
	datum TIMESTAMP,
	id_felhasznalo VARCHAR2(20),
	id_aruhaz NUMBER(5),
	boltba_futarral VARCHAR2(1),
	atveheto_futarnal NUMBER(1),
	CONSTRAINT megrendeles_film_pk PRIMARY KEY(megrendeles_id_felhasznaloja, id_film),
	CONSTRAINT megrendeles_film_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT megrendeles_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE,
	CONSTRAINT megrendeles_film_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
);

CREATE TABLE Megrendeles_Zene(
	megrendeles_id_felhasznaloja NUMBER(20),
	id_zene VARCHAR2(20),
	db NUMBER(2),
	datum TIMESTAMP,
	id_felhasznalo VARCHAR2(20),
	id_aruhaz NUMBER(5),
	boltba_futarral VARCHAR2(1),
	atveheto_futarnal NUMBER(1),
	CONSTRAINT megrendeles_zene_pk PRIMARY KEY(megrendeles_id_felhasznaloja, id_zene),
	CONSTRAINT megrendeles_zene_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT megrendeles_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE,
	CONSTRAINT megrendeles_zene_aruhaz_fk FOREIGN KEY(id_aruhaz) REFERENCES Aruhaz(id_aruhaz) ON DELETE CASCADE
);

CREATE TABLE Kosar_Konyv(
	id_kosar NUMBER(10) PRIMARY KEY,
	id_konyv VARCHAR2(20),
	id_felhasznalo VARCHAR2(20),
	db NUMBER(2),
	CONSTRAINT kosar_konyv_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT kosar_konyv_fk FOREIGN KEY(id_konyv) REFERENCES Konyv(id_konyv) ON DELETE CASCADE
);

CREATE TABLE Kosar_Ekonyv(
	id_kosar NUMBER(10) PRIMARY KEY,
	id_ekonyv VARCHAR2(20),
	id_felhasznalo VARCHAR2(20),
	db NUMBER(2),
	CONSTRAINT kosar_ekonyv_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT kosar_ekonyv_fk FOREIGN KEY(id_ekonyv) REFERENCES Ekonyv(id_ekonyv) ON DELETE CASCADE
);

CREATE TABLE Kosar_Film(
	id_kosar NUMBER(10) PRIMARY KEY,
	id_film VARCHAR2(20),
	id_felhasznalo VARCHAR2(20),
	db NUMBER(2),
	CONSTRAINT kosar_film_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT kosar_film_fk FOREIGN KEY(id_film) REFERENCES Film(id_film) ON DELETE CASCADE
);

CREATE TABLE Kosar_Zene(
	id_kosar NUMBER(10) PRIMARY KEY,
	id_zene VARCHAR2(20),
	id_felhasznalo VARCHAR2(20),
	db NUMBER(2),
	CONSTRAINT kosar_zene_felh_fk FOREIGN KEY(id_felhasznalo) REFERENCES Felhasznalo(id_felhasznalo) ON DELETE CASCADE,
	CONSTRAINT kosar_zene_fk FOREIGN KEY(id_zene) REFERENCES Zene(id_zene) ON DELETE CASCADE
);
*/
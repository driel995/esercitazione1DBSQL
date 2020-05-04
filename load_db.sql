#Definizione dello schema e creazione della istanza vuota

create database if not exists universita;
use universita; 

drop table if exists studente;
create table studente(
Matricola numeric(10) primary key,
Corso_laurea varchar(5) references corso_laurea(Codice),
Nome varchar(20) not null,                          
Cognome varchar(20) not null,
Data_nascita date,
Codice_fiscale varchar(16) unique,
Foto BLOB default null);

drop table if exists docente;
create table docente(
Matricola numeric(10) primary key,
Dipartimento numeric(5) references dipartimento(Codice),
Nome varchar(20) not null,
Cognome varchar(20) not null,
Data_nascita date, 
Codice_fiscale varchar(16) unique,
Foto BLOB default null);

drop table if exists modulo;
create table modulo(
Codice numeric(2) primary key, 
Nome varchar(40) not null,
Descrizione varchar(100),
CFU numeric(2) check(cfu>0 AND not null));

drop table if exists esame;
create table esame(
Matricola_studente numeric(10) references studente(Matricola),
Codice_modulo numeric(2) references modulo(Codice),
Matricola_docente numeric(10) references docente(Matricola), 
Data date, 
Voto numeric(2) check(voto>=18 AND voto<=30) , 
Note varchar(30) default null);

drop table if exists corso_laurea;
create table corso_laurea(
Codice varchar(5) primary key, 
Nome varchar(60) unique, 
Descrizione varchar(100));

drop table if exists dipartimento;
create table dipartimento(
Codice numeric(5) primary key, 
Nome varchar(20) unique);

drop table if exists sede;
create table sede(
Codice numeric(3) primary key,
Indirizzo varchar(30) not null,
Citta varchar(10) not null);

drop table if exists sede_dipartimento;
create table sede_dipartimento(
Codice_sede numeric(3) references sede(Codice), 
Codice_dipartimento numeric(5) references dipartimento(Codice), 
Note varchar(20) default null);



#Popolamento DB

#Studenti
insert into studente
	values (1343959569, "INF01", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null);

insert into studente
	values (1343959570, "INF01", "FABRIZIO", "GENCHI", "1999-04-01", "GNCFRZ99A04L049S", null);

insert into studente
	values (1343959680, "INF01", "CARLO", "VALENTINI", "1999-11-11", "VLNCRL99S11A662B", null);

insert into studente
	values (1343943801, "INF02", "GIGI", "DE CAROLIS", "1993-09-11", "DCRGGI93P11A662W", null);

insert into studente
	values (1343945801, "INF02", "ANDREA", "BIANCHI", "1992-03-17", "BNCNDR92C57L049M", null);

insert into studente
	values (1343938401, "INF02", "PAOLA", "BIANCHI", "1994-05-01", "BNCPLA94E41A662X", null);

insert into studente
	values (1333959568, "ING01", "FRANCESCO", "BLASI", "1997-03-20", "BLSFNC97C20A662I", null);

insert into studente
	values (1453929568, "ING01", "MARIA", "ROSSI", "1999-07-20", "RSSMRA99L60H501P", null);

insert into studente
	values (1334229568, "ING01", "BIANCA", "BLASI", "1994-02-23", "BLSBNC94B63H501A", null);

insert into studente
	values (1333879579, "ING02", "CARMINE", "DE PAOLA", "1997-03-20", "DPLCMN97C20E986N", null);

insert into studente
	values (1334981579, "ING02", "CARLO", "VERDI", "1996-07-18", "VRDCRL96L18H501W", null);

insert into studente
	values (1334981456, "ING02", "GRAZIANO", "FINA", "1993-10-18", "FNIGZN93R18L049U", null);

insert into studente
	values (1233659569, "BIO01", "GIACOMO", "ROSSI", "1993-07-01", "RSSGCM93L01A149K", null);

insert into studente
	values (1238679569, "BIO01", "MARIA", "CONTE", "1995-07-11", "CNTMRA95L51H501D", null);

insert into studente
	values (4528679569, "BIO01", "PAOLO", "CONTE", "1991-04-11", "CNTPLA91D11A662D", null);

insert into studente
	values (2328679569, "BIO02", "FRANCESCA", "DE CAROLIS", "1992-06-17", "DCRFNC92H57L049N", null);

insert into studente
	values (4548595694, "BIO02", "COSIMO", "DE VINCENTIS", "1994-02-13", "DVNCSM94B13L049O", null);

insert into studente
	values (4548593212, "BIO02", "CAROLA", "FRANTI", "1992-03-11", "FRNCRL92C51H501U", null);

#Docenti del dipartimento di Informatica
insert into docente
	values (1476384759, 00001, "MARIA", "VERDI", "1985-05-04", "VRDMRA85E44A662W", null);

insert into docente
	values (5484856781, 00001, "MARIO", "CARLINO", "1982-01-04", "CRLMRA82A04L328M", null);

insert into docente
	values (5487946781, 00001, "CLAUDIO", "MOLFETTA", "1980-02-11", "MLFCLD80B11A662T", null);

#Docenti del dipartimento di Fisica
insert into docente
	values (7498503720, 00002, "CARLO", "BELLINI", "1989-11-15", "BLLCRL89S15H501G", null);

insert into docente
	values (7458485820, 00002, "MARTA", "FIORE", "1981-12-14", "FRIMRT81T54L049R", null);

insert into docente
	values (9451879465, 00002, "MICHELA", "CALIANDRO", "1985-09-14", "CLNMHL85P54E986J", null);

#Docenti del dipartimento di Biologia
insert into docente
	values (9451872411, 00003, "MARA", "DE CONTE", "1989-10-12", "DCNMRA89P54L328D", null);

insert into docente
	values (8327448539, 00003, "FRANCESCO", "FIORITO", "1989-11-23", "FRTFNC89S23L049B", null);

insert into docente
	values (8327492939, 00003, "RAFFAELE", "PALMI", "1983-05-23", "PLMRFL83E23L049U", null);

#Docenti del dipartimento di Matematica
insert into docente
	values (1859547852, 00004, "ROBERTO", "CAROLI", "1982-03-02", "CRLRRT82C02A662X", null);

insert into docente
	values (5487946754, 00004, "CHIARA", "FORNI", "1988-02-02", "FRNCHR88B42F205P", null);

#Moduli
insert into modulo
	values (01, "Basi di Informatica", "architettura degli elaboratori, programmazione, fondamenti di informatica." , 27 );

insert into modulo
	values (02, "Matematica", "Matematica Discreta, analisi 1, metodi numerici." , 24 );

insert into modulo
	values (11, "Fondamenti per Scienze applicate", "Elementi di fisica, fisica 1" , 15 );

insert into modulo
	values (21, "Fondamenti per Biologia", "Biologia cellulare e istologia, biologia dello sviluppo." , 18 );

#Esami
insert into esame
	values (1343959569, 01, 1476384759, "2019-04-16", 26, null);

insert into esame
	values (1343959570, 01, 5484856781, "2020-02-15", 28, null);

insert into esame
	values (1343959569, 02, 1859547852, "2020-01-12", 24, null);

insert into esame
	values (1343959680, 02, 5487946754, "2020-02-15", 29, null);

insert into esame
	values (1333959568, 02, 5487946754, "2020-02-15", 24, null);

insert into esame
	values (1334229568, 02, 1859547852, "2019-01-03", 22, null);

insert into esame
	values (1333959568, 11, 7498503720, "2020-06-15", 22, null);

insert into esame
	values (1453929568, 11, 7498503720, "2020-06-15", 27, null);

insert into esame
	values (1334229568, 11, 9451879465, "2019-02-15", 25, null);

insert into esame
	values (1233659569, 21, 8327492939, "2020-02-15", 25, null);

insert into esame
	values (4528679569, 21, 9451872411, "2019-01-03", 18, null);

insert into esame
	values (1233659569, 02, 5487946754, "2020-02-15", 22, null);
#nota: ho volontariamente non inserito la partecipazione di tutti gli studenti e di tutti i docenti alle diverse istanze di esami.

#Elenco corsi di laurea
insert into corso_laurea
	values ("INF01","Informatica", "C.d.l. triennale in Informatica");

insert into corso_laurea
	values ("INF02","Informatica e Comunicazione Digitale","C.d.l. triennale in Informatica e Comunicazione Digitale");

insert into corso_laurea
	values ("ING01","Ingegneria Meccanica", "C.d.l. triennale in Ingegneria Meccanica");

insert into corso_laurea
	values ("ING02","Ingegneria Elettronica", "C.d.l. triennale in Ingegneria Elettronica");

insert into corso_laurea
	values ("BIO01","Biologia", "C.d.l. triennale in Biologia");

insert into corso_laurea
	values ("BIO02","Biologia Ambientale", "C.d.l. magistrale in Biologia Ambientale");

#Elenco dipartimenti
insert into dipartimento
	values(00001, "Informatica");

insert into dipartimento
	values(00002, "Fisica");

insert into dipartimento
	values(00003, "Biologia");

insert into dipartimento
	values(00004, "Matematica");

#Sedi
insert into sede
	values(001,"Via Orabona 4,70125", "Bari");

insert into sede
	values(002,"Via G. Amendola 173,70126", "Bari");

insert into sede
	values(003,"Via Orabona 4,70125", "Bari");

insert into sede_dipartimento
	values(001,00001,null);

insert into sede_dipartimento
	values(002,00002,null);

insert into sede_dipartimento
	values(003,00003,null);

insert into sede_dipartimento
	values(002,00004,null);

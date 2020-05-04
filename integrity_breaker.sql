#Eseguire le parti di codice separatamente per verificare le diverse violazioni dei vincoli di integrità o eseguire l'intero script per notare il susseguirsi di errori.

#Definizione dello schema e creazione della istanza vuota


#Per provare lo script su una istanza vuota, viene creato un database secondario di schema identico all'originale.
#Se si desidera provarlo sul database originale, usare lo script integrity_breaker1.sql.
create database if not exists universita1;
use universita1; 

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






insert into studente
	values (null, "Informatica", null, null , "1999-12-02", null, null);
#Violazione di tutti i principali vincoli di integrità della tupla studente, a eccezione della data, sulla quale non riesco a porre un vincolo e un confronto.


insert into studente
	values (1234567891, "INF01", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null );
insert into studente
	values (1234567891, "INF01", "FABRIZIO", "GENCHI", "1999-04-01", "GNCFRZ99A04L049S", null);
delete from studente;
#Violato il vincolo di unicità della chiave primaria (Matricola). La stessa violazione dovrebbe valere se inserissi un docente con la stessa matricola.


insert into studente
	values (1234567891, "INF01", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null );
insert into studente
	values (1234567821, "INF02", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null );
delete from studente;
#Violato il vincolo di unicità della chiave (Codice fiscale e/o omonimia+data di nascita). Uno studente non può essere iscritto a due corsi con due diverse matricole.


insert into studente
	values (1234567891, "Informatica", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null );
#Violato il numero di caratteri massimi del codice

insert into studente
	values (1234567891, "FIS01", "ANDREA", "VITTI", "1995-12-18", "VTTNDR95T18L049V", null );
delete from studente;
#Violato il vincolo di integrità referenziale con la tabella corso_laurea. (Non esiste alcuna istanza con il codice inserito)



#Per la relazione docente, non riscrivo alcune delle violazioni dei vincoli, essendo identiche alle prime tre sulla relazione studenti
insert into docente
	values (1476384759, 000001, "MARIA", "VERDI", "1985-05-04", "VRDMRA85E44A662W", null);
#Violato il numero massimo di cifre inseribili nel codice modulo

insert into docente
	values (1476384759, "Matematica", "MARIA", "VERDI", "1985-05-04", "VRDMRA85E44A662W", null);
#Violato il tipo dell'attributo codice

insert into docente
	values (1476384759, 00008, "MARIA", "VERDI", "1985-05-04", "VRDMRA85E44A662W", null);
delete from docente;
#Violato il vincolo di integrità referenziale con la relazione dipartimento. (Non esiste alcuna istanza con il codice inserito)



insert into modulo
	values (null, "Basi di Informatica", "architettura degli elaboratori, programmazione, fondamenti di informatica." , null );
insert into modulo
	values (null, "Basi di Informatica", "architettura degli elaboratori, programmazione, fondamenti di informatica." , 0 );
#Violazione di tutti i principali vincoli di integrità della tupla modulo.

insert into modulo
	values (01, "Basi di Informatica", "architettura degli elaboratori, programmazione, fondamenti di informatica." , 27 );
insert into modulo
	values (01, "Matematica", "...." , 27 );
delete from modulo;
#Violazione del vincolo di unicità della chiave primaria(Codice). Non possono esistere due moduli con stesso codice

insert into modulo
	values (01, null , "..." , 27 );
#Non può esistere un modulo senza nome

insert into modulo
	values (01, "Basi di Informatica", "architettura degli elaboratori, programmazione, fondamenti di informatica." , 0 );
#Violazione del vincolo di integrità sul valore dell'attributo CFU. Non ci possono essere moduli senza CFU.


insert into esame
	values (1343959569, 01, 1476384759, "2019-04-16", 26, null);
insert into esame
	values (1343959569, 01, 1476384759, "2019-04-16", 26, null);
delete from esame;
#Violato vincolo di unicità della superchiave Matricola_studente, modulo, Matricola_docente.

insert into esame
	values (0000000001, 01, 1476384759, "2019-04-16", 26, null);
delete from esame;
#Violato il vincolo di integrità referenziale con la relazione studente. (Non può essere registrato un esame di uno studente non registrato)

insert into esame
	values (0000000001, 09, 1476384759, "2019-04-16", 26, null);
delete from esame;
#Violato il vincolo di integrità referenziale con la relazione modulo.

insert into esame
	values (0000000001, 01, 0000000001, "2019-04-16", 26, null);
delete from esame;
#Violato il vincolo di integrità referenziale con la relazione docente. (Non può esserci un esame con la supervisione di un docente non registrato)

insert into esame
	values (0000000001, 01, 1476384759, "2019-04-16", 0, null);
#Violato vincolo di integrità sull'attributo Voto. Non può esserci un esame con una votazione non compresa tra 18 e 30.




insert into corso_laurea
	values ("INF002","Informatica", "C.d.l. triennale in Informatica");
#Violato il vincolo di integrità sulla chiave primaria, superando il numero di caratteri ammessi nella chiave primaria.

insert into corso_laurea
	values ("INF01","Informatica", "C.d.l. triennale in Informatica");
insert into corso_laurea
	values ("INF01","Informatica e comunicazione digitale", "C.d.l. triennale in Informatica");
delete from corso_laurea;
#Violato il vincolo di unicità della chiave primaria

insert into corso_laurea
	values ("INF01","Informatica", "C.d.l. triennale in Informatica");
insert into corso_laurea
	values ("INF02","Informatica", "C.d.l. triennale in Informatica");
delete from corso_laurea;
#Violato il vincolo di unicità della chiave relativa all'attributo Nome.



insert into dipartimento
	values(00001, "Informatica");
insert into dipartimento
	values(00001, "Fisica");
delete from dipartimento;
#Violato il vincolo di unicità della chiave primaria

insert into dipartimento
	values(00001, "Informatica");
insert into dipartimento
	values(00002, "Informatica");
delete from dipartimento;
#Violato il vincolo di unicità della chiave Nome

insert into dipartimento
	values(00001, null);
#Violato il vincolo di integrità della chiave nome



insert into sede
	values(0001,"Via Orabona 4,70125", "Bari");
insert into sede
	values(null,"Via Orabona 4,70125", "Bari");
#Violato il vincolo di integrità della chiave primaria

insert into sede
	values(001,"Via Orabona 4,70125", "Bari");
insert into sede
	values(001,"Via G. Amendola 173,70126", "Bari");
delete from sede;
#Violato il vincolo di unicità della chiave primaria

insert into sede
	values(001,null, "Bari");
#Violato vincolo di integrità dell'attributo indirizzo. Non può esistere una sede senza un indirizzo fisico

insert into sede
	values(001,"Via Orabona 4,70125", null);
delete from sede;
#Violato vincolo di integrità dell'attributo città. Sarebbe ambiguo non sapere in quale città è presente una sede



insert into sede_dipartimento
	values(010,00001,null);
#Violato vincolo di integrità referenziale con la relazione sede.

insert into sede_dipartimento
	values(001,00010,null);
#Violato vincolo di integrità referenziale con la relazione dipartimento
--Borrado de claves extranjeras:


alter table pilotos drop constraint fk_id_escuderia;
alter table prototipos drop constraint fk_id_escuderia2;
alter table carreras drop constraint fk_id_circuito;
alter table resultados drop constraint fk_id_prototipo;
alter table resultados drop constraint fk_id_carrera;
alter table resultados drop constraint fk_id_piloto;

--Borrado de tablas:

drop table escuderias;
drop table pilotos;
drop table prototipos;
drop table carreras;
drop table resultados;
drop table circuitos;

--Creación de tablas:

create table escuderias
	(id_escuderia number (3) primary key,
	nombre varchar2 (20));

create table pilotos
	(id_piloto number(3) primary key,
	nombre varchar2 (20),
	id_escuderia number(3));

create table prototipos
	(id_prototipo number (3) primary key,
	nombre varchar2 (20),
	id_escuderia number (3));

create table carreras
	(id_carrera number (3) primary key,
	fecha date,
	id_circuito number(3));

create table resultados
	(id_prototipo number(3),
	id_carrera number (3),
	id_piloto number(3),
	tiempo varchar2(10),
	posicion number(3));

create table circuitos
	(id_circuito number(3) primary key,
	nombre varchar2 (20));


--Inserción de filas:

insert into escuderias values (1,'RENOL');
insert into escuderias values (2,'FERRALLA');
insert into escuderias values (3,'MCDONAL');

insert into pilotos values (1,'JOHN',1);
insert into pilotos values (2,'NESTOR',2);
insert into pilotos values (3,'PAUL',3);
insert into pilotos values (4,'MICHAEL',1);
insert into pilotos values (5,'EUSTAQUIO',2);
insert into pilotos values (6,'ROGER',3);
insert into pilotos values (7,'SIGFREDO',1);
insert into pilotos values (8,'TOM',3);

insert into prototipos values (1,'R1',1);
insert into prototipos values (2,'F1',2);
insert into prototipos values (3,'M1',3);
insert into prototipos values (4,'R2',1);
insert into prototipos values (5,'F2',2);
insert into prototipos values (6,'M2',3);
insert into prototipos values (7,'R3',1);

insert into carreras values (1,'01/03/2006',1);
insert into carreras values (2,'15/03/2006',2);
insert into carreras values (3,'01/04/2006',3);
insert into carreras values (4,'13/05/2006',4);
insert into carreras values (5,'01/05/2006',1);
insert into carreras values (6,'12/05/2006',2);

insert into circuitos values (1,'JARABE');
insert into circuitos values (2,'PEONZA');
insert into circuitos values (3,'CERRADO');
insert into circuitos values (4,'MONACCO');


insert into resultados values (1,1,1,'1:23:12345',1);
insert into resultados values (2,1,2,'1:25:12542',2);
insert into resultados values (3,1,3,'1:26:54322',3);
insert into resultados values (4,1,4,'1:29:58540',4);


insert into resultados values (5,2,5,'2:30:19876',1);
insert into resultados values (6,2,6,'2:40:17654',2);
insert into resultados values (7,2,7,'2:54:28987',3);
insert into resultados values (1,2,1,'3:01:29876',4);
insert into resultados values (2,2,2,'3:02:30987',5);


insert into resultados values (1,3,1,'2:10:34890',1);
insert into resultados values (2,3,2,'2:24:47897',2);
insert into resultados values (3,3,3,'2:25:26754',3);
insert into resultados values (4,3,4,'2:26:18765',4);
insert into resultados values (5,3,5,'2:28:41234',5);
insert into resultados values (6,3,6,'2:29:51234',6);



insert into resultados values (1,4,1,'0:23:41234',4);
insert into resultados values (2,4,2,'0:25:31254',2);
insert into resultados values (3,4,3,'0:26:25432',3);
insert into resultados values (4,4,4,'0:29:49854',1);


insert into resultados values (5,5,5,'1:30:29876',4);
insert into resultados values (6,5,6,'1:40:47654',5);
insert into resultados values (7,5,7,'1:54:38987',3);
insert into resultados values (1,5,1,'2:01:19876',2);
insert into resultados values (2,5,2,'2:02:40987',1);


insert into resultados values (1,6,1,'1:10:54890',6);
insert into resultados values (2,6,2,'1:24:37897',5);
insert into resultados values (3,6,3,'1:25:26754',3);
insert into resultados values (4,6,4,'1:26:18765',4);
insert into resultados values (5,6,5,'1:28:41234',2);
insert into resultados values (6,6,6,'1:29:51234',1);


--Fijación de claves extranjeras:

alter table pilotos add constraint fk_id_escuderia
	foreign key (id_escuderia) references escuderias;

alter table prototipos add constraint fk_id_escuderia2
	foreign key (id_escuderia) references escuderias;

alter table carreras add constraint fk_id_circuito
	foreign key (id_circuito) references circuitos;

alter table resultados add constraint fk_id_prototipo
	foreign key (id_prototipo) references prototipos;
	
alter table resultados add constraint fk_id_carrera
	foreign key (id_carrera) references carreras;

alter table resultados add constraint fk_id_piloto
	foreign key (id_piloto) references pilotos;

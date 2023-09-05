alter session set nls_date_format = 'yyyy-mm-dd';

DROP TABLE Alumnos CASCADE CONSTRAINTS;
DROP TABLE Cursos CASCADE CONSTRAINTS;
DROP TABLE Equipos CASCADE CONSTRAINTS;
DROP TABLE  Calendario CASCADE CONSTRAINTS;
DROP TABLE Participantes CASCADE CONSTRAINTS;
DROP TABLE Departamentos CASCADE CONSTRAINTS;
DROP TABLE ProfesoresCursos CASCADE CONSTRAINTS;
DROP TABLE Profesores CASCADE CONSTRAINTS;
DROP TABLE Tutorias CASCADE CONSTRAINTS;
DROP TABLE Actividades CASCADE CONSTRAINTS;


CREATE  TABLE Actividades(
IdActividad INTEGER NOT NULL PRIMARY KEY,
Actividad VARCHAR2(50)
);

CREATE  TABLE Equipos(
IdEquipo INTEGER  NOT NULL PRIMARY KEY,
Nombre VARCHAR2(50)
);
CREATE  TABLE Cursos(IdCurso INTEGER NOT NULL PRIMARY KEY,
Curso VARCHAR2(50)
);
CREATE  TABLE Alumnos(Expediente INTEGER NOT NULL PRIMARY KEY,
Nombre VARCHAR2(50),
Apellidos VARCHAR2(50),
Grupo INTEGER,
FechaNacimiento DATE,
CONSTRAINT FK_alumnos_grupo FOREIGN KEY(Grupo) REFERENCES Cursos(IdCurso)
);
CREATE   TABLE Calendario(
Jornada INTEGER NOT NULL,
Actividad INTEGER NOT NULL,
Fecha DATE NOT NULL,
Hora VARCHAR2(8)NOT NULL,
Lugar VARCHAR2(50) NOT NULL,
EquipoA INTEGER,
EquipoB INTEGER,
ResultadoEquipoA INTEGER,
ResultadoEquipoB VARCHAR2(50),
PRIMARY KEY(Actividad,Fecha,Hora,Lugar),
CONSTRAINT FK_calendario_equipoA FOREIGN KEY(EquipoA) REFERENCES Equipos(IdEquipo),
CONSTRAINT FK_calendario_equipoB FOREIGN KEY(EquipoB) REFERENCES Equipos(IdEquipo),
CONSTRAINT FK_calendario_actividad FOREIGN KEY(Actividad) REFERENCES Actividades(IdActividad)
);
CREATE  TABLE Participantes(
ParticipanteActividad INTEGER NOT NULL,
ParticipanteEquipo INTEGER NOT NULL,
Alumno INTEGER NOT NULL, 
PRIMARY KEY(ParticipanteActividad,ParticipanteEquipo,Alumno),
CONSTRAINT FK_participante_alumno FOREIGN KEY(Alumno) REFERENCES Alumnos(Expediente),
CONSTRAINT FK_participante_actividad FOREIGN KEY(ParticipanteActividad) REFERENCES Actividades(IdActividad),
CONSTRAINT FK_participante_equipo FOREIGN KEY(ParticipanteEquipo) REFERENCES Equipos(IdEquipo)
);
CREATE  TABLE Profesores(
IDProfesor INTEGER NOT NULL PRIMARY KEY,
Nombre VARCHAR2(50),
Apellido VARCHAR2(50),
Direccion VARCHAR2(200),
Ciudad VARCHAR2(50),
Provincia VARCHAR2(50),
CodPostal VARCHAR2(20),
Departamento INTEGER
);
CREATE  TABLE ProfesoresCursos(
Profesor INTEGER NOT NULL,
Curso INTEGER NOT NULL,
Tutor varchar2(5),
PRIMARY KEY(Profesor,Curso),
CONSTRAINT FK_profesorescursos_profesor FOREIGN KEY(Profesor) REFERENCES Profesores(IDProfesor),
CONSTRAINT FK_profesorescursos_curso FOREIGN KEY(Curso) REFERENCES Cursos(IdCurso)
);

CREATE  TABLE Tutorias(
IdTutoria INTEGER NOT NULL PRIMARY KEY,
Profesor INTEGER,
Curso INTEGER,
DiaSemana VARCHAR2(10),
HoraTutoria VARCHAR2(8),
CONSTRAINT FK_tutoria_profesor FOREIGN KEY(Profesor) REFERENCES Profesores(IDProfesor),
CONSTRAINT FK_tutoria_curso FOREIGN KEY(Curso) REFERENCES Cursos(IdCurso)
);
CREATE  TABLE Departamentos(
IdDepartamento INTEGER NOT NULL PRIMARY KEY,
Nombre VARCHAR2(50)
);

ALTER TABLE Profesores ADD CONSTRAINT FK_profesor_departamento FOREIGN KEY(Departamento) REFERENCES Departamentos(IdDepartamento);

INSERT INTO Actividades VALUES(0,'Futbol');
INSERT INTO Actividades VALUES(1,'Baloncesto');
INSERT INTO Actividades VALUES(2,'Balonmano');
INSERT INTO Equipos VALUES(0,'LocosDelBal On');
INSERT INTO Equipos VALUES(1,'1B Fultbol Club');
INSERT INTO Equipos VALUES(2,'Imparables');
INSERT INTO Equipos VALUES(3,'SinMiedo FC');
INSERT INTO Equipos VALUES(4,'Los mejores');
INSERT INTO Equipos VALUES(5,'Luchadores');
INSERT INTO Cursos VALUES(1,'1A');
INSERT INTO Cursos VALUES(2,'1B');
INSERT INTO Cursos VALUES(3,'1C');
INSERT INTO Cursos VALUES(4,'2A');
INSERT INTO Cursos VALUES(5,'2B');
INSERT INTO Cursos VALUES(6,'2C');
INSERT INTO Alumnos VALUES(1,'Veronica ','Romero Milheirico',1,'1989-04-28');
INSERT INTO Alumnos VALUES(2,'Rub en ','Duran Milheirico',1,'1989-04-28');
INSERT INTO Alumnos VALUES(3,'Manuel ','Moreno Martin',1,'1990-06-13');
INSERT INTO Alumnos VALUES(4,'Juan Diego','Gonzalez Pulido',1,'1990-08-23');
INSERT INTO Alumnos VALUES(5,'Jesus ','Naranjo Charro',1,'1990-02-20');
INSERT INTO Alumnos VALUES(6,'Manuel ','Alvarez Menor',1,'1990-02-04');
INSERT INTO Alumnos VALUES(7,'Cristian ','Aguado Caro',1,'1989-11-14');
INSERT INTO Alumnos VALUES(8,'Alejandro ','Antonio Gonzalez',1,'1990-03-15');
INSERT INTO Alumnos VALUES(9,'Maria ','Caballo Santos',1,'1990-01-18');
INSERT INTO Alumnos VALUES(10,'Gerardo ','Correa Moran',1,'1991-09-04');
INSERT INTO Alumnos VALUES(11,'Sheila ','Cosme Almeida',1,'1992-08-29');
INSERT INTO Alumnos VALUES(12,'Rub en ','Crespo Bonilla',1,'1990-08-04');
INSERT INTO Alumnos VALUES(13,'Maria Dolores','Duran Rasero',1,'1989-08-22');
INSERT INTO Alumnos VALUES(14,'Sheila ','Eduardo Sanchez',1,'1987-07-04');
INSERT INTO Alumnos VALUES(15,'Tamara ','Flores Hernandez',1,'1988-02-08');
INSERT INTO Alumnos VALUES(16,'Jose Daniel','Garcia LOpez',1,'1989-04-10');
INSERT INTO Alumnos VALUES(17,'Lorena ','Garcia Ortiz',1,'1988-07-12');
INSERT INTO Alumnos VALUES(18,'Clara ','Gil Gonzalez',1,'1989-04-01');
INSERT INTO Alumnos VALUES(19,'Claudia ','Guerrero Hernandez',1,'1989-07-04');
INSERT INTO Alumnos VALUES(20,'Daniel ','Infantes Rubio',1,'1990-05-20');
INSERT INTO Alumnos VALUES(21,'Sonia ','LOpez Gonzalez',1,'1990-03-24');
INSERT INTO Alumnos VALUES(22,'Noelia ','Marcos Gordillo',1,'1989-06-13');
INSERT INTO Alumnos VALUES(23,'Sara ','Marin Gallego',1,'1990-05-17');
INSERT INTO Alumnos VALUES(24,'Gemma Maria','Martin Pastor',1,'1990-05-17');
INSERT INTO Alumnos VALUES(25,'Alicia Maria Neves ','Moreno Barbosa',1,'1991-12-29');
INSERT INTO Alumnos VALUES(26,'Marta ','Muniz Alba',2,'1994-01-12');
INSERT INTO Alumnos VALUES(27,'Ruben ','Nicolas Pablos',2,'1994-10-17');
INSERT INTO Alumnos VALUES(28,'Jessica ','Nogales Gordillo',2,'1995-09-08');
INSERT INTO Alumnos VALUES(29,'Jose Antonio','Pardo Montes',2,'1994-08-23');
INSERT INTO Alumnos VALUES(30,'Carmelo ','Perez Sanchez',2,'1995-06-26');
INSERT INTO Alumnos VALUES(31,'Emmanuel ','Ponce Romero',2,'1995-09-23');
INSERT INTO Alumnos VALUES(32,'Rocio ','Rodriguez Duran',2,'1994-03-20');
INSERT INTO Alumnos VALUES(33,'Soledad ','Romero Caballo',2,'1995-03-10');
INSERT INTO Alumnos VALUES(34,'Blanca ','Sansegundo Honorato',2,'1995-06-29');
INSERT INTO Alumnos VALUES(35,'Juan Pedro','Trevijano Marin',2,'1995-06-29');
INSERT INTO Alumnos VALUES(36,'Diego ','Vaquerizo Noriega',2,'1995-08-03');
INSERT INTO Alumnos VALUES(37,'Baldomero ','Vieira Murillo',2,'1995-08-24');
INSERT INTO Alumnos VALUES(38,'Jose Antonio','Sanchez Aguilar',2,'1989-11-16');
INSERT INTO Alumnos VALUES(39,'David ','Lindo Gonzalez',2,'1990-04-09');
INSERT INTO Alumnos VALUES(40,'Gema ','Marcos Lopez',2,'1990-05-02');
INSERT INTO Alumnos VALUES(41,'VerOnica ','Carretero Canito',2,'1995-11-28');
INSERT INTO Alumnos VALUES(42,'Estefania ','Rigote Albarran',2,'1996-01-01');
INSERT INTO Alumnos VALUES(43,'Coral ','Cardenas Montero',2,'1995-07-02');
INSERT INTO Alumnos VALUES(44,'Rosa Maria','Rueda Montero',2,'1995-03-24');
INSERT INTO Alumnos VALUES(45,'Juan Manuel','Romero Blanco',2,'1994-02-05');
INSERT INTO Alumnos VALUES(46,'Almudena ','Rodriguez Antonio',2,'1995-06-17');
INSERT INTO Alumnos VALUES(47,'Samuel ','Garrido Bueno',2,'1994-06-15');
INSERT INTO Alumnos VALUES(48,'Jonathan ','Franco Calder On',2,'1989-02-19');
INSERT INTO Alumnos VALUES(49,'Francisco Manuel','Aranha Chaves',2,'1988-02-04');
INSERT INTO Alumnos VALUES(50,'Esther Maria','Jaramago Flores',2,'1990-04-29');
INSERT INTO Alumnos VALUES(52,'Maria ','GOmez Le On',3,'1994-01-30');
INSERT INTO Alumnos VALUES(53,'Jesus','Falc On Torvisco',3,'1993-11-24');
INSERT INTO Alumnos VALUES(54,'Sandra Maria','Pache Vaquerizo',3,'1989-09-26');
INSERT INTO Alumnos VALUES(55,'C esar ','Rodriguez Guti errez',3,'1988-06-06');
INSERT INTO Alumnos VALUES(56,'Sonia ','Higuero Borrero',3,'1990-01-01');
INSERT INTO Alumnos VALUES(57,'Soledad ','Garrido Garrido',3,'1988-04-19');
INSERT INTO Alumnos VALUES(58,'Antonia ','Romero Crespo',3,'1989-10-24');
INSERT INTO Alumnos VALUES(59,'Soraya ','Miranda Garcia',3,'1988-10-06');
INSERT INTO Alumnos VALUES(60,'Ivan Manuel','Romero Villar',3,'1987-12-02');
INSERT INTO Alumnos VALUES(61,'Jose Miguel','Gonzalez Flores',3,'1987-12-06');
INSERT INTO Alumnos VALUES(62,'Ana Bel en','Trejo Rodriguez',3,'1983-02-10');
INSERT INTO Alumnos VALUES(63,'Noelia ','Cantero Moreno',3,'1989-07-02');
INSERT INTO Alumnos VALUES(64,'Gabriel ','P erez Moreno',3,'1992-04-30');
INSERT INTO Alumnos VALUES(65,'Mario ','Trevijano Rodriguez',3,'1988-09-18');
INSERT INTO Alumnos VALUES(66,'Mercedes','Prada Flores',3,'1990-05-17');
INSERT INTO Alumnos VALUES(67,'Pedro Juan','Pozo Rosa',3,'1995-11-10');
INSERT INTO Alumnos VALUES(68,'Oscar ','Cordero Rodriguez',3,'1994-08-06');
INSERT INTO Alumnos VALUES(69,'Coral ','Torrado Moran',3,'1994-04-07');
INSERT INTO Alumnos VALUES(70,'Sonia ','Soto Duarte',3,'1995-08-06');
INSERT INTO Alumnos VALUES(71,'Francisco Javier','Parra Duarte',3,'1995-02-26');
INSERT INTO Alumnos VALUES(72,'Joel Gabriel','Flores Rodriguez',3,'1995-06-08');
INSERT INTO Alumnos VALUES(73,'Maria ','Larios Casquero',3,'1995-05-13');
INSERT INTO Alumnos VALUES(74,'Julian ','Macho Carmona',3,'1995-08-25');
INSERT INTO Alumnos VALUES(75,'Joaquin ','Flor Sabir',3,'1995-12-11');
INSERT INTO Alumnos VALUES(76,'Jennifer ','Martin Lozano',4,'1995-03-19');
INSERT INTO Alumnos VALUES(77,'Francisco Javier','Palomo Gonzalez',4,'1995-09-01');
INSERT INTO Alumnos VALUES(78,'Maria del Rocio ','Rosa Exp Osito',4,'1995-08-20');
INSERT INTO Alumnos VALUES(79,'Cristina ','Gomez Graca',4,'1994-01-17');
INSERT INTO Alumnos VALUES(80,'Nazaret ','Ales On Herrezuelo',4,'1995-11-27');
INSERT INTO Alumnos VALUES(81,'Pilar ','Beltran Sanchez',4,'1995-02-17');
INSERT INTO Alumnos VALUES(82,'Laura ','Alvarez Hidalgo',4,'1995-07-08');
INSERT INTO Alumnos VALUES(83,'Ivan ','Sanchez Hoz',4,'1995-04-27');
INSERT INTO Alumnos VALUES(84,'Marta ','Macias Gonzalez',4,'1995-08-20');
INSERT INTO Alumnos VALUES(85,'Gabriel ','Martinez Lozano',4,'1995-03-05');
INSERT INTO Alumnos VALUES(86,'Jonathan ','Martinez Zahino',4,'1995-04-29');
INSERT INTO Alumnos VALUES(87,'Pedro Jose','Ortiz Garcia',4,'1995-05-01');
INSERT INTO Alumnos VALUES(88,'Francisco Javier','Boza Romero',4,'1995-03-07');
INSERT INTO Alumnos VALUES(89,'David ','Blanco Gonzalez',4,'1995-06-24');
INSERT INTO Alumnos VALUES(90,'Mirian ','Contreras Moreno',4,'1994-07-10');
INSERT INTO Alumnos VALUES(91,'Manuel ','Bermudez Madrono',4,'1994-08-27');
INSERT INTO Alumnos VALUES(92,'Hector Antonio','Marin Gomez ',4,'1995-10-11');
INSERT INTO Alumnos VALUES(93,'Alberto ','Rodriguez Garcia',4,'1995-08-15');
INSERT INTO Alumnos VALUES(94,'Jose Manuel','Nogales Isidoro',4,'1995-08-18');
INSERT INTO Alumnos VALUES(95,'Angel ','Salguero Reyes',4,'1995-05-31');
INSERT INTO Alumnos VALUES(96,'Alicia ','Jackson Diaz',4,'1995-11-26');
INSERT INTO Alumnos VALUES(97,'Javier ','Caceres Pinheiro',4,'1995-08-04');
INSERT INTO Alumnos VALUES(98,'Rosa Maria','Gil Bermudez',4,'1995-03-15');
INSERT INTO Alumnos VALUES(99,'Luis Manuel','Cano Nicolas',4,'1995-01-23');
INSERT INTO Alumnos VALUES(100,'Victor Jesus','Gonzalez Ventura',4,'1995-01-14');
INSERT INTO Alumnos VALUES(101,'David ','Cayero Sierra',5,'1992-12-05');
INSERT INTO Alumnos VALUES(102,'Jose Maria','Lindo Hernandez',5,'1993-01-26');
INSERT INTO Alumnos VALUES(103,'Jose Manuel','Rodriguez Escudero',5,'1991-08-20');
INSERT INTO Alumnos VALUES(104,'Ismael ','Cantero Abad',5,'1992-09-27');
INSERT INTO Alumnos VALUES(105,'Sergio ','Romero Terr On',5,'1900-01-01');
INSERT INTO Alumnos VALUES(106,'Cristo Jose','Larios Juez',5,'1993-06-17');
INSERT INTO Alumnos VALUES(107,'Luis Miguel','Davila Gonzalez',5,'1992-11-12');
INSERT INTO Alumnos VALUES(108,'Jose ','Manero Cabanillas',5,'1993-01-26');
INSERT INTO Alumnos VALUES(109,'Jose Maria','Vazquez Gonzalez',5,'1992-12-07');
INSERT INTO Alumnos VALUES(110,'Angelica ','Menacho Rodriguez',5,'1993-09-09');
INSERT INTO Alumnos VALUES(111,'Pablo ','MendezDuran',5,'1993-06-29');
INSERT INTO Alumnos VALUES(112,'Sergio ','Freije Antonio',5,'1993-07-09');
INSERT INTO Alumnos VALUES(113,'Francisco Javier','Alfonso Cadenas',5,'1993-07-01');
INSERT INTO Alumnos VALUES(114,'Jose Manuel','Sache Cortes',5,'1991-06-30');
INSERT INTO Alumnos VALUES(115,'Angel Jesus','Gonzalez Lara',5,'1993-03-26');
INSERT INTO Alumnos VALUES(116,'Antonio ','Segovia Cruz',5,'1900-01-01');
INSERT INTO Alumnos VALUES(117,'Jonatan ','Martin Simon',5,'1990-12-18');
INSERT INTO Alumnos VALUES(118,'Alfonso ','Lopez Rodriguez',5,'1992-12-08');
INSERT INTO Alumnos VALUES(119,'Estefania ','Ruiz Cano',5,'1993-01-14');
INSERT INTO Alumnos VALUES(120,'Francisco Jose','Casilda Caro',5,'1993-05-20');
INSERT INTO Alumnos VALUES(121,'Antonio ','Rodriguez Martinez',5,'1993-04-25');
INSERT INTO Alumnos VALUES(122,'Gema Maria','Muniz Rosina',5,'1992-08-06');
INSERT INTO Alumnos VALUES(123,'Ivan ','Soto Charro',5,'1993-10-17');
INSERT INTO Alumnos VALUES(124,'Cristian ','Gomez Figueroa',5,'1992-05-12');
INSERT INTO Alumnos VALUES(125,'Mario ','Jorge Parra',5,'1992-12-02');
INSERT INTO Alumnos VALUES(126,'Jose','Pereira Castano',6,'1993-08-28');
INSERT INTO Alumnos VALUES(127,'Lorena ','Fernandez Narciso',6,'1993-08-27');
INSERT INTO Alumnos VALUES(128,'Jorge ','Alvarez Lindo',6,'1992-12-06');
INSERT INTO Alumnos VALUES(129,'Cristian ','Garcia Pareja',6,'1991-06-23');
INSERT INTO Alumnos VALUES(130,'Miguel Angel','Molina Lozano',6,'1992-01-21');
INSERT INTO Alumnos VALUES(131,'Sergio','Dragao Aguilera',6,'1992-09-27');
INSERT INTO Alumnos VALUES(132,'Silvia ','Garrancho Aspano',6,'1993-03-05');
INSERT INTO Alumnos VALUES(133,'Ram On ','Rosa Barranca',6,'1993-03-14');
INSERT INTO Alumnos VALUES(134,'Juan Manuel','Nogales Torrado',6,'1992-11-23');
INSERT INTO Alumnos VALUES(135,'Nerea ','Delgado Barbosa',6,'1992-12-17');
INSERT INTO Alumnos VALUES(136,'Gema ','Rodriguez Sanchez',6,'1993-07-17');
INSERT INTO Alumnos VALUES(137,'Nuria ','Barroso Benitez',6,'1993-07-21');
INSERT INTO Alumnos VALUES(138,'Laura ','Cantero Curado',6,'1993-05-07');
INSERT INTO Alumnos VALUES(139,'Diana ','Exp Osito Torres',6,'1992-05-11');
INSERT INTO Alumnos VALUES(140,'Nazaret Maria','Ruiz Flor',6,'1993-04-21');
INSERT INTO Alumnos VALUES(141,'Isabel Maria','Duarte Tercero',6,'1993-04-01');
INSERT INTO Alumnos VALUES(142,'Francisco Javier','Pinero Moreno',6,'1993-05-10');
INSERT INTO Alumnos VALUES(143,'Irene ','Tobal Garcia',6,'1992-03-24');
INSERT INTO Alumnos VALUES(144,'Medea ','Candalija Castano',6,'1900-01-01');
INSERT INTO Alumnos VALUES(145,'Ismael ','Chac On Martinez',6,'1993-03-16');
INSERT INTO Alumnos VALUES(146,'Macarena ','Acevedo Risco',6,'1993-08-24');
INSERT INTO Alumnos VALUES(147,'Rodrigo ','Caceres Vaquerizo',6,'1993-11-13');
INSERT INTO Alumnos VALUES(148,'Cristian ','Aguado Santos',6,'1900-01-01');
INSERT INTO Alumnos VALUES(149,'Macarena ','Ferrer Garcia',6,'1992-01-16');
INSERT INTO Alumnos VALUES(150,'Alfonso ','Sandez Romero',6,'1993-04-17');
INSERT INTO Calendario VALUES(5,0,'2007-03-17','17:00:00','Pista 1',5,1,5,'2');
INSERT INTO Calendario VALUES(6,0,'2007-03-17','17:30:00','Pista 2',3,1,0,'0');
INSERT INTO Calendario VALUES(8,0,'2007-03-18','17:00:00','Pista 1',1,2,1,'2');
INSERT INTO Calendario VALUES(7,0,'2007-03-18','17:30:00','Pista 2',4,1,0,'2');
INSERT INTO Calendario VALUES(0,1,'2007-02-12','17:00:00','Pista 1',0,1,56,'78');
INSERT INTO Calendario VALUES(1,1,'2007-02-12','17:30:00','Pista 2',2,3,67,'69');
INSERT INTO Calendario VALUES(2,1,'2007-02-14','17:00:00','Pista 1',4,5,78,'68');
INSERT INTO Calendario VALUES(3,1,'2007-02-14','17:30:00','Pista 2',0,3,89,'78');
INSERT INTO Calendario VALUES(4,1,'2007-03-16','17:00:00','Pista 1',0,2,69,'30');
INSERT INTO Participantes VALUES(0,1,1);
INSERT INTO Participantes VALUES(0,1,2);
INSERT INTO Participantes VALUES(0,1,5);
INSERT INTO Participantes VALUES(0,1,6);
INSERT INTO Participantes VALUES(0,1,7);
INSERT INTO Participantes VALUES(0,1,8);
INSERT INTO Participantes VALUES(0,1,9);
INSERT INTO Participantes VALUES(0,1,10);
INSERT INTO Participantes VALUES(0,2,3);
INSERT INTO Participantes VALUES(0,2,4);
INSERT INTO Participantes VALUES(0,2,11);
INSERT INTO Participantes VALUES(0,2,12);
INSERT INTO Participantes VALUES(0,2,14);
INSERT INTO Participantes VALUES(0,2,15);
INSERT INTO Participantes VALUES(0,2,16);
INSERT INTO Participantes VALUES(0,2,17);
INSERT INTO Participantes VALUES(0,2,18);
INSERT INTO Participantes VALUES(0,2,19);
INSERT INTO Participantes VALUES(0,2,20);
INSERT INTO Participantes VALUES(0,4,31);
INSERT INTO Participantes VALUES(0,4,32);
INSERT INTO Participantes VALUES(0,4,33);
INSERT INTO Participantes VALUES(0,4,34);
INSERT INTO Participantes VALUES(0,4,35);
INSERT INTO Participantes VALUES(0,4,36);
INSERT INTO Participantes VALUES(0,4,37);
INSERT INTO Participantes VALUES(0,4,38);
INSERT INTO Participantes VALUES(0,4,39);
INSERT INTO Participantes VALUES(0,4,40);
INSERT INTO Participantes VALUES(0,5,41);
INSERT INTO Participantes VALUES(0,5,42);
INSERT INTO Participantes VALUES(0,5,43);
INSERT INTO Participantes VALUES(0,5,44);
INSERT INTO Participantes VALUES(0,5,46);
INSERT INTO Participantes VALUES(0,5,47);
INSERT INTO Participantes VALUES(1,3,1);
INSERT INTO Participantes VALUES(1,3,4);
INSERT INTO Participantes VALUES(1,3,21);
INSERT INTO Participantes VALUES(1,3,22);
INSERT INTO Participantes VALUES(1,3,23);
INSERT INTO Participantes VALUES(1,3,24);
INSERT INTO Participantes VALUES(1,3,25);
INSERT INTO Participantes VALUES(1,3,26);
INSERT INTO Participantes VALUES(1,3,27);
INSERT INTO Participantes VALUES(1,3,28);
INSERT INTO Participantes VALUES(1,3,29);
INSERT INTO Participantes VALUES(1,3,30);

INSERT INTO Departamentos VALUES(0,'Frances');
INSERT INTO Departamentos VALUES(1,'Lengua');
INSERT INTO Departamentos VALUES(2,'Geografia');
INSERT INTO Departamentos VALUES(3,'Orientacion');
INSERT INTO Departamentos VALUES(4,'EducaciOn Fisica');
INSERT INTO Departamentos VALUES(5,'ReligiOn');
INSERT INTO Departamentos VALUES(6,'Ingles');
INSERT INTO Departamentos VALUES(7,'Frances');
INSERT INTO Profesores VALUES(0,'Miguel','Rivero Monge','C/ Agua, 3','Badajoz','Badajoz','06006',1);
INSERT INTO Profesores VALUES(1,'Miguel','Garrote Ortega','C/ Sol, 4','Montanchez','Badajoz','06300',2);

INSERT INTO Profesores VALUES(2,'Manuela','Matamoros Prudencio','C/ Luna, 14','Rivera','Caceres','10010',3);
INSERT INTO Profesores VALUES(3,'Manuela','Conejo Sanchez','C/ Sal, 19','Badajoz','Badajoz','06010',4);
INSERT INTO Profesores VALUES(4,'Julia','Rodriguez Silvero','C/ Arena, 2','Caceres','Caceres','10010',5);
INSERT INTO Profesores VALUES(5,'Sonia','Haba Villasan','C/ Pimienta, 36','Badajoz','Badajoz','06008',6);
INSERT INTO Profesores VALUES(6,'Jorge','Delgado Moreno','C/ Rosa, 25','Caceres','Caceres','10001',7);
INSERT INTO Profesores VALUES(7,'Carmen','Blanco Rivero','C/ Cartagena, 1','Puebla','Badajoz','06009',1);
INSERT INTO Profesores VALUES(8,'Dolores','Caballero Garrote','C/ Menorca, 16','Badajoz','Badajoz','06008',2);
INSERT INTO Profesores VALUES(9,'Federico','Cortes Matamoros','C/ Hoja, 3','Caceres','Caceres','10010',3);
INSERT INTO Profesores VALUES(10,'Pablo','Cortes Conejo','C/ Bolindre, 25','Caceres','Caceres','10010',4);
INSERT INTO Profesores VALUES(11,'Yolanda','Cuellar Rodriguez','C/ Abajo, 8','Berzocana','Caceres','10200',5);
INSERT INTO Profesores VALUES(12,'Angeles','P erez Haba','C/ Sola, 16','Rayuela','Badajoz','06400',6);
INSERT INTO Profesores VALUES(13,'Jose','Galvan Delgado','C/ Pe\u00f1a, 2','Caceres','Caceres','10002',7);
INSERT INTO Profesores VALUES(14,'Alfonso','Garcia Cordon','C/ Losa, 5','Badajoz','Badajoz','06007',1);
INSERT INTO Profesores VALUES(15,'Faustino','Gomez Alonso','C/ Sordera, 6','Talavera','Badajoz','06500',2);
INSERT INTO Profesores VALUES(16,'Casimiro','Gomez Murillo','C/ Juan, 39','Brozas','Caceres','10360',3);
INSERT INTO Profesores VALUES(17,'Antonio','Gonzalez Blanco','C/ Arriba, 4','Badajoz','Badajoz','06007',4);
INSERT INTO Profesores VALUES(19,NULL,NULL,NULL,NULL,NULL,NULL,2);
INSERT INTO Tutorias VALUES(0,1,1,'Lunes','11:00:00');
INSERT INTO Tutorias VALUES(1,2,6,'Miercoles','10:00:00');
INSERT INTO Tutorias VALUES(2,3,5,'Jueves','13:00:00');
INSERT INTO Tutorias VALUES(3,4,2,'Lunes','09:30:00');
INSERT INTO Tutorias VALUES(4,5,4,'Jueves','12:30:00');
INSERT INTO Tutorias VALUES(5,6,3,'Martes','12:30:00');

INSERT INTO ProfesoresCursos VALUES(1,1,'TRUE');
INSERT INTO ProfesoresCursos VALUES(1,2,'FALSE');
INSERT INTO ProfesoresCursos VALUES(1,3,'FALSE');
INSERT INTO ProfesoresCursos VALUES(2,2,'TRUE');
INSERT INTO ProfesoresCursos VALUES(2,3,'FALSE');
INSERT INTO ProfesoresCursos VALUES(2,4,'FALSE');
INSERT INTO ProfesoresCursos VALUES(3,1,'FALSE');
INSERT INTO ProfesoresCursos VALUES(4,2,'FALSE');
INSERT INTO ProfesoresCursos VALUES(4,6,'TRUE');
INSERT INTO ProfesoresCursos VALUES(5,3,'TRUE');
INSERT INTO ProfesoresCursos VALUES(5,4,'FALSE');
INSERT INTO ProfesoresCursos VALUES(6,6,'FALSE');
INSERT INTO ProfesoresCursos VALUES(7,1,'FALSE');
INSERT INTO ProfesoresCursos VALUES(7,2,'FALSE');
INSERT INTO ProfesoresCursos VALUES(8,1,'FALSE');
INSERT INTO ProfesoresCursos VALUES(8,2,'FALSE');
INSERT INTO ProfesoresCursos VALUES(9,5,'TRUE');
INSERT INTO ProfesoresCursos VALUES(10,2,'FALSE');
INSERT INTO ProfesoresCursos VALUES(11,5,'FALSE');
INSERT INTO ProfesoresCursos VALUES(12,5,'FALSE');
INSERT INTO ProfesoresCursos VALUES(12,6,'FALSE');
commit;

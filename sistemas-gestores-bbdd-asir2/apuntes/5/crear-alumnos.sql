

alter user alumno identified by alumno;


create table alumnos(
  nombre varchar(255),
  apellidos varchar(255),
  idalumno numeric(20,0)
);

drop table cursos;
create table cursos(
  nombre varchar(255),
  idcurso numeric(20,0),
  idprofesor numeric(20,0)
);

create table matriculas(
  idalumno numeric(20,0),
  idcurso numeric(20,0)
);


commit;

create or replace function inserta_alumno return numeric
as
  nombre varchar(255);
  apellidos varchar(255);
  idalumno numeric;
begin
  nombre := dbms_random.string('U',8);
  apellidos := dbms_random.string('U',8) || ' ' || dbms_random.string('U',8);
  idalumno := dbms_random.value(1,9999999999999999999);
  
  insert into alumnos(nombre,apellidos,idalumno) values(nombre,apellidos,idalumno);
  
  return idalumno;
end;
/

create or replace function inserta_curso return numeric
as
  nombre varchar(255);
  idcurso numeric;
begin
  nombre := dbms_random.string('U',8);
  idcurso := dbms_random.value(1,9999999999999999999);
  
  insert into cursos(nombre,idcurso) values(nombre,idcurso);
  
  return idcurso;
end;
/

drop function inserta_matricula;
create or replace procedure inserta_matricula(idalumno numeric, idcurso numeric)
as
begin
  insert into matriculas(idalumno,idcurso) values(idalumno,idcurso);
end;
/


declare
  type alumnoarray is varray(1000) of numeric(20,0);
  type cursosarray is varray(1000) of numeric(20,0);
  
  alumnos alumnoarray := alumnoarray();
  cursos cursosarray := cursosarray();
begin

  -- INSERTO 1000 ALUMNOS
  for i in 1..1000
  loop
    --dbms_output.put_line('Alumno ' || i);
    alumnos.extend;
    alumnos(i) := inserta_alumno();
  end loop;

  -- INSERTO 1000 CURSOS
  for i in 1..1000
  loop
    --dbms_output.put_line('Curso ' || i);
    cursos.extend;
    cursos(i) := inserta_curso();
  end loop;

  -- MATRICULO ALUMNOS EN CURSOS
  for a in 1..1000 loop
    for c in 1..1000 loop
       if( dbms_random.value(0,10) < 2 ) then
          --dbms_output.put_line( 'Matricula ' || alumnos(a) || ' - ' || cursos(c) );
          inserta_matricula( alumnos(a), cursos(c) );
       end if;
    end loop;
  end loop;  

end;
/

 
select * from matriculas;  

commit;
  
  
select * from alumnos where idalumno between 100000 and 555555555555555555555;

alter table alumnos add constraint alumnospk primary key(idalumno);


select * from alumnos where upper(nombre) like '%ABC%';

create or replace view alumnos_por_curso as
select count(idalumno) as alumnos, idcurso
from matriculas
group by idcurso;

select * from alumnos_por_curso;

drop materialized view cursos_con_alumnos;
create  materialized view cursos_con_alumnos_mat as
select cursos.idcurso, alumnos, nombre 
from alumnos_por_curso, cursos
where alumnos_por_curso.idcurso = cursos.idcurso;

begin
  dbms_snapshot.refresh( 'cursos_con_alumnos_mat', 'f');
end;
/

select * from cursos where idcurso = '6634486337729730642';

alter table cursos add constraint cursopk primary key(idcurso);


create or replace view cursos_con_alumnos as
select cursos.idcurso, alumnos, nombre 
from alumnos_por_curso, cursos
where alumnos_por_curso.idcurso = cursos.idcurso;

select * from cursos_con_alumnos order by alumnos desc;
select * from cursos_con_alumnos_mat order by alumnos desc;

create or replace view cursos_mas_populares as
select c.idcurso, c.nombre, alumnos
from cursos_con_alumnos, cursos c
where 
  c.idcurso = cursos_con_alumnos.idcurso and
  alumnos = (select max(alumnos) from cursos_con_alumnos);

select * from cursos_mas_populares;

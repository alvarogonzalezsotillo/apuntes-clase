
-- PRUEBA CREACIÓN DE AVIÓN
declare
  id numeric;
begin
  CREAR_AVION_TIPO(id);
  dbms_output.put_line( 'Avion:'||id);
  MUESTRA_AVION(id);
end;
/

select * from aviones_profesor;
rollback;


-- PRUEBA COPIAR AVIÓN
declare
  id numeric;
  copiaid numeric;
begin
  CREAR_AVION_TIPO(id);
  COPIAR_AVION(id,copiaid);
  dbms_output.put_line( 'Avion original:'||id);
  MUESTRA_AVION(id);
  dbms_output.put_line( 'Avion copiado:'||copiaid);
  MUESTRA_AVION(copiaid);
end;
/

select * from aviones_profesor;
rollback;

-- PRUEBA COPIA DE PIEZA
declare
  id numeric;
  copiaid numeric;
  cabina aviones_profesor%rowtype;
begin
  CREAR_AVION_TIPO(id);
  
  select *
  into cabina
  from aviones_profesor
  where parte_padre=id and lower(nombre) like '%abina%';
  
  dbms_output.put_line( 'Pieza:' || cabina.parte_id);
  COPIAR_PIEZA(cabina.parte_id, id, copiaid);
  dbms_output.put_line( 'Pieza copiada:' || copiaid);
  
  MUESTRA_AVION(id);
  
end;
/

-- SE PUEDE COPIAR UN AVIÓN QUE YA TENGA UNA PIEZA COPIADA
-- TAMBIEN HAY QUE PROBAR LOS PROCEDIMIENTOS DE BORRAR AVIONES

select * from aviones_profesor;
rollback;



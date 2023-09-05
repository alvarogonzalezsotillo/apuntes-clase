-- LLAMAR A PROCEDIMIENTOS REMOTOS VIA DBLINK
-- http://stackoverflow.com/questions/240788/how-to-execute-an-oracle-stored-procedure-via-a-database-link
mySchema.myPackage.myProcedure@myRemoteDB( 'someParameter' );

-- CREAR DBLINK
-- http://www.dataprix.com/acceso-remoto-mediante-dblink-de-oracle
-- http://docs.oracle.com/cd/B28359_01/server.111/b28310/ds_admin002.htm

Create database link LNK_DE_A_a_B connect to USUARIO identified by CONTRASEÑA USING 'B';
select * from TABLA@LNK_DE_A_a_B; 

-- EXPLICACION DE FICHEROS DE NOMBRES ORACLE
-- http://www.orasite.com/instalacion-y-configuracion/archivos-de-configuracion-de-la-red-oracle
-- http://www.orafaq.com/wiki/Tnsnames.ora

-- VER LOS BLINK DEFINIDOS EN LA BASE DE DATOS
SET PAGESIZE 100

SET LINESIZE 300

COL OWNER FORMAT A11 HEADING "PROPIETARIO"

COL USERNAME FORMAT A28 HEADING "USUARIO"

COL DB_LINK FORMAT A30

COL HOST FORMAT A17

SELECT * FROM DBA_DB_LINKS;

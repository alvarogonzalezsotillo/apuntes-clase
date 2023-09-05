create table pedidos(
  idpedido number(10,0) primary key
);

create table productos(
  idproducto number(9,0) primary key,
  nombre varchar(50),
  precio number(6,2) check( precio > 0 )
); 

create table lineaspedidos(
  idpedido number(10,0),
  idproducto number(9,0),
  cantidad number (3,0) check (cantidad > 0 ),
  primary key (idpedido, idproducto),
  foreign key (idpedido) references pedidos(idpedido),
  foreign key (idproducto) references productos(idproducto)
);

-- UN PEDIDO CON CUATRO ZANAHORIAS Y DOS PERAS
-- LAS PERAS ESTÁN A 1€ Y LAS ZANAHORIAS A 0.25€
INSERT INTO productos (idproducto,nombre,precio) 
                values(100, 'zanahorias', 0.25);
INSERT INTO productos (idproducto,nombre,precio) 
                values(101, 'peras', 1);
INSERT INTO PEDIDOS(idpedido) values(50);
insert into lineaspedidos(idpedido,idproducto,cantidad)
                   values(50,100,4);
insert into lineaspedidos(idpedido,idproducto,cantidad)
                   values(50,101,2);


-- CREAR UN USUARIO
create user school identified by school;

-- EL USUARIO PUEDE CONECTARSE
grant connect to school;

-- EL USUARIO PUEDE CREAR TABLAS
grant resource to school;

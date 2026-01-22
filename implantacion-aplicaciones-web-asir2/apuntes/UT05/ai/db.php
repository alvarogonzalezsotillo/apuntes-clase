<?php
$host = "localhost";
$user = "ajedrez";
$pass = "ajedrez";
$db   = "ajedrez";

$mysqli = new mysqli($host, $user, $pass, $db);
if ($mysqli->connect_errno) {
    die("Error de conexión");
}

/* Crear tablas si no existen */

$mysqli->query("
CREATE TABLE IF NOT EXISTS tableros (
    id INT AUTO_INCREMENT PRIMARY KEY
)
");

$mysqli->query("
CREATE TABLE IF NOT EXISTS piezas (
    tablero_id INT,
    posicion CHAR(2),
    pieza CHAR(1),
    PRIMARY KEY (tablero_id, posicion)
)
");

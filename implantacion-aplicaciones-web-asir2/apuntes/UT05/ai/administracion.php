<?php
require_once "db.php";
require_once "funciones.php";

if (isset($_GET['borrar']) && is_numeric($_GET['borrar'])) {
    $id = $_GET['borrar'];
    $mysqli->query("DELETE FROM piezas WHERE tablero_id=$id");
    $mysqli->query("DELETE FROM tableros WHERE id=$id");
}

if (isset($_GET['crear']) ){
    $tablero_id = crearTablero();
    rellenaTablero($tablero_id);
    header("Location: tablerocompartido.php?id=$tablero_id");
    die();    
}

$res = $mysqli->query("SELECT id FROM tableros");
?>

<h1>Administración</h1>

<ul>
<?php while ($row = $res->fetch_assoc()): ?>
    <li>
        Tablero <?= $row['id'] ?>
        <a href="tablerocompartido.php?id=<?= $row['id'] ?>">Ver</a>
        <a href="administracion.php?borrar=<?= $row['id'] ?>">Borrar</a>
    </li>
<?php endwhile; ?>
</ul>
<form>
    <input type="hidden" id="crear" name="crear" value="crear">
    <input type="submit" value="Crear un tablero nuevo">
<form>    
    

<?php
session_start();
require_once "funciones.php";

if (!isset($_SESSION['tablero_id'])) {
    $_SESSION['tablero_id'] = crearTablero();
}

$tablero_id = $_SESSION['tablero_id'];

if (isset($_GET['posicion'], $_GET['pieza'])) {
    guardarPieza($tablero_id, $_GET['posicion'], $_GET['pieza']);
}

$tablero = obtenerTablero($tablero_id);
?>

<h1>Mi tablero</h1>

<?php dibujarTablero($tablero); ?>

<form method="get">
    Posición:
    <input pattern="^[a-h][1-8]$" title="Se necesita una coordenada correcta, por ejemplo e3" name="posicion" id="posicion" required>

    Pieza:
    <select name="pieza">
        <option value="">Vacía</option>
        <option value="♜">♜</option>
        <option value="♞">♞</option>
        <option value="♝">♝</option>
        <option value="♛">♛</option>
        <option value="♚">♚</option>
        <option value="♟">♟</option>
        <option value="♖">♖</option>
        <option value="♘">♘</option>
        <option value="♗">♗</option>
        <option value="♕">♕</option>
        <option value="♔">♔</option>
        <option value="♙">♙</option>      
    </select>

    <button>Guardar</button>
</form>

<a href="tablerocompartido.php?id=<?= $tablero_id ?>">Compartir tablero</a>

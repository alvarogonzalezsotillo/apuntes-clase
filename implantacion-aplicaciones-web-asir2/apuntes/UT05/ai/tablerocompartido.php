<?php
require_once "funciones.php";

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("Tablero no válido");
}

$tablero_id = $_GET['id'];

if (isset($_GET['posicion'], $_GET['pieza'])) {
    guardarPieza($tablero_id, $_GET['posicion'], $_GET['pieza']);
}

$tablero = obtenerTablero($tablero_id);
?>

<h1>Tablero compartido</h1>

<?php dibujarTablero($tablero); ?>

<form id="formulario" method="get">
    <input type="hidden" name="id" value="<?= $tablero_id ?>">

    Posición:
    <input  pattern="^[a-h][1-8]$" title="Se necesita una coordenada correcta, por ejemplo e3" name="posicion" id="posicion" required>

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

<a href="tablerocompartido.php?id=<?= $tablero_id ?>">Compartir</a>

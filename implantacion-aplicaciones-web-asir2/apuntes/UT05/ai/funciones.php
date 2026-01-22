<?php
require_once "db.php";

function crearTablero(){
    global $mysqli;
    $mysqli->query("INSERT INTO tableros VALUES ()");
    return $mysqli->insert_id;

}

function obtenerTablero($tablero_id) {
    global $mysqli;
    $res = $mysqli->query("SELECT posicion, pieza FROM piezas WHERE tablero_id=$tablero_id");
    $tablero = [];
    while ($row = $res->fetch_assoc()) {
        $tablero[$row['posicion']] = $row['pieza'];
    }
    return $tablero;
}

function rellenaTablero($tablero_id){
    global $mysqli;
    $res = $mysqli->query("delete FROM piezas WHERE tablero_id=$tablero_id");
    $posiciones = ["a1" => "♖",
     "b1" => "♘",
     "c1" => "♗",
     "d1" => "♕",
     "e1" => "♔",
     "f1" => "♗",
     "g1" => "♘",
     "h1" => "♖",
     "a2" => "♙",
     "b2" => "♙",
     "c2" => "♙",
     "d2" => "♙",
     "e2" => "♙",
     "f2" => "♙",
     "g2" => "♙",
     "h2" => "♙",
     "a8" => "♜",
     "b8" => "♞",
     "c8" => "♝",
     "d8" => "♛",
     "e8" => "♚",
     "f8" => "♝",
     "g8" => "♞",
     "h8" => "♜",
     "a7" => "♟",
     "b7" => "♟",
     "c7" => "♟",
     "d7" => "♟",
     "e7" => "♟",
     "f7" => "♟",
     "g7" => "♟",
     "h7" => "♟",
    ];
    foreach( $posiciones as $coordenada => $pieza ){
        guardarPieza($tablero_id, $coordenada, $pieza );
    }
}

function guardarPieza($tablero_id, $posicion, $pieza) {
    global $mysqli;

    if ($pieza === '') {
        $stmt = $mysqli->prepare("DELETE FROM piezas WHERE tablero_id=? AND posicion=?");
        $stmt->bind_param("is", $tablero_id, $posicion);
    } else {
        $stmt = $mysqli->prepare("
            REPLACE INTO piezas (tablero_id, posicion, pieza)
            VALUES (?, ?, ?)
        ");
        $stmt->bind_param("iss", $tablero_id, $posicion, $pieza);
    }
    $stmt->execute();
}

function dibujarTablero($tablero) {
    echo "<table border='0'>";
    ?>
       <script>
            function ponerPosicion(pos){
                document.getElementById("posicion").value = pos;
            }
       </script>
    <?php
    $color = "white";
    for ($fila = 8; $fila >= 1; $fila--) {
        echo "<tr>";
        echo "<td>$fila</td>";
        for ($col = 'a'; $col <= 'h'; $col++) {
            $pos = $col . $fila;
            echo "<td align='center' style='width:55px; height:55px; background-color: $color; font-size:3em' onclick='ponerPosicion(\"\")'>";
            echo $tablero[$pos] ?? "&nbsp;";
            echo "</td>";
            $color = $color == "white" ? "lightgray" : "white";
        }
        $color = $color == "white" ? "lightgray" : "white";
        echo "</tr>";
    }
    echo "<tr>";
    echo "<td></td>";
    for ($col = 'a'; $col <= 'h'; $col++) {
        echo "<td align='center'>$col</td>";
    }
    echo "</tr>";
    echo "</table>";
}

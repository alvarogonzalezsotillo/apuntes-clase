<?php
// test-db.php — Comprueba la conexion a MySQL usando el nombre de servicio "db"
$host = 'db';
$user = 'wp_user';
$pass = 'wp_pass_2026';
$db   = 'wordpress';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_errno) {
    http_response_code(500);
    echo '<h1 style="color:#c0392b">Error de conexion a MySQL</h1>';
    echo '<p>' . $conn->connect_error . '</p>';
    exit;
}

echo '<h1 style="color:#27ae60">Conexion a MySQL correcta</h1>';
echo '<p>Servidor: <code>' . $conn->server_info . '</code></p>';

$res = $conn->query('SHOW TABLES');
if ($res) {
    $n = $res->num_rows;
    echo '<p>Base de datos <code>wordpress</code>: ' . $n . ' tablas'
       . ($n > 0 ? ' (WordPress instalado)' : ' (aun sin instalar)') . '</p>';
}
$conn->close();
<?php
// index.php — Pagina de bienvenida del servidor LAMP
$servidor = php_uname('n');
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>LAMP Project ASIR</title>
  <style>
    body { font-family: sans-serif; max-width: 700px; margin: 40px auto; color: #222; }
    h1   { color: #1a5276; }
    pre  { background: #f4f4f4; padding: 12px; border-radius: 4px; }
    .ok  { color: #27ae60; font-weight: bold; }
  </style>
</head>
<body>
  <h1>Servidor LAMP &mdash; Proyecto ASIR</h1>
  <p class="ok">Servidor operativo</p>
  <p><strong>Contenedor:</strong> <?= $servidor ?></p>
  <pre><?php phpinfo(INFO_MODULES); ?></pre>
  <ul>
    <li><a href="test-db.php">Test de conexion a MySQL</a></li>
  </ul>
</body>
</html>
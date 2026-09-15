#!/bin/bash
# Preparacion automatica del proyecto ASIR.
# Uso: ./scripts/install.sh
set -euo pipefail
cd "$(dirname "$0")/.."

echo "[1/3] Creando directorios de datos"
mkdir -p apache/www db/data

echo "[2/3] Desplegando WordPress (fases 1 y 3)"
if [ ! -f "apache/www/wp-config.php" ]; then
  curl -fsSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz
  tar -xzf /tmp/wordpress.tar.gz -C apache/www --strip-components=1

  SALTS=""
  for i in AUTH_KEY SECURE_AUTH_KEY LOGGED_IN_KEY NONCE_KEY \
           AUTH_SALT SECURE_AUTH_SALT LOGGED_IN_SALT NONCE_SALT; do
    SALTS+=$(printf "define('%s', '%s');\n" "$i" "$(openssl rand -base64 48)")
  done

  cat > apache/www/wp-config.php <<EOF
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wp_user');
define('DB_PASSWORD', 'wp_pass_2026');
define('DB_HOST', 'db');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

$SALTS
\$table_prefix = 'wp_';

define('WP_DEBUG', false);

// Acceso final a traves del proxy inverso
define('WP_HOME', 'http://www.asir.test');
define('WP_SITEURL', 'http://www.asir.test');

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF
  echo "  - wp-config.php generado"
fi

echo "[3/3] Configurando WireGuard (fase 5)"
if [ ! -f .env ]; then
  HOST_IP=$(hostname -I | awk '{print $1}')
  cat > .env <<EOF
WG_HOST=${HOST_IP}
WG_PASSWORD=asir-vpn-2026
EOF
  echo "  - .env generado (WG_HOST=${HOST_IP})"
fi

echo "Listo. Ejecuta:  docker compose up -d --build"
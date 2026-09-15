#!/bin/bash
# Verificacion del despliegue completo.
set -euo pipefail
cd "$(dirname "$0")/.."

DNS_IP=172.21.0.53

echo "=== 1. Contenedores ==="
docker compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

echo "=== 2. Resolucion directa asir.test ==="
for n in dns proxy www vpn apache db pma phpmyadmin; do
  r=$(dig +short "@${DNS_IP}" "${n}.asir.test" A | head -n1)
  echo "  ${n}.asir.test -> ${r:-SIN RESPUESTA}"
done

echo "=== 3. Resolucion inversa ==="
for ip in 172.21.0.53 172.21.0.10 172.21.0.20 \
          172.22.0.11 172.22.0.12 172.22.0.13; do
  echo "  ${ip} -> $(dig +short -x "${ip}" "@${DNS_IP}")"
done

echo "=== 4. Proxy inverso ==="
curl -s -o /dev/null -w "  www.asir.test -> HTTP %{http_code}\n" \
     -H "Host: www.asir.test" http://127.0.0.1/
curl -s -o /dev/null -w "  pma.asir.test -> HTTP %{http_code}\n" \
     -H "Host: pma.asir.test" http://127.0.0.1/

echo "=== 5. SSH en backend (fase 5) ==="
docker compose exec apache bash -c 'pgrep sshd >/dev/null && echo "  sshd OK en apache"'
docker compose exec db bash -c 'pgrep sshd >/dev/null && echo "  sshd OK en db"'

echo "=== 6. Log de WireGuard ==="
docker compose logs vpn 2>/dev/null | tail -n 3
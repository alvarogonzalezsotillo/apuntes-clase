# Solución de la práctica: cortafuegos con iptables en un router Docker

Solución de la práctica 04 de la UT4 de *Seguridad y Alta Disponibilidad*.

## Contenido

```example
solucion-practica/
├── docker-compose.yml      # Escenario completo (router, http, mysql, cliente-admin)
├── router/
│   └── firewall.sh         # Reglas de iptables del router
└── http/
    └── index.html          # Página que sirve el contenedor http
```

## Puesta en marcha

```bash
cd solucion-practica
docker compose up -d

# Espera a que el router instale las herramientas (unos segundos) y aplica el cortafuegos
docker exec router bash /firewall.sh
```

El prefijo de las redes creadas por Compose depende del nombre del directorio
del proyecto (`solucion-practica_wan` y `solucion-practica_lan` en este caso).

## Comprobaciones

```bash
# Desde el host (172.30.0.1 en la red wan)
ping -c 2 172.30.0.2
curl -v http://172.30.0.2:8080/                 # permitido: DNAT + SNAT hacia 192.168.50.10
curl -m 3 http://172.30.0.2:80/                 # bloqueado
timeout 5 bash -c 'cat < /dev/null > /dev/tcp/172.30.0.2/3306'; echo $?   # bloqueado (124)

# Desde el cliente de administración (172.30.0.100)
docker exec cliente-admin mariadb --connect-timeout=5 \
  -h 172.30.0.2 -P 3306 -u alumno -palumno1234 -e "SELECT VERSION();"

# Intentos bloqueados a MySQL, en el log del kernel del host
sudo dmesg | grep MYSQL-DENEGADO

# Reglas y conexiones en el router
docker exec router iptables -L -n -v
docker exec router iptables -t nat -L -n -v
docker exec router conntrack -L
```

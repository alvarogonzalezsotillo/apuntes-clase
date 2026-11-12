#!/bin/bash
# Cortafuegos de la practica 04.
# Ejecutar como root dentro del contenedor router:
#   docker exec router bash /firewall.sh

set -e

WAN_IF=eth0
LAN_IF=eth1
WAN_IP=192.168.1.150
LAN_IP=192.168.51.2
LAN_NET=192.168.51.0/24
HTTP_IP=192.168.51.10
MYSQL_IP=192.168.51.20
ADMIN_IP=192.168.1.151

# Limpiar reglas anteriores
iptables -F
iptables -t nat -F

# Politicas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Loopback y conexiones establecidas
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Diagnostico: ping al router desde la WAN
iptables -A INPUT -i "$WAN_IF" -p icmp --icmp-type echo-request -j ACCEPT

# Publicacion de HTTP: 172.30.0.2:8080 -> 192.168.50.10:80
iptables -t nat -A PREROUTING -i "$WAN_IF" -d "$WAN_IP" \
  -p tcp --dport 8080 -j DNAT --to-destination "$HTTP_IP":80
iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -p tcp \
  -d "$HTTP_IP" --dport 80 \
  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

# Publicacion de MySQL: 172.30.0.2:3306 -> 192.168.50.20:3306
iptables -t nat -A PREROUTING -i "$WAN_IF" -d "$WAN_IP" \
  -p tcp --dport 3306 -j DNAT --to-destination "$MYSQL_IP":3306

# Solo el cliente de administracion puede acceder a MySQL
iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -s "$ADMIN_IP" \
  -p tcp -d "$MYSQL_IP" --dport 3306 \
  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

# Registrar y bloquear el resto de intentos a MySQL
iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -p tcp \
  -d "$MYSQL_IP" --dport 3306 \
  -j LOG --log-prefix "MYSQL-DENEGADO: " --log-level 4
iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -p tcp \
  -d "$MYSQL_IP" --dport 3306 -j DROP

# SNAT del trafico reenviado hacia la LAN. Necesario por el
# aislamiento que Docker aplica a las redes internal (ver la
# practica): sin el, el host descarta los paquetes DNATeados
# por llegar al puente de la lan con un origen ajeno a la subred.
iptables -t nat -A POSTROUTING -o "$LAN_IF" -d "$LAN_NET" \
  -j SNAT --to-source "$LAN_IP"

echo "Reglas aplicadas correctamente."

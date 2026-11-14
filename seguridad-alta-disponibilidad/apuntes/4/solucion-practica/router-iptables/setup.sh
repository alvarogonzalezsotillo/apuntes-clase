# ORDENES INICIALES PARA CONTAINER router-iptables. NO SE LANZAR AUTOMÁTICAMENTE, SON MANUALES

set -xe

WAN_IF=eth2
LAN_IF=eth1
SERVERS_IF=eth0

HTTP_IP=192.168.52.10
SERVERS_ROUTER_IP=192.168.52.254


limpiar_tablas(){
    # Deja las politicas en ACCEPT antes de vaciar, para no cortar el acceso
    iptables --policy INPUT ACCEPT
    iptables --policy FORWARD ACCEPT
    iptables --policy OUTPUT ACCEPT
    # Vaciar y borrar cadenas de usuario en las tablas usadas por el script
    iptables --table filter --flush
    iptables --table filter --delete-chain
    iptables --table nat --flush
    iptables --table nat --delete-chain
}

politicas_por_defecto(){
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    iptables -A INPUT -i lo -j ACCEPT
}

conexiones_ya_establecidas(){
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
}

nat_hacia_wan(){
    iptables -t nat -A POSTROUTING -o $WAN_IF -j MASQUERADE
}

abrir_puerto_80_hacia_http(){
    # DNAT: el puerto 80 del WAN se redirige a http:80
    iptables -t nat -A PREROUTING -i $WAN_IF -p tcp --dport 80 -j DNAT --to-destination $HTTP_IP:80
    # Permitir el reenvio hacia la red servers
    iptables -A FORWARD -i $WAN_IF -o $SERVERS_IF -p tcp -d $HTTP_IP --dport 80 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
    # SNAT hacia servers: necesario por el aislamiento que Docker aplica a las
    # redes internal, para que la respuesta de http vuelva por el router
    # NO HACE FALTA, SE LE PONE ROUTER POR DEFECTO A http
    #iptables -t nat -A POSTROUTING -o $SERVERS_IF -p tcp -d $HTTP_IP --dport 80 -j SNAT --to-source $SERVERS_ROUTER_IP
}

permitir_ping_a_lan(){
    iptables -A INPUT -p icmp -i $LAN_IF --icmp-type echo-request -j ACCEPT
    iptables -A FORWARD -p icmp -i $LAN_IF --icmp-type echo-request -j ACCEPT
}

permitir_http_en_lan(){
    iptables -A FORWARD -i $LAN_IF -o $SERVERS_IF -p tcp -d $HTTP_IP --dport 80 -j ACCEPT
}

log_paquetes_no_aceptados(){
    iptables -A INPUT -m limit --limit 30/min --limit-burst 30 -j LOG --log-prefix "IPTABLES INPUT DROP: " --log-level 4
    iptables -A FORWARD -m limit --limit 30/min --limit-burst 30 -j LOG --log-prefix "IPTABLES FORWARD DROP: " --log-level 4
    iptables -A OUTPUT -m limit --limit 30/min --limit-burst 30 -j LOG --log-prefix "IPTABLES OUTPUT DROP: " --log-level 4
}

bucle_comprueba_reglas(){
    watch -d "iptables --list INPUT --numeric --verbose; iptables --list OUTPUT --numeric --verbose;  iptables --list FORWARD --numeric --verbose"
}

main(){
    limpiar_tablas
    politicas_por_defecto
    conexiones_ya_establecidas
    nat_hacia_wan
    permitir_ping_a_lan
    permitir_http_en_lan
    abrir_puerto_80_hacia_http
    log_paquetes_no_aceptados
    bucle_comprueba_reglas
}


main "$@"

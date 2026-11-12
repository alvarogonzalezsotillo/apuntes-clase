set -xe

WAN_IF=eth2
LAN_IF=eth1
SERVERS_IF=eth0


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

permitir_ping_a_lan(){
    iptables -A INPUT -p icmp -i $LAN_IF --icmp-type echo-request -j ACCEPT
}

log_paquetes_no_aceptados(){
    iptables -A INPUT -m limit --limit 5/min --limit-burst 10 -j LOG --log-prefix "IPTABLES INPUT DROP: " --log-level 4
    iptables -A FORWARD -m limit --limit 5/min --limit-burst 10 -j LOG --log-prefix "IPTABLES FORWARD DROP: " --log-level 4
    iptables -A OUTPUT -m limit --limit 5/min --limit-burst 10 -j LOG --log-prefix "IPTABLES OUTPUT DROP: " --log-level 4
}

main(){
    politicas_por_defecto
    conexiones_ya_establecidas
    nat_hacia_wan
    permitir_ping_a_lan
    log_paquetes_no_aceptados
}


main "$@"

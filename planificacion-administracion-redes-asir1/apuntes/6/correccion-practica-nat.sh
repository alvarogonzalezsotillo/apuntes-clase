#!/bin/bash

traza(){
    echo $*
}

progreso(){
    echo $* 1>&2
}


probar_ssh(){
    local IP="$1"
    local PUERTO="${2:-22}"
    echo quit | nc -w 5 -v "$IP" "$PUERTO" | grep SSH > /dev/null
}


probar_rdp(){
    local IP="$1"
    local PUERTO="${2:-3389}"
    echo no | timeout -k 5s 5s rdesktop $IP:$PUERTO 2>&1 | grep Issuer > /dev/null
}

probar_cifs(){
    local IP="$1"
    echo quit | timeout -k 5s 5s smbclient '\\'$IP'\IPC$' | grep NT_STATUS_ACCESS_DENIED > /dev/null
}

probar_alumno_ssh(){
    local NUMERO=$1

    progreso Probando alumno SSH $ALUMNO
    if probar_ssh 192.168.255.$NUMERO 22
    then
        traza $NUMERO SSH 192.168.255.$NUMERO:22 SSH accesible
    fi

    if probar_ssh 192.168.255.$NUMERO 222
    then
        traza $NUMERO SSH2 192.168.255.$NUMERO:222 SSH secundario accesible
    fi
}

probar_alumno_rdp(){
    local NUMERO=$1

    progreso Probando alumno RDP $ALUMNO    
    if probar_rdp 192.168.255.$NUMERO
    then
        traza $NUMERO RDP 192.168.255.$NUMERO RDP accesible
    fi
}

probar_alumno_cifs(){
    local NUMERO=$1

    progreso Probando alumno CIFS $ALUMNO
    if probar_cifs 192.168.255.$NUMERO
    then
        traza $NUMERO CIFS 192.168.255.$NUMERO Carpetas compartidas accesible
    fi
    
}


probar_alumno(){
    local ALUMNO=$1
    (
        probar_alumno_rdp $ALUMNO &
        probar_alumno_ssh $ALUMNO &
        probar_alumno_cifs $ALUMNO &
        wait
    )
}

ALUMNOS="
100
102
104
106
108
110
112
114
116
118
120
122
124
126
128
130
132
134
136
138
140
142
144
146
148
150
152
154
200
"

main(){
    sudo ip addr add dev enp0s31f6 192.168.255.201/24

    for ALUMNO in $ALUMNOS
    do
        probar_alumno $ALUMNO &
    done
}

main 2> /dev/null | sort | sort --key=2




exit


algo(){
    Every 2,0s: ./correccion-practica-nat.sh            a33pcprofesor: Mon Apr  4 09:59:41 2022

    102 CIFS 192.168.255.102 Carpetas compartidas accesible
    108 CIFS 192.168.255.108 Carpetas compartidas accesible
    138 CIFS 192.168.255.138 Carpetas compartidas accesible
    150 CIFS 192.168.255.150 Carpetas compartidas accesible
    200 CIFS 192.168.255.200 Carpetas compartidas accesible
    102 RDP 192.168.255.102 RDP accesible
    104 RDP 192.168.255.104 RDP accesible
    108 RDP 192.168.255.108 RDP accesible
    110 RDP 192.168.255.110 RDP accesible
    114 RDP 192.168.255.114 RDP accesible
    116 RDP 192.168.255.116 RDP accesible
    120 RDP 192.168.255.120 RDP accesible
    132 RDP 192.168.255.132 RDP accesible
    136 RDP 192.168.255.136 RDP accesible
    138 RDP 192.168.255.138 RDP accesible
    146 RDP 192.168.255.146 RDP accesible
    150 RDP 192.168.255.150 RDP accesible
    152 RDP 192.168.255.152 RDP accesible
    200 RDP 192.168.255.200 RDP accesible
    102 SSH 192.168.255.102:22 SSH accesible
    104 SSH 192.168.255.104:22 SSH accesible
    108 SSH 192.168.255.108:22 SSH accesible
    110 SSH 192.168.255.110:22 SSH accesible
    114 SSH 192.168.255.114:22 SSH accesible
    116 SSH 192.168.255.116:22 SSH accesible
    118 SSH 192.168.255.118:22 SSH accesible
    120 SSH 192.168.255.120:22 SSH accesible
    138 SSH 192.168.255.138:22 SSH accesible
    146 SSH 192.168.255.146:22 SSH accesible
    152 SSH 192.168.255.152:22 SSH accesible
    200 SSH 192.168.255.200:22 SSH accesible
    200 SSH2 192.168.255.200:222 SSH secundario accesible
}

algo(){
    Every 2,0s: ./correccion-practica-nat.sh            a33pcprofesor: Mon Apr  4 10:05:16 2022

    102 CIFS 192.168.255.102 Carpetas compartidas accesible
    108 CIFS 192.168.255.108 Carpetas compartidas accesible
    132 CIFS 192.168.255.132 Carpetas compartidas accesible
    150 CIFS 192.168.255.150 Carpetas compartidas accesible
    200 CIFS 192.168.255.200 Carpetas compartidas accesible
    102 RDP 192.168.255.102 RDP accesible
    104 RDP 192.168.255.104 RDP accesible
    108 RDP 192.168.255.108 RDP accesible
    110 RDP 192.168.255.110 RDP accesible
    114 RDP 192.168.255.114 RDP accesible
    116 RDP 192.168.255.116 RDP accesible
    120 RDP 192.168.255.120 RDP accesible
    136 RDP 192.168.255.136 RDP accesible
    146 RDP 192.168.255.146 RDP accesible
    150 RDP 192.168.255.150 RDP accesible
    152 RDP 192.168.255.152 RDP accesible
    200 RDP 192.168.255.200 RDP accesible
    102 SSH 192.168.255.102:22 SSH accesible
    104 SSH 192.168.255.104:22 SSH accesible
    108 SSH 192.168.255.108:22 SSH accesible
    110 SSH 192.168.255.110:22 SSH accesible
    114 SSH 192.168.255.114:22 SSH accesible
    116 SSH 192.168.255.116:22 SSH accesible
    118 SSH 192.168.255.118:22 SSH accesible
    120 SSH 192.168.255.120:22 SSH accesible
    138 SSH 192.168.255.138:22 SSH accesible
    146 SSH 192.168.255.146:22 SSH accesible
    152 SSH 192.168.255.152:22 SSH accesible
    200 SSH 192.168.255.200:22 SSH accesible
    200 SSH2 192.168.255.200:222 SSH secundario accesible
    
}

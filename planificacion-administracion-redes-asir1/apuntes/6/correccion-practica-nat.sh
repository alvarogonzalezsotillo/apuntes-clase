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
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
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



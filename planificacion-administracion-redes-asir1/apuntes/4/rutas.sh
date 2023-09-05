#!/bin/bash

ruta(){
  local ALUMNO=$1

  sudo ip route add 192.168.$ALUMNO.0/24 via 10.1.33.$ALUMNO
}

enruta(){
  sudo sysctl -w net.ipv4.ip_forward=1
}


rutas(){
  for A in $(seq 100 130)
  do
    ruta $A
  done
}

ping_ip(){
  local IP=$1
  if ping -c 2 -i 0.2 -W 1 $IP > /dev/null
  then
    echo ENCONTRADO:$IP
  else
    echo ERROR:$IP
  fi
  
}
  


ping_alumno(){
  local ALUMNO=$1
  ping_ip 10.1.33.$ALUMNO
  ping_ip 192.168.$ALUMNO.1
  ping_ip 192.168.$ALUMNO.2
}


monitoriza(){
    while true
    do
        for A in $(seq 100 130)
        do
            ping_alumno $A &
        done | sort
        sleep 10s
    done
}

enruta

monitoriza


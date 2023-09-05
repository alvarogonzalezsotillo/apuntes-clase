#!/bin/bash

DEB_URL=http://nasavellaneda.local/alvaro/pt-820/CiscoPacketTracer_820_Ubuntu_64bit.deb
AULA=a33
USUARIO=profesor

nombres_de_ordenadores_de_alumno()(
    echo a33pc06.local
    return
    local AULA=${1:-$AULA_DEFECTO}
    for ORDENADOR in $(seq 1 16)
    do
        printf "%spc%02d.local\n" $AULA $ORDENADOR
    done
)

detecta_parallel_ssh(){
    if ! which parallel-ssh > /dev/null
    then
        echo "Se necesita parallel-ssh. Se instala con:"
        echo "   sudo apt install pssh"
        exit 1
    fi
}

detecta_parallel_ssh


if [ $? -ne 0 ]
then
    echo Instalación cancelada
    exit 1
fi

echo "--------"
echo "--------"
echo Se solicitará la contraseña del usuario $USUARIO en los ordenadores de los alumnos
if [ $USUARIO != root ]
then
    echo El usuario $USUARIO debe tener capacidad de realizar sudo sin contraseña
fi
echo "--------"
echo "--------"

mkdir -p outdir
parallel-ssh --hosts <(nombres_de_ordenadores_de_alumno $AULA) --timeout 120 --askpass --user $USUARIO --errdir outdir --outdir outdir --extra-args "-o StrictHostKeyChecking=no" "wget -O instalacion.deb $DEB_URL; yes si | sudo dpkg -i instalacion.deb; rm instalacion.deb" 

echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

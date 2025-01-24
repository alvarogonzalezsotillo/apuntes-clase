#!/bin/bash

AULA=a37
USUARIO=profesor

nombres_de_ordenadores_de_alumno()(
    local AULA=${1:-$AULA_DEFECTO}
    for ORDENADOR in $(seq 1 16)
    do
        printf "%spc%02d.local\n" $AULA $ORDENADOR
    done
)

detecta_parallel_ssh(){
    if ! which pssh > /dev/null
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
echo No se solicitará la contraseña del usuario $USUARIO en los ordenadores de los alumnos, debe hacerse login ssh con clave público-privada
echo El usuario $USUARIO debe tener capacidad de realizar sudo sin contraseña
echo "--------"
echo "--------"

rm -r outdir
mkdir -p outdir
pssh --hosts <(nombres_de_ordenadores_de_alumno $AULA) --timeout 120 --user $USUARIO --errdir outdir --outdir outdir --extra-args "-o StrictHostKeyChecking=no" "sudo yum install -y vim"

#pssh --hosts <(nombres_de_ordenadores_de_alumno $AULA) --timeout 120 --user $USUARIO --errdir outdir --outdir outdir --extra-args "-o StrictHostKeyChecking=no" "PASSW='profesor:'; echo \"\$PASSW\" | sudo chpasswd"
#pssh --hosts <(nombres_de_ordenadores_de_alumno $AULA) --timeout 120 --user $USUARIO --errdir outdir --outdir outdir --extra-args "-o StrictHostKeyChecking=no" "PASSW='root:'; echo \"\$PASSW\" | sudo chpasswd"


echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

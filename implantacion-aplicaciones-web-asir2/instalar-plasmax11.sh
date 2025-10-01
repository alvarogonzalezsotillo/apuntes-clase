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
        echo "   sudo dnf install pssh"
        exit 1
    fi
}

detecta_parallel_ssh


if [ $? -ne 0 ]
then
    echo Instalación cancelada
    exit 1
fi


if [ "$PASSWORD" = "" ]
then
    echo La variable PASSWORD debe tener la contraseña en binario, con xxd -p
    echo "export PASSWORD=\$(printf 'xxxxxxxxxxxxx' | xxd -p)"
    exit 1
fi


rm -r outdir
mkdir -p outdir
pssh --askpass --hosts <(nombres_de_ordenadores_de_alumno $AULA) --timeout 2400 --user $USUARIO --errdir outdir --outdir outdir --extra-args "-o StrictHostKeyChecking=no" "
echo Parece que estoy dentro
whoami
hostname
printf $PASSWORD | xxd -p -r | sudo --stdin cp /home/profesor/repos/*.repo /etc/yum.repos.d/
echo 1
printf $PASSWORD | xxd -p -r | sudo --stdin dnf --assumeyes update
echo 2
printf $PASSWORD | xxd -p -r | sudo --stdin dnf --assumeyes install plasma-workspace-x11
echo 3
printf $PASSWORD | xxd -p -r | sudo --stdin rm /etc/yum.repos.d/*.repo
echo 4
"

echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

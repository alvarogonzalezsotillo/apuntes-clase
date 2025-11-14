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
printf $PASSWORD | xxd -p -r | sudo --stdin sh -c \"sed -i '/10.1.33.202/d' /etc/hosts\"
printf $PASSWORD | xxd -p -r | sudo --stdin sh -c \"curl http://10.1.0.100/profesores/alvaro/hosts-para-coder.txt >> /etc/hosts\"
cat /etc/group
cat /etc/passwd
cat /etc/hosts
echo FIN
"

echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

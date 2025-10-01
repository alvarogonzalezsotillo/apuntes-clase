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
#curl http://10.1.0.100/Virtualbox/VirtualBox-7.2-7.2.2_170484_fedora40-1.x86_64.rpm > VirtualBox-7.2-7.2.2_170484_fedora40-1.x86_64.rpm
#printf $PASSWORD | xxd -p -r | sudo --stdin dnf remove --assumeyes VirtualBox-7.1-7.1.8_168469_fedora40-1.x86_64
#printf $PASSWORD | xxd -p -r | sudo --stdin rpm -ivh VirtualBox-7.2-7.2.2_170484_fedora40-1.x86_64.rpm
#printf $PASSWORD | xxd -p -r | sudo --stdin modprobe kvm
#printf $PASSWORD | xxd -p -r | sudo --stdin modprobe kvm_intel
printf $PASSWORD | xxd -p -r | sudo --stdin cp /home/profesor/repos/*.repo /etc/yum.repos.d/
printf $PASSWORD | xxd -p -r | sudo --stdin dnf install --assumeyes libnsl
printf $PASSWORD | xxd -p -r | sudo --stdin rm /etc/yum.repos.d/*.repo
echo FIN
"

echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

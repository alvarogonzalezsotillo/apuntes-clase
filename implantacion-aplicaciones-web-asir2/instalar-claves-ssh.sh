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
rm ./.ssh/authorized_keys
echo \"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlFeDV76uxp+yxw80l8YqF1g2gZlHhVjQOV8/MZIERy alvaro@a37\" >> ./.ssh/authorized_keys
echo  >> ./.ssh/authorized_keys
echo \"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkG5MIZRi0BuIin/5B+DqBHBIGfvjuGY3TZEhMuG0KKbN4Pemqs8njlkGXJZSm2t3QlRibxQg4PDLo0rRHa7xm7IId8l2UQY5ul738x/IHrr5LYQY7zyqMnj2XUV/UL/Cwwqh+hrBWKODPbE7z9gkH6FRuaM3optx00c6XYDAH76e0vxAetkoDMTCxEuNiWbAtAPIFP0saDENb17ILH06DCrdVRTUzvhY5nM3YV4Xpaw77HEuc5n6SfOu9gEkMo6Jj+tU2bj4UjuWzh7CagIYYMboa8TBW5v3kX30DElENnLk2qcp7Xr8nbh0+7WmHeyjesI++Qg9e/S+Fe9qbUWc2zOBkSg8aqC8I/a/C6NPd4F2TqM6HhBaO4XGlbL/gqo5WjFvcL2Y1ZgFcud7XarQv+T7xecfDkqXxvNGY5wf+w3QRUoZijn/Yozlojazxo2h2J6k+bZycM1b34El1gSecMlTZQF7T5YyOjlpSUL0rRhIaZpp8UTyik4AF7U2sW2E= profesor@a38profesor
\" >> ./.ssh/authorized_keys
echo  >> ./ssh/authorized_keys
chmod 600 ./ssh/authorized_keys
echo FIN
"

echo "--------"
echo "--------"
echo Los resultados están en el directorio outdir

#!/bin/bash
# Colores
declare -r greenColour="\e[0;32m\033[1m"
declare -r endcolor="\033[0m\e[0m"
declare -r redcolor="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowcolor="\e[0;33m\033[1m"
declare -r purplecolor="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

function ctrl_c(){
    echo -e "$redcolor\n\n[!] Saliendo...\n"
    tput cnorm;exit 1
}
# Ctrl-c
trap ctrl_c INT

function NumParameters(){ # funciona tal que NumParameters $# 'numeroquequieras
    if [[ $1 -gt $2 || $1 -lt $2 ]]; then
        echo -e "$N"
        echo -e "$redcolor[!] Nº de parámetros incorrecto, el correcto es $purplecolor$2\n"
    tput cnorm;exit 1
    fi
}

tput civis #ocultar cursor
#declaración de variables
counter=0
host=$1 #$0 corresponde al nombre del script

#comprobación nº parámetros correcto:
Numcorrecto=1
NumParameters $# $Numcorrecto
for port in $(seq 65535)
do
  if [[ "$counter" == '500' ]]; then
    echo "Llevas $counter puertos"
    ((counter=0))
  fi
timeout 1 bash -c "echo '' > /dev/tcp/$host/$port" 2>/dev/null && echo -e "$yellowcolor [+] Puerto $port ABIERTO $endcolor" &
((counter=counter+1))
done; wait

echo 'Sí, ¡eso es todo!'

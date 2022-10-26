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

#Explanation
N='Usage:  script [host] '

function ctrl_c(){
    echo -e "$redcolor\n\n[!] Saliendo...\n" 
    echo Habias escaneado hasta el puerto $port.
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
host=$1 #$0 corresponde al nombre del script
counter=0
#comprobación nº parámetros correcto:
Numcorrecto=1

if [[ $# -eq $Numcorrecto ]]; then
	for port in $(seq 65535)
	do
	  if [[ $((port % 500)) == 0 ]]; then
	    echo "Llevas $port puertos"
	  fi
	timeout 1 bash -c "echo '' > /dev/tcp/$host/$port" 2>/dev/null && echo -e "$yellowcolor [+] Puerto $port ABIERTO $endcolor" &
	done; wait
	echo -e "\n$blueColour[!]  Has escaneado todos los puertos TCP en $host";exit 0
else 
	Numcorrecto=3
	if [[ $# == $Numcorrecto ]]; then
		puertosMin=$2; puertosMax=$3; echo $puertosMin $puertosMax;
		for ((port=$puertosMin;port<puertosMax;port++)) #for port in {$2.. $3} for i in {1..1000}
		do
		  if [[ $((port % 500)) == 0 ]]; then
		    echo "Vas por el puerto $port"
		  fi
		timeout 1 bash -c "echo '' > /dev/tcp/$host/$port" 2>/dev/null && echo -e "$yellowcolor [+] Puerto $port ABIERTO $endcolor" &
		done; wait
		echo -e "\n$blueColour[!] Has descubierto todos los puertos puertos abiertos port TCP entre $puertosMin y $puertosMax en $host";exit 0
	fi
fi
NumParameters 1 10

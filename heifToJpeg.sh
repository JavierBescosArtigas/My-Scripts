#!/bin/bash
#Ejecutable made by AtomicAnt
#Colours

declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

function ctrl_c() {
echo -e "$endColour[!]$redColour Saliendo..., los archivos que ya se han transformado se encuentran en heiftojpeg, si quiere seguir elimine los .heic que se llamen igual a los siguientes, y renombre la carpeta heiftojpeg ó se borrará automáticamente al correr el script otra vez!"
tput cnorm; exit 1
}

#ctrl-c
tput civis
trap ctrl_c INT
echo -e "[~]$greenColour Funcionamiento: sitúate en una carpeta con .heic archivos y escriba $purpleColour'go'$greenColour, automáticamente transforma los archivos a jpeg y los guarda en una carpeta\n$endColour"
echo -e "[~]$greenColour si quiere descomprimir primero un .zip, escriba $purpleColour'zip'$greenColour, el zip debe contener los archivos, no carpetas con los archivos\n$endColour"
read -t 10 action
if [[ $action == 'zip' ]]; then
    echo -e "[!] $yellowColour Contenido del zip, asegúrese de que no tiene subcarpetas, el script no funciona recursivamente$endColour\n"
    nombreZip=$(for elto in $(ls *.zip); do echo $elto; break; done)
    7z l $nombreZip | tail -n 5
    echo -e "$blueColour[~] Empezando descompresión, esto puede llevar un rato según el nº de archivos...\n"
    echo -e "$yellowColour[!] Si hay elementos con el mismo nombre dentro del zip y en la carpeta actual, se atascará!"
    7z e $nombreZip >/dev/null
    echo -e "$endColour[~]$greenColour Ahora, si no hay subcarpetas escriba $purpleColour'go'$greenColour y se procederá a cambiar el formato de todos los .heic de la carpeta$endColour\n"
    read -t 10 action
fi
if [[ $action == 'go' ]]; then
    rm -rf ./heifTojpeg >/dev/null
    mkdir heifTojpeg
    counter=$(ls *.heic | wc -l)
    if which heif-convert >/dev/null; then
        echo -e "[~]$greenColour Todo bien para proceder a la transformación, hay $counter archivos que transformar$endColour\n"
        for file in *.heic
        do
            #echo $file #cut -d "." -f 1
            name=$(echo $file | cut -d "." -f 1)
            heif-convert -q 100 $file ./heifTojpeg/$name.jpg > /dev/null
            counter=$((counter-1))
            echo -e "$turquoiseColour Quedan $counter archivos"
        done
    else
        echo -e "$redColour[!] $yellowColour Falta instalar libhei-example! sudo apt...\n$endColour"
        tput cnorm; exit 1
    fi
else
    echo -e "$endColour[X]$redColour Saliendo..."
    tput cnorm; exit 0
fi
echo -e "$blueColour RESULTADO!\n$endColour"
ls ./heifTojpeg
echo Comprimiendo en .zip...
zip -r -9 jotapeges.zip heifTojpeg
rm -rf heifTojpeg
echo -e "[!]$greenColour ¿Quiere borrar todos los .heic de la carpeta actual? Escriba $purpleColour 'yes'$endColour"
read -t 300 action
if [[ $action == 'yes' ]]; then
    rm -rf ./*.heic
fi
echo "Adios!!!"; tput cnorm; exit 0


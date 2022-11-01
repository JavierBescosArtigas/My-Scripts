#!/bin/bash

#Colours

declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

echo -e "[~]$greenColour Funcionamiento: sitúate en una carpeta con .heic archivos y escriba 'go'; automáticamente transforma los archivos a jpeg y los guarda en una carpeta /n"
read action -t 10
if [[ $action -eq 'go' ]]; then
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
        exit 1
    fi
else
    echo "[X] Saliendo..."
fi
echo -e "$blueColour RESULTADO!\n"
ls ./heifTojpeg
echo Comprimiendo en .zip...
zip -r -9 jotapeges.zip heifTojpeg
rm -rf heifTojpeg
exit 0

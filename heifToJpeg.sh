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

echo -e "[~]$greenColour Funcionamiento: sitúate en una carpeta con .heic archivos y escriba 'go'; automáticamente transforma los archivos a jpeg y los guarda en una carpeta\n$endColour"
echo -e "[!]$blueColour si quiere descomprimir primero un .zip, escriba $purpleColour'zip'$blueColour, el zip debe contener los archivos, no carpetas con los archivos\n$endColour"
read -t 10 action
if [[ $action -eq 'zip' ]]; then
    echo -e "contenido del zip, asegúrese de que no tiene subcarpetas, se va a descomprimir, si tiene subcarpetas donde se encuentran los heif, primero desplácese a ellas y luego ejecute go\n"
    7z l ./*zip | tail -n 5
    echo -e "$redColour[!]Empezando descompresión, esto puede llevar un rato según el nº de archivos...\n"
    7z e ./*.zip >/dev/null
    echo -e "$endColour[~]$greenColour Ahora, si no hay subcarpetas escriba 'go' y se procederá a cambiar el formato de todos los .heic de la carpeta\n"
    read -t 10 action
fi
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
echo -e "$blueColour RESULTADO!\n$endColour"
ls ./heifTojpeg
echo Comprimiendo en .zip...
zip -r -9 jotapeges.zip heifTojpeg
rm -rf heifTojpeg
echo -e "[!]$redColour ¿Quiere borrar todos los .heic de la carpeta actual? Escriba $purpleColour 'Si'"
read -t 300 action
if [[ $action -eq 'Si' ]]; then
    rm -rf ./*.heic
fi
echo "Adios!!!"; exit 0


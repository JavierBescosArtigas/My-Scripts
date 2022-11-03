#!/bin/bash

#This script is used to copy to the clipboard all open ports as -oG format from nmap tool.

#Colours palette
declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

#Usage
echo
usage="$greenColour Usage: ./script.sh grepableNmapFile\n$endColour"

#main
if [ $# -eq 1 ]; then
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | cut -d '/' -f 1 | tr '\n' ',' | grep -oP '.*\d{1}')"
    host="$(cat $1 | grep -oP '^Host: (\d{1,3}\.){3}(\d+) \([a-zA-Z0-9\-]*\)'| sort -u | cut -d' ' -f1-3 | sed 's/(/-> /' | sed 's/)//')"

    echo -e "$grayColour [?] Host: $host\n"
    echo -e "$grayColour [?] Ports: $ports\n"
    echo $ports | tr -d '\n' | xclip -selection clip
    echo -e "$blueColour [!] Ports copied to clipboard\nNext step could be:$redColour nmap -p$ports -sCV -oN targeted\n"
    exit 0
else
    echo -e "$redColour [x] Bad usage $endColour\n$usage"
fi
exit 1

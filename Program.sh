#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Achte drauf, dass Du alleine bist!"
TITLE="Version 0.29"
MENU="Wähle folgende Optionen aus:"

OPTIONS=(1 "Verschlüsseln"
         2 "Entschlüsseln")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
        1)
           name=`dialog --inputbox "Bitte die Nachricht eingeben." 0 0 "Texteingabe" 3>&1 1>&2 2>&3`
           # Hier die Nachricht verschlüsselnwq
           echo "$name" > name.txt
           # openssl rand -hex 12
           openssl aes-256-cbc -salt -a -e -in name.txt -out encrypted.txt -pass pass:b04e75b0a83d90ea0721035e
           name=$(cat encrypted.txt)
           cat encrypted.txt | minimodem --write 300 -f send.wav
           dialog --clear
           dialog --msgbox "Deine Nachricht:\n$name" 15 40
           clear
           ;;

        2)
           openssl aes-256-cbc -salt -a -d -in encrypted.txt -out decrypted.txt -pass pass:b04e75b0a83d90ea0721035e
           name=$(cat decrypted.txt)
           dialog --msgbox "Nachricht:\n$name" 15 40
           clear
           ;;

esac 

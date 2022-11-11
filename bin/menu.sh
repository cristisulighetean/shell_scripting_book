#!/bin/bash
# Author: @cristiansulighetean
# Sample menu

while true
do
    clear
    echo "Choose an item: a, b, or c"
    echo "a: Backup"
    echo "b: Display calendar"
    echo "c: Exit"
    read -sn1
    case "$REPLY" in
        a) tar fczP $HOME/backup.tgz ${HOME}/bin;;
        b) cal;;
        c) exit 0;;
    esac
    read -n1 -p "Press any key to continue"
done

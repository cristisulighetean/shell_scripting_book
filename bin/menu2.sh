#!/bin/bash
# Author: @cristiansulighetean
# Sample menu using functions

function to_lower {
    input=$1
    output=$(tr [A-Z] [a-z] <<<"$input")
return $output
}

function do_backup {
    tar fczP $HOME/backup.tgz ${HOME}/bin
}

function show_cal {
    if [ -x /usr/bin/ncal ] ; then
      command="/usr/bin/ncal -w"
    else
      command="/usr/bin/cal"
    fi
    $command
}


while true
do
    clear
    echo "Choose an item: a, b, or c"
    echo "a: Backup"
    echo "b: Display calendar"
    echo "c: Exit"
    read -sn1
    case "$REPLY" in
        a) do_backup;;
        b) show_cal;;
        c) exit 0;;
    esac
    read -n1 -p "Press any key to continue"
done

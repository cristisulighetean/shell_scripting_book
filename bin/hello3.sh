#!/bin/bash
# Welcom script to display a message to users on login
# Author: @cristiansulighetean
# Date: 15/10/2022

read -p "Hello I $(basename $0) may I ask your name: " name
echo "Hello $name"
read -sn1 -p "Press any key to exit"
echo
exit 0

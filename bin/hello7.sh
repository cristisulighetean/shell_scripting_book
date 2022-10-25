#!/bin/bash
# Colorized welcome screen to display a message 
# to the users on login
# Author: @cristiansulighetean
# Date: 25.10.2022
source $HOME/snippets/color

if [ $# -lt 1 ] ; then
    echo -e "${RED}Usage: $0 <name>$RESET"
    echo 1
fi
echo -e "${GREEN}Hello $1$RESET"
exit 0
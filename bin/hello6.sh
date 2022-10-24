#!/bin/bash
# Script to display a message to user on login
# Author: @cristiansulighetean
# Date: 24.10.2022

if [ $# -lt 1 ] ; then
	printf >&2 '%s' 'Enter a name: '
	read name
else
	name=$1
fi

echo "Hello $name"
exit 0

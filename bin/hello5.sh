#!/bin/bash
# Script to display a message to user on login
# Author: @cristiansulighetean
# Date: 24.10.2022

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <name>"
	exit 1
fi

echo "Hello $1"
exit 0

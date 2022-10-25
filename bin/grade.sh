#!/bin/bash
# Script to evaluate grades
# Usage: grade.sh student grade
# Author: @cristiansulighetean

if [ ! "$#" = 2 ] ; then
	echo "You must provide <student><grade>"
	exit 2
fi

case $2 in
	[A-C] | [a-c]) 
		echo "$1 is a star pupil"
	;;
	[Dd]) 	
		echo "$1 needs to try a little harder!"
	;;
	[E-F] | [e-f]) 
		echo "$1 could do a lot better next year!"
	;;
	*) 
		echo "Grade could not be evaluated for $1"
	;;
esac

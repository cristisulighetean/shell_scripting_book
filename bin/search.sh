#!/bin/bash
#Author: @cristiansulighetean
#Date: 24.10.2022

usage="Usage: search.sh file string operation"

if [ ! "$#" = 3 ] ; then
	echo "$usage"
	exit 2
fi

# Check if $3 is a file
[ ! -f $1 ] && exit 3

case $3 in 
	[cC])
		msg="Counting matches in $1 of $2"
		opt="-c"
		;;
	[pP])
		msg="Print the matches of $2 in $1"
		opt="-p"
		;;
	[dD])
		msg="Printing all the lines but those matching $3 from $1"
		opt="-v"
		;;
	*)
		echo "Could not evaluate $1 $2 $3"
		;;
esac

echo $msg
grep $opt $2 $1


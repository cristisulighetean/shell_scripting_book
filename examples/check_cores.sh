#!/bin/bash

function check_cores {
    # Check if there is an argument and it is non-zero
	if [[ "$1" > 0 ]] ; then
        REQ_CORES=$1
    else
        echo "Required number of cores must be positive!"
        exit 1
    fi

	if [[ "$OSTYPE" == "linux-gnu"* ]] ; then
			# Linux
        	CPU_CORES=$(grep -c name /proc/cpuinfo)
	elif [[ "$OSTYPE" == "darwin"* ]] ; then
			# MacOS
			CPU_CORES=$(sysctl -n hw.ncpu)		
	else
			echo "Unknown system"
			exit 1
	fi

	if [[ "$CPU_CORES" < "$REQ_CORES" ]] ; then
		echo "A minimum of $REQ_CORES cores are required"
        echo "You have currently $CPU_CORES"
		exit 1
	fi
}

# Works in zsh too
printf >&2 '%s' 'Enter required number of cores for the task: '
read ans
check_cores "$ans"
exit 1
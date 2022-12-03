#!/bin/bash

STR='.log'

case "$1" in
	"") echo "1084634 | 1084565"
	;;
        "access.log")
	case "$2" in
		"")
		file $1
		while read line; do
		echo $line
		done < access.log
		;;
		"--userid") echo "hello"
        	;;
	esac
	;;
	*)
	if grep -q -v "$STR" <<< "$1"; then
  	echo "Wrong Arguments"
	fi
	;;
esac

#!/bin/bash

STR='.log'

mining_usernames(){
awk '{count[$3]++} END {for (word in count) print count[word], word}' $1
}

case "$1" in
	"") echo "1084634 | 1084565"
	;;
        access.log)
	case "$2" in
		"")
		awk '{print}' $1
		;;
		--usrid)
		case "$3" in
			"")
			mining_usernames $1
			;;
			root|admin|user1|user2|-)
			grep "$3" $1
        		;;
		esac
		;;
		-method)
		case "$3" in
			GET|POST)
			grep "$3" $1
			;;
			*)
			echo "Wrong Method Name"
		esac
		;;
		--servprot)
		case "$3" in
			"IPv4")
			grep "127.0.0.1" $1
			;;
			"IPv6")
			grep "::1" $1
			;;
			*)
			echo "Wrong Network Protocol"
			;;
		esac
		;;
		--browsers)
		count_browsers $1
		;;
		--datum)
		case "$3" in
			Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)
			grep "$3" $1
			;;
			*)
			echo "Wrong Date"
			;;
		esac
		;;
	esac
	;;
	*)
	if grep -q -v "$STR" <<< "$1"; then
  	echo "Wrong Arguments"
	fi
	;;
esac


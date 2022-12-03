#!/bin/bash

STR='.log'

mining_usernames(){
gno="$(grep -v -c 'admin\|root\|user1\|user2' $1)"
echo "$gno -"
gadmin="$(grep -c 'admin' $1)"
echo "$gadmin admin"
groot="$(grep -c 'root' $1)"
echo "$groot root"
guser1="$(grep -c 'user1' $1)"
echo "$guser1 user1"
guser2="$(grep -c 'user2' $1)"
echo "$guser2 user2"
}

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
		"--usrid")
		case "$3" in
			"")
			mining_usernames $1
			;;
			"root")
			grep "root" $1
        		;;
			"admin")
			grep "admin" $1
			;;
			"user1")
			grep "user1" $1
			;;
			"user2")
			grep "user2" $1
			;;
			"-")
			grep -v 'admin\|root\|user1\|user2' $1
			;;
		esac
		;;
		"-method")
		case "$3" in
			"GET")
			grep "GET" $1
			;;
			"POST")
			grep "POST" $1
			;;
			*)
			echo "Wrong Method Name"
		esac
		;;
		"--servprot")
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
		"--datum")
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


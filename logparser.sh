s#!/bin/bash
case "$1" in
	"") echo "1084634 | 1084565"
	;;
        "access.log") file $1
while read line; do
echo $line
done < access.log
        ;;
	*)
	if grep -q -v "$STR" <<< "$1"; then
  	echo "Wrong Arguments"
	fi
	;;
esac

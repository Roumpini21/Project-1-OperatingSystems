#Iasonas Pavlopoulos, 1084565
#Roumpini-Maria Angoura, 1084634

#!/bin/bash

STR='.log'

mining_usernames(){
awk '{count[$3]++} END {for (word in count) print count[word], word}' $1 | sort -k 2
}

# Define the count function
count_browsers() {
  mozilla=$(awk '{ if (match($6, "Mozilla")) { mozilla++ } } END { print mozilla }' $1)
  chrome=$(awk '{ if (match($6, "Chrome")) { chrome++ } } END { print chrome }' $1)
  safari=$(awk '{ if (match($6, "Safari")) { safari++ } } END { print safari }' $1)
  edge=$(awk '{ if (match($6, "Edg")) { edge++ } } END { print edge }' $1)

  echo "Mozilla: $mozilla"
  echo "Chrome: $chrome"
  echo "Safari: $safari"
  echo "Edge: $edge"
}

# Call the count function
count_browsers

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
			root)
			awk '{if ($3 == "root") {print} else {next}}' $1
        		;;
			admin)
			awk '{if ($3 == "admin") {print} else {next}}' $1
			;;
			president)
			awk '{if ($3 == "president") {print} else {next}}' $1
			;;
			user1)
			awk '{if ($3 == "user1") {print} else {next}}' $1
			;;
			user2)
			awk '{if ($3 == "user2") {print} else {next}}' $1
			;;
			user3)
			awk '{if ($3 == "user3") {print} else {next}}' $1
			;;
			-)
			awk '{if ($3 == "-") {print} else {next}}' $1
			;;
		esac
		;;
		-method)
		case "$3" in
			GET)
			awk '/GET/' $1
			;;
			POST)
			awk '/POST/' $1
			;;
			*)
			echo "Wrong Method Name"
		esac
		;;
		--servprot)
		case "$3" in
			"IPv4")
			awk '/127.0.0.1/' $1
			;;
			"IPv6")
			awk '/::1/' $1
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
	if [[ "$1" != *".log"* ]]; then echo "Invalid Arguments"
	fi
esac

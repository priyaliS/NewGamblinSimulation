#! /bin/bash/

echo "Welcome To Gambling"
#Constants
INITIAL=100
BET=1

case $(( $RANDOM%2 )) in

	0) echo "player lost the bet" ;;
	1) echo "player won the bet" ;;
esac

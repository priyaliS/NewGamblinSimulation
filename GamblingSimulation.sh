#!/bin/bash 
echo "gambling simulator"
#constants
INITIAL=100
BET=1

#variables
stake=$INITIAL
stakePercentAmount=$(( 50*$INITIAL/100 ))
maxWin=$(( $stakePercentAmount+$INITIAL ))
maxLoss=$(( $INITIAL-$stakePercentAmount ))

function calculate() 
{
        while [ $stake -lt $maxWin ] && [ $stake -gt $maxLoss ]
        do
        play=$(( RANDOM%2 ))

         if [ $play -eq 1 ]
         then
                stake=$(( stake+BET ))
         else
                stake=$(( stake-BET ))
         fi
        done
}

calculate

echo "Resign for day"

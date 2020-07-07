#!/bin/bash 
echo "gambling simulator"
#constants
INITIAL=100
BET=1
#varibles
stake=$INITIAL
stakePercentAmount=$(( 50*$INITIAL/100 ))
maxWin=$(( $stakePercentAmount+$INITIAL ))
maxLoss=$(( $INITIAL-$stakePercentAmount ))
numOfDays=20

function calculate() 
{	stake=$INITIAL
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

for (( day=0; day<$numOfDays; day++ ))
        do
        calculate
                if [ $stake -eq $maxLoss ]
                then
                loss=$(( loss - 50 ))
                else
                win=$(( win + 50 ))
                fi 
        echo "Resign for day"
        done

echo "Total amount Loss"$loss
echo "Total amount Won-" $win

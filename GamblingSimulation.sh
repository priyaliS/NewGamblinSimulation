#!/bin/bash
echo "gambling simulator"

#constants
INITIAL=100
BET=1

#variables
stakePercentAmount=$(( 50*$INITIAL/100 ))
maxWin=$(( $stakePercentAmount+$INITIAL ))
maxLoss=$(( $INITIAL-$stakePercentAmount ))
numOfDays=30
loss=0
win=0
daysWin=0
daysLoss=0

declare -A fullDay

function betPlayed()
{       dayStake=$INITIAL
        while [ $dayStake -lt $maxWin ] && [ $dayStake -gt $maxLoss ]
        do
         play=$(( RANDOM % 2 ))
                if [ $play -eq 1 ]
                then
                        dayStake=$(( $dayStake+$BET ))
                else
                        dayStake=$(( $dayStake-$BET ))
                fi
        done
}
        for (( day=1; day<=$numOfDays; day++ ))
        do
        betPlayed
	fullDay["Day $day"]=$stakePercentAmount

                if [ $dayStake -eq $maxLoss ]
                then
                        loss=$(( $loss-$stakePercentAmount ))
			(( daysLoss++ ))
                else
                        win=$(( $win+$stakePercentAmount ))
			(( daysWin++ ))
                fi
        done

echo "Winned days $daysWin by $(($daysWin*$stakePercentAmount))" 
echo "Lossed days $daysLoss by  $(($daysLoss*$stakePercentAmount))"

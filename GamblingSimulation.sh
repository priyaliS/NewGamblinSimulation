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
win=0
loss=0
daysWin=0
daysLoss=0

declare -A fullDay
declare -A maxMinDay

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
	fullDay["Day $day"]=$stakePercentAmount
        betPlayed
                if [ $dayStake -eq $maxLoss ]
                then
                        loss=$(($loss - $stakePercentAmount ))
                        maxMinDay["Day $day"]=$loss
 			(( daysLoss++ ))
                else
                        win=$(( $win + $stakePercentAmount ))
                        maxMinDay["Day $day"]=$win
			(( daysWin++ ))
                fi
        done

echo "Total loss $loss"
echo "Total win- $win"

echo "Winned days $daysWin by $(($daysWin*$stakePercentAmount))" 
echo "Lossed days $daysLoss by  $(($daysLoss*$stakePercentAmount))"

luckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | head -1 )
unluckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | tail -1 )

        for data in "${!maxMinDay[@]}"
        do
                if [[ ${maxMinDay[$data]} -eq $luckyDay ]]
                then
                echo "Lucky Day-" $data
                elif [[ ${maxMinDay[$data]} -eq $unluckyDay ]]
                then
                echo "Unlucky Day-" $data
                fi
        done

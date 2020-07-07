
#!/bin/bash
echo "gambling simulator"

#constant
INITIAL=100
BET=1
VALID=true
LAST_LOSSAMOUNT=0
NUM_OF_DAYS=30

#variable
stakePercentAmount=$(( 50*$INITIAL/100 ))
maxWin=$(( $stakePercentAmount+$INITIAL ))
maxLoss=$(( $INITIAL-$stakePercentAmount ))
loss=0
win=0
daysWin=0
daysLoss=0

declare -A dayChart
declare -A monthChart

function dailyBetting()
{
   dayStake=$INITIAL
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

function monthBetting()
{
   for (( day=1; day<=$NUM_OF_DAYS; day++ ))
   do
   dailyBetting
      if [ $dayStake -eq $maxLoss ]
      then
         totalWinOrLoss=$(( $totalWinOrLoss - $stakePercentAmount ))
         dayChart["Day $day"]=-$stakePercentAmount
         monthChart["Day $day"]=$totalWinOrLoss
         ((daysLoss++))
      else
         totalWinOrLoss=$(( $totalWinOrLoss + $stakePercentAmount ))
         dayChart["Day $day"]=$stakePercentAmount
         monthChart["Day $day"]=$totalWinOrLoss
         ((daysWin++))
      fi
   done
   echo "Total Won/loss  $totalWinOrLoss"
   echo "Winned days $daysWin by $(($daysWin*$stakePercentAmount))"   
   echo "Lossed days $daysLoss by  $(($daysLoss*$stakePercentAmount))"

luckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | head -1 )
unluckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | tail -1 )

        for days in "${!maxMinDay[@]}"
        do
                if [[ ${maxMinDay[$days]} -eq $luckyDay ]]
                then
                echo "Lucky Day-" $days
                elif [[ ${maxMinDay[$days]} -eq $unluckyDay ]]
                then
                echo "Unlucky Day-" $days
                fi
        done

}

while [ $VALID ]
do
   monthBetting
   if [ $totalWinOrLoss -lt $LAST_LOSSAMOUNT ] 
   then
      echo "you lost the game"
      break
   else
      echo "you won the game $totalWinOrLoss, play....."
   fi
done

#!/bin/bash
#--------------------------------
FILE=$1;     #Variable to hold the input file name.
count=0;     #Varibale to hold the number of packets between a second.
timeVar='0'; #Support Varibale to determine when a second passed.

while read line;
do
    count=$((count+1)); #Count the packet
    newtimeVar=`echo $line | awk -F ' ' '{print $2}' | awk -F '.' '{print $1}'`
    
    diff=$((newtimeVar-timeVar));

    if [ $timeVar != $newtimeVar ]; then
        if [ $diff -gt 1 ]; then
            while [ $diff != 1  ];
            do
                timeVar=$((timeVar+1));

                echo $timeVar 0;
                diff=$((diff-1));
            done
        fi
        echo $newtimeVar $count;
        count=0;
        timeVar=$newtimeVar;
    fi

done < $FILE

echo $((newtimeVar+1)) $count;

#!/bin/bash
#--------------------------------
FILE=$1;
END=$2;
count=0;
timeCount=1;
timeVar='0';
byteVar='0';

while read line;
do
    count=$((count+1));
    newtimeVar=`echo $line | awk -F ' ' '{print $2}' | awk -F '.' '{print $1}'`;
    newByteVar=`echo $line | awk -F ' ' '{print $7}'`;
    byteVar=$((byteVar+newByteVar));
    
    #echo ByteVar = $byteVar
    diff=$((newtimeVar-timeVar));

    if [ $timeVar != $newtimeVar ]; then
	#echo DIFF = $diff
        if [ $diff -gt 1 ]; then
            while [ $diff != 1  ];
            do
                timeVar=$((timeVar+1));

                echo $timeVar 0;
                diff=$((diff-1));
            done
        fi
	echo $newtimeVar $byteVar;
 	count=0;
	timeVar=$newtimeVar; 
        #timeCount=$((timeCount+1));
        byteVar='0';
    fi

done < $FILE

diff=$((END-timeVar));

        if [ $diff -gt 1 ]; then
            while [ $diff != 1  ];
            do
                timeVar=$((timeVar+1));

                echo $timeVar 0;
                diff=$((diff-1));
            done
        fi

echo $((timeVar+1)) $byteVar;

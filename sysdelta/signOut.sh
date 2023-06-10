#!/bin/bash

if date -d $1 &>/dev/null 
then
    if id -nG "$USER" | grep -qw "Student" #student makes leave request
    then
        hostel=$(awk '{print $3}' ~/userDetails.txt)
        echo "$USER $hostel $1 -" >> /home/HAD/leave.txt #name hostel dateofleave status(late/ontime/y/n)
    else
        echo dummy 1>/dev/null
    fi
elif [ -z $1 ]
then
    if id -nG "$USER" | grep -qw "Student" #convert the y to late or ontime
    then
        lineno=$(grep -n -e "^$USER.*y$" /home/HAD/leave.txt | cut -f1 -d:)
        line=($(grep -n -e "^$USER.*y$" /home/HAD/leave.txt))
        currentdate=$(date -d $(date +"%Y-%m-%d") +%s)
        linedate=$(date -d ${line[2]} +%s)

        if [ $currentdate -gt $linedate ]
        then
            echo "$(awk -v lineno=$lineno '{if (NR==lineno){print $1, $2, $3, "LATE" } else {print $0}}' /home/HAD/leave.txt)" > /home/HAD/leave.txt 
        else
            echo "$(awk -v lineno=$lineno '{if (NR==lineno){print $1, $2, $3, "ONTIME" } else {print $0}}' /home/HAD/leave.txt)" > /home/HAD/leave.txt 
        fi
    elif id -nG "$USER" | grep -qw "Warden" #auto ask the warden for permission (y or n)
    then
        while read i <&3
        do
            line=($i)
            lineno=$(echo ${line[@]} | cut -f1 -d:)

            echo "Allow the person with the following details [${line[@]}] to go on leave? Enter y or n:"
            read confirm
            echo "$(awk -v lineno=$lineno -v confirm=$confirm '{if (NR==lineno){print $1, $2, $3, confirm } else {print $0}}' /home/HAD/leave.txt)" > /home/HAD/leave.txt
        done 3< <(grep -n -e "^.*$USER.*-$" /home/HAD/leave.txt) 
    else
        echo dummy 1>/dev/null
    fi
else
    echo "Enter a valid leave date(YYYY-MM-DD) as a parameter"
fi

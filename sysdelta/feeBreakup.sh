#!/bin/bash

#the structure of the fees.txt is that the firstcolumn is the catagory , second is the cumalative fees and below it, transactions are stored line by line
if id -nG "$USER" | grep -qw "Student"
then
    if [ ! -s ~/"fees.txt" ]
    then
        echo "TuitionFee 0
HostelRent 0
ServiceCharge 0
MessFee 0" > ~/"fees.txt"
    fi

    TuitionFee=$(( $1 + $(cat ~/fees.txt | awk 'NR==1{print $2}') )) #takes the  user input and adds it to already paid fees
    HostelRent=$(( $2 + $(cat ~/fees.txt | awk 'NR==2{print $2}') ))
    ServiceCharge=$(( $3 + $(cat ~/fees.txt | awk 'NR==3{print $2}') ))
    MessFee=$(( $4 + $(cat ~/fees.txt | awk 'NR==4{print $2}') ))

    transactions=$(tail -n +5 ~/fees.txt) #takes the previous tranactions

    if [ $TuitionFee -le 25000 -a $HostelRent -le 10000 -a $ServiceCharge -le 5000 -a $MessFee -le 10000 ]
    then
        echo "TuitionFee $TuitionFee
HostelRent $HostelRent
ServiceCharge $ServiceCharge
MessFee $MessFee" > ~/"fees.txt" #updates the paid fees
        
        
        echo "$transactions" >> ~/fees.txt #appends the old + the new transaction
        echo TuitionFee:+$1::HostelRent:+$2::ServiceCharge:+$3::MessFee:+$4 >> ~/fees.txt

        echo Fees to be payed are TuitionFee:$(( 25000 - $TuitionFee )) HostelRent:$(( 10000 - $HostelRent )) ServiceCharge:$(( 5000 - $ServiceCharge )) MessFee:$(( 10000 - $MessFee ))
    else
        echo Fees payed is greater than required in at least one of the fields
        echo Current fees payed already is TuitionFee:$(( $TuitionFee - $1 )) HostelRent:$(( $HostelRent - $2 )) ServiceCharge:$(( $ServiceCharge - $3 )) MessFee:$(( $MessFee - $4 ))
        echo Required Fees are TuitionFee:25000 HostelRent:10000 ServiceCharge:5000 MessFee:10000
    fi
else
    echo $USER does not belong to Student
fi
#!/bin/bash

for hostel in GarnetA GarnetB Agate Opal
do
    chown -R :$hostel /home/$hostel/*  
    chown $hostel: /home/$hostel/*     
    chmod 771 /home/$hostel/           
    chmod 770 /home/$hostel/*/*/       
    usermod -a -G $hostel HAD #add sudo if required

    for path in $(find /home/$hostel/*/* -maxdepth 0 -regextype sed -regex ".*/[A-Z][a-z]*")
    do 
        ln -s /home/$hostel/announcements.txt $path/announcments #creates the appropriate links to files to be acessed by the students
        ln -s /home/$hostel/feeDefaulters.txt $path/feeDefaulters
        ln -s /home/HAD/mess.txt $path/mess 
    done

done

chmod +x /home/HAD/
chmod 666 /home/*/*/*/userDetails.txt
find /home/*/*  -regextype sed -regex ".*/[0-9][0-9]*" -exec chmod 771 {} + 
chmod o+w /home/HAD/mess.txt
chmod 666 /home/*/*/*/fees.txt
chmod 751 /home
chown :HAD /home 

chmod 666 /home/HAD/leave.txt #for superusermode

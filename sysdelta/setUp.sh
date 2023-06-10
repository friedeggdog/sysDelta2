##INSTRUCTIONS
#RUN genStudent first then run setUp.sh then permit
#Make sure the paths are set properly the default is under the /opt/ directory but it can be changed
#genStudent takes in both arguments and runtime input
#permit takes nothing
#feeBreakup takes 4 arguments for Tutionfee Hostelrent Servicecharge and Messfee
#updateDefaulter takes nothing
#messAllocation takes via runtime input
#signOut takes in the date of leaving by argument


bash -c "echo 'alias genStudent=\"/opt/genStudent.sh\"' >> /etc/bash.bashrc" #add sudo where there is a bash if required

bash -c "echo 'alias permit=\"/opt/permit.sh\"' >> /etc/bash.bashrc"

bash -c "echo 'alias updateDefaulter=\"/opt/updateDefaulter.sh\"' | tee -a /home/{Opal,GarnetA,GarnetB,Agate}/.bashrc"

bash -c "echo 'alias messAllocation=\"/opt/messAllocation.sh\"' >> /home/HAD/.bashrc"
bash -c "echo 'alias messAllocation=\"/opt/messAllocation.sh\"' | tee -a /home/*/*/*/.bashrc"

bash -c "echo 'alias feeBreakup=\"/opt/feeBreakup.sh\"' | tee -a /home/*/*/*/.bashrc"

bash -c "echo 'alias signOut=\"/opt/signOut.sh\"' | tee -a /home/*/*/*/.bashrc"

chmod 744 /opt/genStudent.sh
chmod 744 /opt/permit.sh
chmod 654 /opt/updateDefaulter.sh
chmod 755 /opt/messAllocation.sh
chmod 755 /opt/feeBreakup.sh
chmod 755 /opt/signOut.sh
chmod 755 /opt/insert.py

chown :Warden /opt/updateDefaulter.sh

if grep -qw "/opt/signOut.sh 2>/dev/null" /etc/bash.bashrc
then 
    echo dummy 1>/dev/null
else 
    bash -c "echo '/opt/signOut.sh 2>/dev/null' | tee -a /etc/bash.bashrc"
fi

#!/bin/bash

#This is a script to reset password for a user

echo "This is the compulsory password reset schedule"
echo 'Type [1] if you want to set the password yourself, or type [2] for the system generated password'

while (true)
do

#take users choice
read choice




#Using the choice to determine what process to carry out.  

        if [[ $choice == '1' ]]
        then

                #Initializing a variable to serve as a condition for while loop
                t=0;
                 echo 'Please enter the new password; critieria to follow: '
                 echo  'Min: 8 characters; 1 upper case; 1 lower case; 1 special character; 1 number'

                #while loop to cause user to keep inputting password till right one acquired
                while [ $t = 0 ]
                do
                        read  newpass
                         len=${#newpass}
                         if [[ $len -ge 8 && $newpass =~ [0-9] && $newpass =~ [a-z] && $newpass =~ [A-Z] && ! $newpass =~ ^[[:alnum:]]+$ ]]  
                         then
                                t=1;
      echo 'Strong password, you may proceed'
                                 echo  $newpass ": is your new Password" >  passmail.log


                                #taking old password to change password in the system
                                 echo "enter your old password"
                                 read oldie
                                 echo  -e  $oldie$'\n'$newpass$'\n'$newpass  | passwd 

                        else
                                 echo 'Your password is missing one of the criteria, please set it again'

                        fi
                done
                break


        elif [[ $choice == '2' ]]
        then 
                echo 'Computer Generated Password below '

                #Simple Password Generator
                export passy=$(openssl rand -base64 14)
                echo " Your new password: " $passy '$'\n''

  echo $passy ': is your new password' > passmail.log

                echo "enter your old password for confirmation"
                read oldie
                echo  -e  $oldie$'\n'$passy$'\n'$passy  | passwd 

                break

        else    
                 echo 'Your response is not valid; enter [1] or [2]'
                        continue
fi
done


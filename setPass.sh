#!/bin/bash
source /var/firebird/etc/SYSDBA.password
/usr/local/firebird/bin/gsec -user SYSDBA -password "${ISC_PASSWD}" -modify SYSDBA -pw masterkey

cat > /var/firebird/etc/SYSDBA.password <<EOL
# Firebird generated password for user SYSDBA is:
ISC_USER=SYSDBA
ISC_PASSWD=masterkey
# Your password can be changed to a more suitable one using the
# /usr/local/firebird/bin/gsec utility.
EOL


#echo "Setting SYSDBA's password..."
#cd /usr/local/firebird/
#IBASE_PASSWORD=`grep -Po '(?<=ISC_PASSWD=)[^\s]*' ./SYSDBA.password`
#echo "Previous password was ${IBASE_PASSWORD}"
#./bin/fbguard -onetime -daemon
#sleep 10
#./bin/gsec -user sysdba -pass $IBASE_PASSWORD -mo sysdba -pw masterkey

#CURRENT_SYSDBA_PASSWORD=`grep -oP 'ISC_PASSWD=\K.*' /usr/local/firebird/SYSDBA.password`
#/usr/local/firebird/bin/gsec -user SYSDBA -password `echo $CURRENT_SYSDBA_PASSWORD` -modify SYSDBA -pw `echo $SYSDBA_PASSWORD`
#/usr/local/firebird/bin/fbguard

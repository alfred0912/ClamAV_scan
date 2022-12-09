#!/usr/bin/env bash
#參考來源：https://ixnfo.com/en/clamav-script-for-automatic-scanning-and-email-notifications.html

sudo rm logfile/clamav-*
LOGFILE="/home/$USER/clamscan/logfile/clamav-$(date +'%Y-%m-%d').log";
EMAIL_MSG="Please check the scan log below";
EMAIL_FROM="ClamavScanReport@ailabs.com";
EMAIL_TO="YOUR EMAIL";
HOSTNAME="uname -a|cut -d " " -f2"
DIRTOSCAN="/home";

for S in ${DIRTOSCAN}; do
 DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);
 
 echo "Starting scan of "$S" directory.
 Directory size: "$DIRSIZE".";
 
 clamscan --infected -r --max-dir-recursion=6 --max-scantime=0 "$DIRTOSCAN" >> "$LOGFILE";
 #clamscan -ri --remove "$S" >> "$LOGFILE";
 
 #find /var/log/clamav/ -type f -mtime +30 -exec rm {} \;
 MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);
 
 if [ "$MALWARE" -ne "0" ];then
 echo "$EMAIL_MSG"|mail -s "$HOSTNAME Malware Found" -r "$EMAIL_FROM"  "$EMAIL_TO"  "$EMAIL_CC"  < $LOGFILE;
 fi
done
 
exit 0

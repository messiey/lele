#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
REPO="https://raw.githubusercontent.com/messiey/lele/master/"
###########- COLOR CODE -##############
echo -e " [INFO] Downloading File"
sleep 2
wget -q -O /usr/bin/add-ip "${REPO}add-ip.sh" && chmod +x /usr/bin/add-ip
wget -q -O /usr/bin/m-bot "${REPO}jembot.sh" && chmod +x /usr/bin/m-bot
echo -e " [INFO] Download File Successfully"
sleep 2
exit

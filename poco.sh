#!/bin/bash

#install
apt update && apt upgrade
apt install python3 python3-pip git
wget https://raw.githubusercontent.com/messiey/lele/master/pocoo.zip
unzip pocoo.zip
rm -rf pocoo.zip
cd regis
rm var.txt
pip3 install -r regis/requirements.txt
pip3 install pillow

#isi data
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/regis/var.txt
echo -e ADMIN='"'$admin'"' >> /root/regis/var.txt
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "DOMAIN         : $bottoken"
echo "Email          : $admin"
echo -e "==============================="
echo "Setting done"

cat > /etc/systemd/system/wongedan.service << END
[Unit]
Description=Simple register - @wongedan_kuwibebas
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m wongedan
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start wongedan 
systemctl enable wongedan

clear

echo " Installations complete, type /menu on your bot"
rm -rf gendenx.sh

#!/bin/bash
apt update && apt upgrade
apt install python3 python3-pip git
wget -q https://raw.githubusercontent.com/messiey/lele/master/kontol.zip
unzip kontol.zip
rm -rf kontol.zip
pip3 install -r error404project/requirements.txt
pip3 install pillow

clear
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/error404project/var.txt
echo -e ADMIN='"'$admin'"' >> /root/error404project/var.txt

cat > /etc/systemd/system/error404project.service << END
[Unit]
Description=Simple Error404Project - @Error404Project
After=network.target

[Service]
WorkingDirectory=/root/
ExecStart=/usr/bin/python3 -m error404project
Restart=always

[Install]
WantedBy=multi-user.target
END
cd

systemctl start error404project 
systemctl enable error404project

clear
echo " Installations complete, type /menu on your bot"
rm -rf kontol.sh

#!/bin/bash

#install

apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
git clone https://github.com/messiey/lele.git
unzip lele/error.zip
pip3 install -r error/requirements.txt
pip3 install python-telegram-bot==13.7
pip3 install pillow

clear

#isi data
echo ""
read -e -p "[*] Masukan Bot Token Anda Tuan : " bottoken
read -e -p "[*] Masukan Id Telegram Anda Tuan :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/error404project/var.txt
echo -e ADMIN='"'$admin'"' >> /root/error404project/var.txt
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Bot Telegram        : $bottoken"
echo "Id Telegram        : $admin"
echo -e "==============================="
echo "Setting done"

cat > /etc/systemd/system/error404project.service << END
[Unit]
Description=Simple Error404Project - @Error404Project
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m error404project
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start error404project 
systemctl enable error404project
systemctl restart error404project

sleep 3

clear

echo " Installations complete, ketik /start untuk memulai bot"

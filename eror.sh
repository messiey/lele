#!/bin/bash

#install

apt update && apt upgrade
apt install python3 python3-pip git
wget https://raw.githubusercontent.com/messiey/lele/master/eror.zip
cd /root/
unzip eror.zip
pip3 install -r error/requirements.txt
pip3 install python-telegram-bot==13.7
pip3 install pillow

clear

cat > /etc/systemd/system/error404project.service << END
[Unit]
Description=Simple Error404Project - @Error404Project
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m error404project
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start error404project 
systemctl enable error404project

sleep 3

clear

echo " Installations complete, ketik /start untuk memulai bot"
rm -f eror.sh

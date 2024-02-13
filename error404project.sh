#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install python3 python3-pip -y
pip3 install python-telegram-bot==13.7
apt install python3 python3-pip git
git clone https://github.com/messiey/lele.git
unzip lele/ngarep.zip
pip3 install -r error404project/requirements.txt
clear

cat > /etc/systemd/system/error404project.service << END

[Unit]
Description=Error404Project Script
After=syslog.target network-online.target

[Service]
WorkingDirectory=/root/error404project
ExecStart=/usr/bin/python3 error404project.py
Restart=always

[Install]
WantedBy=multi-user.target
END

echo " Installations complete, type /start on your bot"

systemctl daemon-reload
systemctl start error404project
systemctl enable error404project

sleep 3
clear

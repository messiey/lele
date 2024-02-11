#!/bin/bash
apt update && apt upgrade
apt install python3 python3-pip git
cd /etc/bot
wget -q https://raw.githubusercontent.com/messiey/lele/master/kontol.zip
unzip kontol.zip
rm -rf kontol.zip
pip3 install -r regis/requirements.txt
pip3 install pillow

clear
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/regis/var.txt
echo -e ADMIN='"'$admin'"' >> /root/regis/var.txt

cat > /etc/systemd/system/regis.service << END
[Unit]
Description=Simple register - @error404project
After=network.target

[Service]
WorkingDirectory=/etc/bot
ExecStart=python3 -m regis
Restart=always

[Install]
WantedBy=multi-user.target
END
cd

systemctl start regis 
systemctl enable regis

clear
echo " Installations complete, type /menu on your bot"
rm -rf kontol.sh

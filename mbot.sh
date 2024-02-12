#!/bin/bash

apt update -y && apt upgrade -y
apt install python3 python3-pip git speedtest-cli -y
sudo apt-get install -y p7zip-full
cd /usr/bin
clear
wget https://raw.githubusercontent.com/messiey/lele/master/sore.zip
unzip sore.zip
pip3 install -r error404project/requirements.txt
clear
cd /usr/bin/error404project
chmod +x *
mv -f * /usr/bin
rm -rf /usr/bin/error404project
rm -rf /usr/bin/*.zip
cd
rm -rf /etc/tele

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                ${WH}• BOT PANEL •                  ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
rm -rf /usr/bin/error404project.session
rm -rf /usr/bin/error404project/var.txt
rm -rf /usr/bin/error404project/database.db
echo -e ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin

cat >/usr/bin/error404project/var.txt <<EOF
BOT_TOKEN="$bottoken"
ADMIN="$admin"
DOMAIN="$domain"
EOF

echo 'TEXT=$'"(cat /etc/notiftele)"'' > /etc/tele
echo "TIMES=10" >> /etc/tele
echo 'KEY=$'"(cat /etc/per/token)"'' >> /etc/tele

echo "$bottoken" > /etc/per/token
echo "$admin" > /etc/per/id
echo "$bottoken" > /usr/bin/token
echo "$admin" > /usr/bin/idchat
echo "$bottoken" > /etc/perlogin/token
echo "$admin" > /etc/perlogin/id
clear

cat > /etc/systemd/system/error404project.service << END
[Unit]
Description=Simple error404project - @error404project
After=syslog.target network-online.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m error404project
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload &> /dev/null
systemctl enable error404project &> /dev/null
systemctl start error404project &> /dev/null
systemctl restart error404project &> /dev/null

echo "Done"
echo " Installations complete, type /menu on your bot"
clear

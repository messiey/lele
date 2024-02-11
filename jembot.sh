##!/bin/bash
#NS=$( cat /etc/xray/dns )
#PUB=$( cat /etc/slowdns/server.pub )
#domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#install
apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
#wget https://raw.githubusercontent.com/messiey/lele/master/error404project.zip
#unzip bot.zip
#mv bot/* /usr/bin
#chmod +x /usr/bin/*
#rm -rf bot.zip
clear
wget https://raw.githubusercontent.com/messiey/lele/master/error404project.zip
unzip error404project.zip
pip3 install -r error404project/requirements.txt
pip install pillow

#isi data
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/error404project/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/error404project/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/error404project/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/error404project/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/error404project/var.txt
clear

cat > /etc/systemd/system/error404project.service << END
[Unit]
Description=Simple bot - @error404project
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m error404project
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start error404project 
systemctl enable error404project
systemctl restart error404project
cd /root
rm -rf ngontol.sh
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot         : $bottoken"
echo "Admin          : $admin"
echo "Domain        : $domain"
echo "Pub            : $PUB"
echo "Host           : $NS"
echo -e "==============================="
echo "Setting done"
clear

echo " Installations complete, type /menu on your bot"

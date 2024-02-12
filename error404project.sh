#!/bin/bash

#install
rm -rf error404project.sh
apt update && apt upgrade
apt install python3 python3-pip git
git clone https://github.com/messiey/lele.git
unzip lele/sore.zip
pip3 install -r error404project/requirements.txt
pip3 install pillow

#isi data
grenbo="\e[92;1m"
NC='\033[0m'
clear
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m          ADD TO BOT TELE                  $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
read -e -p "[*] Input your Bot Token    :  " bottoken
read -e -p "[*] Input Your Id Telegram  :  " admin
read -e -p "[*] Input Your Subdomain    :  " domain
read -e -p "[*] Input Your NSdomain     :  " sldomain
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e ""
echo -e ""
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/error404project/var.txt
echo -e ADMIN='"'$admin'"' >> /root/error404project/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/error404project/var.txt
echo -e SLDOMAIN='"'$sldomain'"' >> /root/error404project/var.txt
clear
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m          DATA YOUR BOT                  $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mTOKEN BOT   : $bottoken ${NC}"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mID TELE     : $admin ${NC}"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mDOMAIN      : $domainl ${NC}"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mNSDomain    : $sldomain ${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo "Setting done Please wait 10s"
sleep 10

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

systemctl start error404project 
systemctl enable error404project

clear
grenbo="\e[92;1m"
NC='\033[0m'
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m          INSTALLATION COMPLETED              $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
sleep 2
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m          DATA YOUR BOT                  $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mTOKEN BOT  : $bottoken ${NC}"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mID TELE    : $admin ${NC}"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mDOMAIN     : $domainl ${NC}"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mNSDomain   : $sldomain ${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mType, /menu On Your Bot Tele${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e ""
read -n 1 -s -r -p "Press any key to Reboot"
rm -rf error404project.sh
clear
reboot

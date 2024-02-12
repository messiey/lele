#!/bin/bash


rm -rf error404project.sh
apt update && apt upgrade
apt install python3 python3-pip git
git clone https://github.com/messiey/lele.git
unzip lele/error404project.zip
pip3 install -r error404project/requirements.txt
pip3 install pillow

#isi data
echo ""
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m        Masukkan Data Anda               
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
read -e -p "[*] Input your Bot Token    :  " bottoken
read -e -p "[*] Input Your Id Telegram  :  " admin
read -e -p "[*] Input Your Subdomain    :  " domain
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/error404project/var.txt
echo -e ADMIN='"'$admin'"' >> /root/error404project/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/error404project/var.txt
clear
echo "Done"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│$NC\033[42m          Detail Akun Anda                
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mTOKEN BOT  : $bottoken ${NC}"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mID TELE    : $admin ${NC}"
echo -e "\033[1;93m│ ${grenbo}[NOTE]${NC} \033[0;36mDOMAIN     : $domainl ${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo "Setting done"

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

sleep 3

clear

echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;93m│  ${grenbo}[NOTE]${NC} \033[0;36mKetik, /menu Untuk Memulai Layanan${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"

clear

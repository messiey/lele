#!/bin/bash
ipsaya=$(curl -sS ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/messiey/lele/master/ip"
checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Your Admin ${NC}"
        echo -e "     \033[0;36mTelegram${NC}: https://t.me/error404project"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        exit
    fi
}
checking_sc

domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
WH='\033[1;37m'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│      PROCESS INSTALLED BOT TELEGRAM      │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"

function install-bot() {
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mSedang Menginstal Bot Telegram \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mSedang Menginstal Bot Telegram \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}  
res1() {
    apt update -y && apt upgrade -y
    apt install python3 python3-pip git speedtest-cli -y
    pip install requests subprocess
    sudo apt-get install -y p7zip-full
    cd /usr/bin
    #clear
    #wget https://autoscript.gretongers-stores.my.id/bot.zip
    #unzip bot.zip
    #mv bot/* /usr/bin
    #chmod +x /usr/bin/*
    #rm -rf bot.zip
    clear
    wget https://raw.githubusercontent.com/messiey/lele/master/error404project.zip
    unzip error404project.zip
    pip3 install -r error404project/requirements.txt
    clear
    cd /usr/bin/error404project
    chmod +x *
    mv -f * /usr/bin
    rm -rf /usr/bin/error404project
    rm -rf /usr/bin/*.zip
    cd
    #rm -rf /etc/tele
}
echo -e ""
echo -e "  \033[1;91m Tunggu Sebentar Tuan...\033[1;37m"
fun_bar 'res1'

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

echo "SHELL=/bin/sh" >/etc/cron.d/cekbot
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >>/etc/cron.d/cekbot
echo "*/1 * * * * root /usr/bin/cekbot" >>/etc/cron.d/cekbot

cat > /usr/bin/cekbot << END
nginx=$( systemctl status error404project | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    echo -ne
else
    systemctl restart error404project
    systemctl start error404project
fi

error404project=$( systemctl status error404project | grep "TERM" | wc -l )
if [[ $error404project == "0" ]]; then
echo -ne
else
    systemctl restart error404project
    systemctl start error404project
fi
END

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
#read -n 1 -s -r -p "Press any key to back on menu"


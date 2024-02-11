#!/bin/bash
colornow=$(cat /etc/paramd/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/paramd/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/paramd/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/messiey/lele/master/ip"
checking_sc() {
useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
#systemctl stop nginx
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •                 ${NC}$COLOR1│ $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"| lolcat
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"| lolcat
echo -e "$COLOR1│            ${RED}PERMISSION DENIED !${NC}                  $COLOR1│"| lolcat
echo -e "$COLOR1│   ${yl}Your VPS${NC} $ipsaya \033[0;36mHas been Banned${NC}      $COLOR1│"| lolcat
echo -e "$COLOR1│     ${yl}Buy access permissions for scripts${NC}          $COLOR1│"| lolcat
echo -e "$COLOR1│             \033[0;32mContact Your Admin ${NC}                 $COLOR1│"| lolcat
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"| lolcat
exit
fi
}
#checking_sc
rm -rf /root/messiey >/dev/null
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/D2We21dQ)
author=$(cat /etc/profil)
userscript=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $1}')
emailscript=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $2}')
tokenscript=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $3}')
userkey=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $1}')
emailkey=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $2}')
tokenkey=$(curl -sS https://pastebin.com/raw/vmC8y2qu | awk '{print $3}')
function tambahip2(){
author=$(cat /etc/profil)
superadmin=VIP
if [ "$superadmin" = "VIP" ]; then
tambahip
else
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}${COLBG1}          ${WH}• PREMIUM SUPER ADMIN •                ${NC}$COLOR1│ $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO] Kamu Bukan Super Admin                 $COLOR1│"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• $author •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
fi
}
function gantiip2(){
author=$(cat /etc/profil)
superadmin=VIP
if [ "$superadmin" = "VIP" ]; then
mkdir /root/messiey
cd /root/messiey/ &> /dev/null
wget https://raw.githubusercontent.com/messiey/lele/master/ip &> /dev/null
data=( `cat /root/messiey/ip | grep '###' | cut -d ' ' -f 4 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
nama=$(grep -w "$user" "ip" | cut -d ' ' -f 2 | sort | uniq)
exp=$(grep -w "$user" "ip" | cut -d ' ' -f 3 | sort | uniq)
admin=$(grep -w "$user" "ip" | cut -d ' ' -f 5 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/### $nama $exp $user $admin/d" ip &> /dev/null
fi
done
rm -rf .git
git init &> /dev/null
git add ip
git commit -m remove &> /dev/null
git branch -M master &> /dev/null
git remote add origin https://github.com/messiey/lele.git &> /dev/null
git push -f https://${tokenscript}@github.com/messiey/lele.git &> /dev/null
else
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}${COLBG1}          ${WH}• PREMIUM SUPER ADMIN •                ${NC}$COLOR1│ $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO] Kamu Bukan Super Admin                 $COLOR1│"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• $author •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
fi
}
function add_ip(){
clear
nama2=error404project
author=$(cat /etc/profil)
TIMES="10"
CHATID="-1002097828989"
KEY="6825475633:AAGOhP4Kn8hXphLSjcNA5P6lpbYuc6BwLcA"
URL="https://api.telegram.org/bot$KEY/sendMessage"
superadmin=VIP
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH}• REGISTER IPVPS •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
cd
rm -rf /root/messiey >/dev/null
until [[ $daftar =~ ^[0-9.]+$ ]]; do
read -p "   MASUKKAN IPNYA: " daftar
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  [INFO] Checking the IPVPS!"
sleep 1
REQIP=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | awk '{print $4}' | grep $daftar)
if [[ $daftar = $REQIP ]]; then
echo -e "$COLOR1 ${NC}  [INFO] VPS IP Already Registered!!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• $author •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
cd
rm -rf /root/messiey >/dev/null
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
else
echo -e "$COLOR1 ${NC}  [INFO] OK! IP VPS is not Registered!"
echo -e "$COLOR1 ${NC}  [INFO] Lets Register it!"
sleep 3
clear
fi
done
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH}• REGISTER IPVPS •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
until [[ $client =~ ^[a-zA-Z0-9_]+$ ]]; do
read -p "   User Name  : " client
done
if [ -z $client ]; then
cd
echo -e "$COLOR1 ${NC}  [INFO] Please Input client"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• $author •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
fi
clear
if [ "$superadmin" = "VIP" ]; then
until [[ $hari =~ ^[0-9]+$ ]]; do
read -p " Expired (days): " hari
done
else
until [[ $hari =~ ^[0-3]+$ ]]; do
read -p " Expired (days) Max 30 Day: " hari
done
if [ -z $hari ]; then
echo -e "$COLOR1 ${NC}   [INFO] Please Input exp date"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• $author •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
fi
fi
if [ "$superadmin" = "VIP" ]; then
x="ok"
satu="ON"
dua="OFF"
while true $x != "ok"
do
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  ${COLOR1}[01]${NC} • ADMIN   ${COLOR1}[02]${NC} • NORMAL"
echo -e "$COLOR1 ${NC}"
echo -ne "   Input your choice : "; read list
echo ""
case "$list" in
1) isadmin="$satu";
read -p "Limit User (IP): " wip;
break;;
2) isadmin="$dua";break;;
esac
done
fi
MYIP=$(curl -sS ipv4.icanhazip.com)
U2=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $2}')
U3=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $3}')
U4=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $4}')
U5=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $5}')
U6=$(curl -sS https://raw.githubusercontent.com/messiey/lele/master/ip | grep $MYIP | awk '{print $6}')
exp=$(date -d "$hari days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")
git config --global user.email "${emailscript}" &> /dev/null
git config --global user.name "messiey" &> /dev/null
mkdir /root/messiey
cd /root/messiey
wget https://raw.githubusercontent.com/messiey/lele/master/ip &> /dev/null
ws=1
keyip=$(expr "$U6" - "$ws")
sed -i "s/### $U2 $U3 $U4 $U5 $U6/### $U2 $U3 $U4 $U5 ${keyip}/g" ip
if [ "$superadmin" = "VIP" ]; then
echo "### $client $exp $daftar $isadmin $wip @$nama2" >>ip
else
echo "### $client $exp $daftar @$nama2" >>ip
fi
rm -rf .git
git init &> /dev/null
git add ip
git commit -m register &> /dev/null
git branch -M master &> /dev/null
git remote add origin https://github.com/messiey/lele &> /dev/null
git push -f https://${tokenscript}@github.com/messiey/lele &> /dev/null
sleep 1
d1=$(date -d "$exp" +%s)
d2=$(date -d "$hariini" +%s)
certificate=$(( (d1 - d2) / 86400 ))
clear
echo -e "$COLOR1┌────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}      ${WH}• REGISTER IPVPS •      ${NC} $COLOR1 $NC"
echo -e "$COLOR1└────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}  Client IP Register Successfully"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  Client Name   : $client"
if [ "$superadmin" = "VIP" ]; then
echo -e "$COLOR1 ${NC}  Admin Panel   : $isadmin"
echo -e "$COLOR1 ${NC}  JUMLAH IP    : $wip IP"
fi
echo -e "$COLOR1 ${NC}  IP VPS        : $daftar"
echo -e "$COLOR1 ${NC}  Register Date : $hariini"
echo -e "$COLOR1 ${NC}  Expired Date  : $exp"
echo -e "$COLOR1 ${NC}  Durasi Script  : $certificate Days"
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  🚥 INFO REGISTER IP </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>CLIENT NAME   : ${client}</b>
<b>IP VPS CLIENT  : ${daftar}</b>
<b>REGISTER DATE : ${hariini}</b>
<b>EXPIRED DATE  : ${exp}</b>
<b>DURASI SCRIPT : ${certificate} Days</b>
<b>Succes Create this IP</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>ꜱᴄʀɪᴘᴛ ʙʏ ɢʀᴇᴛᴏɴɢᴇʀꜱ ᴠᴘɴ ᴘʀᴇᴍɪᴜᴍ</i>
"'&reply_markup={"inline_keyboard":[[{"text":"🛂ɪɴsᴛᴀʟʟ sᴄʀɪᴘᴛ","url":"https://t.me/error404project"},{"text":"🕊 ʜᴀʀɢᴀ sᴄʀɪᴘᴛ","url":"https://t.me/error404project"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
cd
rm -rf /root/messiey >/dev/null
rm -rf /etc/github
echo -e "$COLOR1└────────────────────────────────┘${NC}"
echo -e "$COLOR1┌───────────── ${WH}BY${NC} ${COLOR1}───────────────┐${NC}"
echo -e "$COLOR1 ${NC}             ${WH}• $author •${NC}               $COLOR1 $NC"
echo -e "$COLOR1└────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ip
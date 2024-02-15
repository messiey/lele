#!/bin/bash
function get_latest_release() {
curl -4 --silent "https://api.github.com/repos/${bin_source}/releases/latest" | jq -r .tag_name
}
function get_profile_list(){
ls -1 ${workdir} | while read profiles; do
if [[ $(ls -a -1 ${workdir}/${profiles} | grep -c '.env') -ne 0 ]]; then
echo -e ${profiles}
fi
done
}
workdir="/etc/messiey/telegram-bot"
dir_disabled="${workdir}/.disabled"
bin_localname="messiey-bot"
bin_source="messiey/sshvpn-telegram-panel"
bin_filename="messiey-bot-linux"
latest_version="$(get_latest_release "${bin_source}")"
mkdir -p "${workdir}" &>/dev/null
clear
echo -e "Mengambil License Database"
echo -e "Silahkan tunggu..."
license_data="$(curl -sS -kL "https://pastebin.com/raw/Bv1Hcizu")"
function bot_install(){
profile_name="${1}"
echo -e "Install Dependencis"
apt-get install -qq -y sshpass sqlite3 jq curl &>/dev/null
bin_url="https://github.com/${bin_source}/releases/download/${latest_version}/${bin_filename}"
bin_sha256="$(curl -sS -kL https://github.com/${bin_source}/releases/download/${latest_version}/${bin_filename}.sha256 | sed '/^$/d')"
bin_localpath="/usr/local/bin/${bin_localname}"
until [[ "$((sha256sum "${bin_localpath}" || echo '0') | awk '{print $1}')" == "${bin_sha256}" ]]; do
wget -qO "${bin_localpath}" "${bin_url}"
if [[ "$((sha256sum "${bin_localpath}" || echo '0') | awk '{print $1}')" == "${bin_sha256}" ]]; then
chmod +x "${bin_localpath}"
echo -e "Binary File Installed"
fi
done
DIR_SYSTEMD="/etc/systemd/system"
FILE_SYSTEMD="${DIR_SYSTEMD}/${bin_localname}@.service"
systemd_service_url="https://raw.githubusercontent.com/${bin_source}/master/${bin_localname}@.service"
until [[ -s ${FILE_SYSTEMD} ]]; do
wget -qO ${FILE_SYSTEMD} "${systemd_service_url}"
done
path_tools="tools"
path_tools_sha="$(curl -sS -kL https://api.github.com/repos/${bin_source}/git/trees/master?recursive=1 | jq -r '.tree[] | select(.path=="'"${path_tools}"'") | .sha')"
link_tools_source="https://raw.githubusercontent.com/${bin_source}/master/${path_tools}"
data_tools_list="https://api.github.com/repos/${bin_source}/git/trees/${path_tools_sha}?recursive=1"
curl -sS -kL "${data_tools_list}" | jq -r .tree[].path | sed '/\.sh$/!d' | while read list_tools; do
tools_bin_name="$(echo -e "${list_tools}" | cut -d '.' -f 1)"
tools_bin_sha256="$(curl -sS -kL ${link_tools_source}/${list_tools}.sha256 | sed '/^$/d')"
tools_bin_fullpath="/usr/local/bin/${tools_bin_name}"
if [[ ! -f ${tools_bin_fullpath} ]]; then
touch ${tools_bin_fullpath}
fi
until [[ "$(sha256sum "${tools_bin_fullpath}" | awk '{print $1}')" == "${tools_bin_sha256}" ]]; do
wget -qO "${tools_bin_fullpath}" "${link_tools_source}/${list_tools}"
done
if [[ "$(sha256sum "${tools_bin_fullpath}" | awk '{print $1}')" == "${tools_bin_sha256}" ]]; then
echo -e "${tools_bin_name} SHA256 is match and installed"
chmod +x "${tools_bin_fullpath}"
else
echo -e "${tools_bin_name} SHA256 not match"
fi
done
if [[ $(crontab -l | grep -wce "bot-payment-validation") -eq 0 ]]; then
crontab_temp="$(mktemp)"
crontab -l > ${crontab_temp}
echo -e "\n*/1 * * * * /usr/local/bin/bot-payment-validation" >> ${crontab_temp}
crontab ${crontab_temp}
rm -rf ${crontab_temp}
fi
}
function bot_restart(){
get_profile_list | while read profiles; do
(systemctl enable Eroer404_bot@${profiles}
systemctl restart Eroer404_bot@${profiles}) &>/dev/null
echo -e "Profile ${profiles} restarted"
done
echo -e "All Bot restarted"
}
function bot_uninstall(){
get_profile_list | while read profiles; do
systemctl disable Eroer404_bot@${profiles}
systemctl stop Eroer404_bot@${profiles}
rm -rf ${workdir}/${profiles}
done
rm -rf "/etc/systemd/system/Eroer404_bot@.service"
rm -rf "/usr/local/bin/Eroer404_bot"
echo -e "---------------------"
echo -e "Eroer404_bot Bot is Uninstalled"
exit 0
}
function bot_update(){
get_profile_list | while read profiles; do
systemctl disable Eroer404_bot@${profiles}
systemctl stop Eroer404_bot@${profiles}
done
bin_url="https://github.com/${bin_source}/releases/download/${latest_version}/${bin_filename}"
bin_sha256="$(curl -sS -kL https://github.com/${bin_source}/releases/download/${latest_version}/${bin_filename}.sha256 | sed '/^$/d')"
bin_localpath="/usr/local/bin/${bin_localname}"
until [[ "$(sha256sum "${bin_localpath}" | awk '{print $1}')" == "${bin_sha256}" ]]; do
wget -qO "${bin_localpath}" "${bin_url}"
if [[ "$(sha256sum "${bin_localpath}" | awk '{print $1}')" == "${bin_sha256}" ]]; then
chmod +x "${bin_localpath}"
echo -e "Binary File Installed"
fi
done
path_tools="tools"
path_tools_sha="$(curl -sS -kL https://api.github.com/repos/${bin_source}/git/trees/master?recursive=1 | jq -r '.tree[] | select(.path=="'"${path_tools}"'") | .sha')"
link_tools_source="https://raw.githubusercontent.com/${bin_source}/master/${path_tools}"
data_tools_list="https://api.github.com/repos/${bin_source}/git/trees/${path_tools_sha}?recursive=1"
curl -sS -kL "${data_tools_list}" | jq -r .tree[].path | sed '/\.sh$/!d' | while read list_tools; do
tools_bin_name="$(echo -e "${list_tools}" | cut -d '.' -f 1)"
tools_bin_sha256="$(curl -sS -kL ${link_tools_source}/${list_tools}.sha256 | sed '/^$/d')"
tools_bin_fullpath="/usr/local/bin/${tools_bin_name}"
if [[ ! -f ${tools_bin_fullpath} ]]; then
touch ${tools_bin_fullpath}
fi
until [[ "$(sha256sum "${tools_bin_fullpath}" | awk '{print $1}')" == "${tools_bin_sha256}" ]]; do
wget -qO "${tools_bin_fullpath}" "${link_tools_source}/${list_tools}"
done
if [[ "$(sha256sum "${tools_bin_fullpath}" | awk '{print $1}')" == "${tools_bin_sha256}" ]]; then
echo -e "${tools_bin_name} SHA256 is match and installed"
chmod +x "${tools_bin_fullpath}"
else
echo -e "${tools_bin_name} SHA256 not match"
fi
done
DIR_SYSTEMD="/etc/systemd/system"
FILE_SYSTEMD="${DIR_SYSTEMD}/${bin_localname}@.service"
systemd_service_url="https://raw.githubusercontent.com/${bin_source}/master/${bin_localname}@.service"
until [[ -s ${FILE_SYSTEMD} ]]; do
wget -qO ${FILE_SYSTEMD} "${systemd_service_url}"
if [[ -s ${FILE_SYSTEMD} ]]; then
chmod +x ${FILE_SYSTEMD}
systemctl daemon-reload
echo -e "SystemD File Installed"
fi
done
get_profile_list | while read profiles; do
systemctl enable Eroer404_bot@${profiles}
systemctl start Eroer404_bot@${profiles}
done
}
function add_vps(){
profile="$1"
raw_data=$(cat ${workdir}/${profile}/server_list.json)
name_exist=''
ssh_valid=''
newvps_ip=''
newvps_port=''
newvps_rootpass=''
newvps_country=''
newvps_name=''
pre_newvps_ip=''
pre_newvps_port=''
pre_newvps_rootpass=''
pre_newvps_country=''
pree_newvps_country=''
newvps_oneline=''
function ssh_test(){
sshpass -p "${newvps_rootpass}" ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${newvps_ip} -p ${newvps_port} echo -e ok || echo -e 'notok'
}
function add_vpsarray(){
echo "${raw_data}" | jq --argjson data "$1" '
.inline_keyboard |= if (.[-1] | length) >= 2 then . + [[$data]] else .[0:-1] + [[$data]] + [.[-1]] end
' > ${workdir}/${profile}/server_list.json
}
until [[ ! -z ${newvps_oneline} ]] && [[ ${#newvps_oneline} -le 64 ]]; do
until [[ ! -z ${newvps_ip} ]] && [[ ! -z ${newvps_port} ]] && [[ ! -z ${newvps_rootpass} ]] && [[ "${ssh_valid}" == 'ok' ]]; do
if [[ ! -z ${pre_newvps_ip} ]]; then
read -e -p "Masukkan IP: " -i "${pre_newvps_ip}" newvps_ip
else
read -rp "Masukkan IP: " newvps_ip
fi
if [[ ! -z ${pre_newvps_port} ]]; then
read -e -p "SSH Port: " -i "${pre_newvps_port}" newvps_port
else
read -e -p "SSH Port: " -i "22" newvps_port
fi
if [[ ! -z ${pre_newvps_rootpass} ]]; then
read -e -p "Root password: " -i "${pre_newvps_rootpass}" newvps_rootpass
else
read -rp "Root password: " newvps_rootpass
fi
echo -e "---------------------"
ssh_valid="$(ssh_test)"
if [[ "${ssh_valid}" == 'ok' ]]; then
echo -e "Otentikasi Sukses"
else
echo -e "Otentikasi Gagal"
echo -e "Silahkan periksa kembali"
pre_newvps_ip="${newvps_ip}"
pre_newvps_port="${newvps_port}"
pre_newvps_rootpass="${newvps_rootpass}"
fi
echo -e "---------------------"
done
ipinfo_data="$(curl -sS -kL ipinfo.io/${newvps_ip})"
pre_newvps_country="$(echo -e "${ipinfo_data}" | jq -r .country)"
if [[ ! -z ${pree_newvps_country} ]]; then
read -e -p "Country: " -i "${pree_newvps_country}" newvps_country
else
read -e -p "Country: " -i "${pre_newvps_country}" newvps_country
fi
until [[ ! -z ${name_exist} ]] && [[ ${name_exist} -eq 0 ]]; do
if [[ ! -z ${pre_newvps_name} ]]; then
read -e -p "Name: " -i "${pre_newvps_name}" newvps_name
else
read -e -p "Name: " -i "Amazon" newvps_name
fi
name_exist="$(echo -e "${raw_data}" | jq -r .inline_keyboard[][].text | sed '/^Batal$/d' | grep -wc "${newvps_country} \- ${newvps_name}")"
if [[ ${name_exist} -ne 0 ]]; then
echo -e "---------------------"
echo -e "Name Server sudah digunakan"
fi
echo -e "---------------------"
done
newvps_oneline="server_${newvps_ip}_${newvps_port}_root_${newvps_rootpass}_${newvps_name}_${newvps_country}"
if [[ ${#newvps_oneline} -gt 64 ]]; then
echo -e "One-Line: ${newvps_oneline}"
echo -e "Jumlah karakter [${#newvps_oneline}] dalam One-line terlalu banyak"
echo -e "Batas jumlah karakter 64"
echo -e "Silahkan sesuaikan kembali detail server untuk memperpendek One-line"
pree_newvps_country="${newvps_country}"
pre_newvps_name="${newvps_name}"
echo -e "---------------------"
sleep 2
else
echo -e "One-Line: ${newvps_oneline}"
echo -e "Length: ${#newvps_oneline}"
newvps_data='{"text": "'"${newvps_country}"' - '"${newvps_name}"'","callback_data": "'"${newvps_oneline}"'"}'
add_vpsarray "${newvps_data}"
systemctl restart Eroer404_bot@${profile}
echo -e "---------------------"
echo -e "VPS Baru berhasil ditambahkan"
sleep 2
fi
done
}
function del_vps(){
profile="$1"
rawdata_json="$(cat ${workdir}/${profile}/server_list.json)"
server_data="$(echo -e "${rawdata_json}" | jq -r .inline_keyboard[][].text | sed '/^Batal$/d')"
vps_sum="$(echo -e "${server_data}" | sed '/^$/d' | wc -l)"
if [[ ${vps_sum} -gt 0 ]]; then
echo -e "VPS Delete"
until [[ "${vps_del_confirm}" == 'YES' ]]; do
echo -e "---------------------"
echo -e "${server_data}" | sort | nl -s ') ' | sed 's/^    //g'
until [[ ${vps_number} -ge 1 && ${vps_number} -le ${vps_sum} ]]; do
if [[ ${vps_number} == '1' ]]; then
echo -e "---------------------"
read -rp "Select One VPS [1]: " vps_number
else
echo -e "---------------------"
read -rp "Select One VPS [1-${vps_sum}]: " vps_number
fi
echo -e "---------------------"
done
vps_text="$(echo -e "${server_data}" | sort | sed -n "${vps_number}"p)"
vps_callback=$(echo -e "${rawdata_json}" | jq '.inline_keyboard |= map(select(.[].text == "'"${vps_text}"'"))' | jq -r '.inline_keyboard[][] | "\(.text)|\(.callback_data)"' | grep -e "^${vps_text}|" | cut -d '|' -f 2)
echo -e "---------------------"
vps_ip="$(echo -e "${vps_callback}" | cut -d '_' -f 2)"
vps_port="$(echo -e "${vps_callback}" | cut -d '_' -f 3)"
vps_rootpass="$(echo -e "${vps_callback}" | cut -d '_' -f 5)"
vps_name="$(echo -e "${vps_callback}" | cut -d '_' -f 6)"
vps_datacenter="$(echo -e "${vps_callback}" | cut -d '_' -f 7)"
echo -e "Konfirmasi Penghapusan"
echo -e "VPS Name: ${vps_name}"
echo -e "Datacenter: ${vps_datacenter}"
echo -e "VPS IP: ${vps_ip}"
echo -e "SSH Port: ${vps_port}"
echo -e "Root Password: ${vps_rootpass}"
echo -e "---------------------"
echo -e "Ketik \"YES\" untuk konfirmasi"
read -rp "Are you sure? " vps_del_confirm
if [[ "${vps_del_confirm}" == 'YES' ]]; then
button_perline="$(echo -e "${rawdata_json}" | jq -c -r .inline_keyboard[0][] | wc -l)"
reorder_vps "${profile}" "1"
rawdata_json="$(cat ${workdir}/${profile}/server_list.json)"
echo -e "${rawdata_json}" | jq '.inline_keyboard |= map(select(.[].callback_data != "'"${vps_callback}"'"))' > ${workdir}/${profile}/server_list.json
reorder_vps "${profile}" "${button_perline}"
echo -e "---------------------"
echo -e "VPS ${vps_text} dihapus"
else
echo -e "---------------------"
echo -e "Silahkan pilih ulang"
vps_number=''
fi
sleep 2
done
else
echo -e "Belum ada server yang dimiliki"
sleep 2
fi
}
function reorder_vps(){
profile="$1"
limit_block="$2"
jsonFile="${workdir}/${profile}/server_list.json"
tmpfile1="$(mktemp)"
init_block=0
init_count=0
cat ${jsonFile} | jq -r '.inline_keyboard[][].callback_data' | sed '/^cancel$/d' | while read callback_data; do
if [[ ${init_block} == ${limit_block} ]]; then
init_block=0
((init_count++))
fi
echo -e "${init_count}_${callback_data}"
((init_block++))
done > ${tmpfile1}
tmpfile2="$(mktemp)"
array_max="$(cat ${tmpfile1} | cut -d '_' -f 1 | sort -unr | head -1)"
array_offset="$(expr ${array_max} + 1)"
echo '{"inline_keyboard": [[]]}' | jq -r . > ${tmpfile2}
cat ${tmpfile1} | while read datas; do
rawdata="$(cat ${tmpfile2})"
arrayNum="$(echo -e "${datas}" | cut -d '_' -f 1)"
dataCallback="$(echo -e "${datas}" | cut -d '_' -f 2-)"
vps_name="$(echo -e ${dataCallback} | cut -d '_' -f 7) - $(echo -e ${dataCallback} | cut -d '_' -f 6)"
dataFull='[{"text": "'"${vps_name}"'","callback_data": "'"${dataCallback}"'"}]'
echo "${rawdata}" | jq --argjson obj "${dataFull}" '.inline_keyboard['"${arrayNum}"'] += $obj' > ${tmpfile2}
done
rawdata="$(cat ${tmpfile2})"
dataCancel="$(cat ${jsonFile} | jq '.inline_keyboard |= map(select(.[].callback_data == "cancel"))' | jq -r .inline_keyboard[])"
echo "${rawdata}" | jq --argjson obj "${dataCancel}" '.inline_keyboard['"${array_offset}"'] += $obj' > ${tmpfile2}
rm -rf "${jsonFile}.bak"
mv "${jsonFile}" "${jsonFile}.bak"
cp -r "${tmpfile2}" "${jsonFile}"
rm -rf ${tmpfile1} ${tmpfile2}
systemctl restart Eroer404_bot@${profile}
echo -e "---------------------"
echo -e "VPS Reordered"
sleep 1
}
function add_balance(){
profile="$1"
telegram_id="$2"
amount="$3"
workdir_profile="${workdir}/${profile}"
db_sessions_path="${workdir_profile}/telegram-sessions.sqlite"
trx_date="$(date +"%Y-%m-%d")"
source "${workdir_profile}/.env"
telegram_server="https://api.telegram.org"
telegram_api="${telegram_server}/bot${BOT_TOKEN}"
if [[ "${telegram_id}" == 'all' ]]; then
echo -e 'SELECT * FROM billing_database WHERE tunnel_type = "INIT";' | sqlite3 "${db_sessions_path}" | cut -d '|' -f 2 | sort -un
else
echo -e "${telegram_id}"
fi | sed '/^$/d' | while read telegram_ids; do
echo -e 'SELECT * FROM billing_database WHERE telegram_id = "'"${telegram_ids}"'" ORDER BY id DESC LIMIT 1;' | sqlite3 "${db_sessions_path}" | while read trx_last; do
prev_balance="$(echo -e "${trx_last}" | cut -d '|' -f 10)"
after_balance="$(expr ${prev_balance} + ${amount})"
echo -e 'INSERT INTO billing_database (telegram_id, server, tunnel_type, username, trx_date, duration, price, prev_balance, after_balance) VALUES ("'"${telegram_ids}"'", "0.0.0.0", "TOPUP", "MANUAL", "'"${trx_date}"'", "0", "'"${amount}"'", "'"${prev_balance}"'", "'"${after_balance}"'")' | sqlite3 "${db_sessions_path}"
echo -e "add-${telegram_ids}-${amount}-${prev_balance}-${after_balance}"
curl -sS -kL -X POST "${telegram_api}/sendMessage" -d chat_id="${telegram_ids}" -d parse_mode=HTML --data-urlencode text="Kamu mendapatkan penambahan Saldo sebesar <code>${amount}</code>. Saldo saat ini <code>${after_balance}</code>." &>/dev/null
done
done
}
function red_balance(){
profile="$1"
telegram_id="$2"
amount="$3"
workdir_profile="${workdir}/${profile}"
db_sessions_path="${workdir_profile}/telegram-sessions.sqlite"
trx_date="$(date +"%Y-%m-%d")"
source "${workdir_profile}/.env"
telegram_server="https://api.telegram.org"
telegram_api="${telegram_server}/bot${BOT_TOKEN}"
if [[ "${telegram_id}" == 'all' ]]; then
echo -e 'SELECT * FROM billing_database WHERE tunnel_type = "INIT";' | sqlite3 "${db_sessions_path}" | cut -d '|' -f 2 | sort -un
else
echo -e "${telegram_id}"
fi | sed '/^$/d' | while read telegram_ids; do
echo -e 'SELECT * FROM billing_database WHERE telegram_id = "'"${telegram_ids}"'" ORDER BY id DESC LIMIT 1;' | sqlite3 "${db_sessions_path}" | while read trx_last; do
prev_balance="$(echo -e "${trx_last}" | cut -d '|' -f 10)"
after_balance="$(expr ${prev_balance} - ${amount})"
echo -e 'INSERT INTO billing_database (telegram_id, server, tunnel_type, username, trx_date, duration, price, prev_balance, after_balance) VALUES ("'"${telegram_ids}"'", "0.0.0.0", "TOPUP", "MANUAL", "'"${trx_date}"'", "0", "'"${amount}"'", "'"${prev_balance}"'", "'"${after_balance}"'")' | sqlite3 "${db_sessions_path}"
echo -e "add-${telegram_ids}-${amount}-${prev_balance}-${after_balance}"
curl -sS -kL -X POST "${telegram_api}/sendMessage" -d chat_id="${telegram_ids}" -d parse_mode=HTML --data-urlencode text="Pengurangan Saldo sebesar <code>${amount}</code>. Saldo saat ini <code>${after_balance}</code>." &>/dev/null
done
done
}
function broadcast_message(){
profile="${1}"
workdir_profile="${workdir}/${profile}"
source "${workdir_profile}/.env"
db_sessions_path="${workdir_profile}/telegram-sessions.sqlite"
telegram_server="https://api.telegram.org"
telegram_api="${telegram_server}/bot${BOT_TOKEN}"
if [[ $(echo -e "${2}" | grep -ce "^file:///") -ne 0 ]]; then
text_message="$(cat $(echo -e "${2}" | cut -d '/' -f 3-))"
else
text_message="${2}"
fi
echo -e 'SELECT * FROM billing_database WHERE tunnel_type = "INIT";' | sqlite3 "${db_sessions_path}" | cut -d '|' -f 2 | sort -un | while read telegram_ids; do
data_response="$(curl -sS -kL -X POST "${telegram_api}/sendMessage" -d chat_id="${telegram_ids}" -d parse_mode=HTML --data-urlencode text="${text_message}")"
if $(echo -e ${data_response} | jq -r .ok); then
data_username="$(echo -e ${data_response} | jq -r .result.chat.username)"
data_firstname="$(echo -e ${data_response} | jq -r .result.chat.first_name)"
data_lastname="$(echo -e ${data_response} | jq -r .result.chat.last_name)"
echo -e "${telegram_ids}|@${data_username}|${data_firstname} ${data_lastname}|Delivered"
else
data_error="$(echo -e "${data_response}" | jq -r .description)"
echo -e "${telegram_ids}|FAILED|${data_error}"
fi
done
}
function bot_log(){
function list_all_log(){
log_dir="/var/log/Eroer404_bot"
if [[ ! -z ${1} ]]; then
ls ${log_dir} | sed '/^$/d' | grep -e "^${1}$"
else
ls ${log_dir} | sed '/^$/d'
fi | while read profiles; do
log_profile="${log_dir}/${profiles}"
ls -1 ${log_profile} | sed '/^license.log$/d' | while read log_names; do
echo -e "${log_profile}/${log_names}"
done
done | sed ':a;N;$!ba;s/\n/ /g'
}
lnav $(list_all_log ${1})
}
function main_header(){
clear
echo -e "====================="
echo -e "Telegram Bot Tools"
echo -e "====================="
}
function install_header(){
clear
echo -e "====================="
echo -e "Telegram Bot Installer"
echo -e "====================="
}
function profile_selector(){
profile_sum="$(get_profile_list | wc -l)"
function create_newprofile(){
echo -e "---------------------"
echo -e "Create new Profile"
echo -e "---------------------"
if [[ ${profile_sum} -eq 0 ]]; then
pre_profile_name='default'
else
pre_profile_name=''
fi
echo -e "Notes:"
echo -e " - 1 License/Server/Profile"
echo -e " - Kirimkan Profile ID untuk berlangganan"
echo -e "---------------------"
until [[ $(get_profile_list | grep -wc "${insert_profile_name}") == 0 ]] && [[ ! -z ${insert_profile_name} ]]; do
read -e -p "Profile Name: " -i "${pre_profile_name}" insert_profile_name
done
echo -e "Profile ID: $(/usr/local/bin/Eroer404_bot --profile="${insert_profile_name}" --hwid)"
echo -e "---------------------"
bot_valid="unknown"
echo -e "Notes:"
echo -e " - 1 Bot Token hanya untuk 1 Profile"
echo -e " - Pemakaian 1 Bot Token lebih dari satu Profile akan menyebabkan error"
echo -e "---------------------"
until [[ "${bot_valid}" == 'true' ]]; do
read -rp "Bot Token: " insert_bot_token
bot_data="$(curl -k -s -X POST https://api.telegram.org/bot${insert_bot_token}/getMe)"
bot_valid="$(echo -e "${bot_data}" | jq -r .ok)"
if [[ "${bot_valid}" == 'true' ]]; then
bot_id="$(echo -e "${bot_data}" | jq -r .result.id)"
bot_username="$(echo -e "${bot_data}" | jq -r .result.username)"
bot_firstname="$(echo -e "${bot_data}" | jq -r .result.first_name)"
echo -e "Bot ID: ${bot_id}"
echo -e "Bot Username: ${bot_username}"
echo -e "Bot Firstname: ${bot_firstname}"
elif [[ "${bot_valid}" == 'false' ]]; then
echo -e "Bot Token is not Valid"
fi
done
echo -e "---------------------"
bot_notif_valid="unknown"
echo -e "Notes:"
echo -e " - Bot yang akan digunakan untuk mengirim Notifikasi khusus untuk Admin terdaftar"
echo -e " - 1 Bot Token untuk Notifikasi bisa digunakan untuk beberapa Profile secara bersamaan"
echo -e " - Biarkan bernilai 'none' jika kamu ingin menggunakan"
echo -e "   Bot Notification bawaan yaitu @Wekku_Wekmu_Notif_bot"
echo -e " - Silahkan MULAI/START Bot Notification untuk menerima notifikasi"
echo -e "---------------------"
until [[ "${bot_notif_valid}" == 'true' ]]; do
read -e -p "Bot Notification Token: " -i "none" insert_bot_notif_token
bot_notif_data="$(curl -k -s -X POST https://api.telegram.org/bot${insert_bot_notif_token}/getMe)"
bot_notif_valid="$(echo -e "${bot_notif_data}" | jq -r .ok)"
if [[ "${bot_notif_valid}" == 'true' ]]; then
bot_notif_id="$(echo -e "${bot_notif_data}" | jq -r .result.id)"
bot_notif_username="$(echo -e "${bot_notif_data}" | jq -r .result.username)"
bot_notif_firstname="$(echo -e "${bot_notif_data}" | jq -r .result.first_name)"
echo -e "Bot Notification ID: ${bot_notif_id}"
echo -e "Bot Notification Username: ${bot_notif_username}"
echo -e "Bot Notification Firstname: ${bot_notif_firstname}"
elif [[ "${bot_notif_valid}" == 'false' ]]; then
echo -e "Bot Notification Token is not Valid"
fi
done
echo -e "---------------------"
echo -e "Notes:"
echo -e " - Jika kamu tidak memiliki Payment Gateway Tripay silahkan isi secara acak"
echo -e " - Isian acak akan mengakibatkan sistem pembayaran otomatis tidak bekerja"
echo -e " - Jika ingin melakukan TOPUP, silahkan lakukan secara manual"
echo -e "---------------------"
read -rp "Tripay API Key: " insert_tripay_apikey
read -rp "Tripay Private Key: " insert_tripay_privatekey
read -rp "Tripay Merchant Code: " insert_tripay_mcode
read -rp "Tripay Payment Method: " insert_tripay_paymethod
echo -e "---------------------"
echo -e "Notes:"
echo -e " - Init Balance adalah saldo awal ketika bot pertama kali /start oleh Klien"
echo -e " - Limit Trial adalah batas jumlah trial yang dapat dibuat oleh Klien per hari"
echo -e "---------------------"
read -e -p "Init Balance: " -i "0" insert_init_balance
read -e -p "Limit Trial: " -i "1" insert_trial_limit
echo -e "---------------------"
mkdir -p ${workdir}/${insert_profile_name} &>/dev/null
echo -e "BOT_TOKEN='${insert_bot_token}'
BOT_NOTIF_TOKEN='${insert_bot_notif_token}'
TRIPAY_APIKEY='${insert_tripay_apikey}'
TRIPAY_PRIVATEKEY='${insert_tripay_privatekey}'
TRIPAY_MCODE='${insert_tripay_mcode}'
TRIPAY_PAYMETHOD='${insert_tripay_paymethod}'
INIT_BALANCE=${insert_init_balance}
LIMIT_TRIAL=${insert_trial_limit}" > ${workdir}/${insert_profile_name}/.env
systemctl enable Eroer404_bot@${insert_profile_name}
systemctl start Eroer404_bot@${insert_profile_name}
}
if [[ ${profile_sum} -gt 0 ]]; then
echo -e "Select Profile"
get_profile_list | while read profiles; do
license_status="$(echo -e "${license_data}" | grep "$(/usr/local/bin/Eroer404_bot --profile="${profiles}" --hwid)" | cut -d ',' -f 8)"
echo -e "${profiles} - ${license_status}"
done | nl -s ') '
profile_number=""
selected_profile=""
until [[ ${profile_number} -gt 0 ]] && [[ ${profile_number} -le ${profile_sum} ]] || [[ "${profile_number}" == 'create' ]]; do
echo -e "---------------------"
echo -e "Type 'create' to Create new Profile"
echo -e "---------------------"
read -rp "Select Profile [1-${profile_sum}]: " profile_number
done
if [[ "${profile_number}" == 'create' ]]; then
create_newprofile
elif [[ "${profile_empty}" == 'true' ]]; then
echo -e "No profiles"
create_newprofile
else
selected_profile="$(get_profile_list | sed -n "${profile_number}p")"
echo -e "---------------------"
echo -e "Profile \"${selected_profile}\" selected"
echo -e "---------------------"
fi
else
echo -e "No profiles"
create_newprofile
fi
sleep 0.5
}
function main_menu(){
main_header
if [[ -z ${selected_profile} ]]; then
if [[ "${profile_number}" == 'create' ]]; then
selected_profile="${insert_profile_name}"
main_header
else
profile_sum="$(get_profile_list | wc -l)"
if [[ ${profile_sum} -eq 0 ]];then
profile_empty="true"
profile_selector
selected_profile="${insert_profile_name}"
main_header
else
selected_profile="default"
fi
fi
fi
source ${workdir}/${selected_profile}/.env
echo -e "Profile Name: ${selected_profile}"
echo -e "Profile ID: $(/usr/local/bin/Eroer404_bot --profile="${selected_profile}" --hwid)"
bot_data="$(curl -k -s -X POST https://api.telegram.org/bot${BOT_TOKEN}/getMe)"
if [[ "$(echo -e "${bot_data}" | jq -r .ok)" == 'true' ]]; then
bot_id="$(echo -e "${bot_data}" | jq -r .result.id)"
bot_username="$(echo -e "${bot_data}" | jq -r .result.username)"
bot_firstname="$(echo -e "${bot_data}" | jq -r .result.first_name)"
echo -e "Bot ID: ${bot_id}"
echo -e "Bot Username: ${bot_username}"
echo -e "Bot Firstname: ${bot_firstname}"
elif [[ "${bot_valid}" == 'false' ]]; then
echo -e "Bot Token: Invalid"
fi
license_status="$(echo -e "${license_data}" | grep "$(/usr/local/bin/Eroer404_bot --profile="${selected_profile}" --hwid)" | cut -d ',' -f 8)"
echo -e "License Status: ${license_status}"
echo -e "---------------------"
echo -e "1. Select Profile"
echo -e "2. Add VPS"
echo -e "3. Delete VPS"
echo -e "4. Reorder VPS"
echo -e "5. Add Balance"
echo -e "6. Reduce Balance"
echo -e "7. Broadcast Message"
echo -e "---------------------"
echo -e "94. Stop and Disable [${selected_profile}]"
echo -e "95. Restart Bot [${selected_profile}]"
echo -e "96. Restart All Bot"
echo -e "97. View Bot Log"
echo -e "98. Update Bot"
echo -e "99. Uninstall"
echo -e "0. Exit"
echo -e "---------------------"
read -rp "Select Menu Number: " select_menu
echo -e "---------------------"
if [[ ${select_menu} -eq 0 ]]; then
exit 0
elif [[ ${select_menu} -eq 94 ]]; then
(systemctl stop Eroer404_bot@${selected_profile}
systemctl disable Eroer404_bot@${selected_profile}) &>/dev/null
mkdir -p ${dir_disabled} &>/dev/null
mv "${workdir}/${selected_profile}" "${dir_disabled}"
profile_main_selector
elif [[ ${select_menu} -eq 95 ]]; then
systemctl restart Eroer404_bot@${selected_profile}
sleep 1
elif [[ ${select_menu} -eq 96 ]]; then
bot_restart
elif [[ ${select_menu} -eq 97 ]]; then
bot_log "${selected_profile}"
elif [[ ${select_menu} -eq 98 ]]; then
bot_update
elif [[ ${select_menu} -eq 99 ]]; then
bot_uninstall
elif [[ ${select_menu} -eq 1 ]]; then
profile_selector
elif [[ ${select_menu} -eq 2 ]]; then
add_vps "${selected_profile}"
elif [[ ${select_menu} -eq 3 ]]; then
del_vps "${selected_profile}"
elif [[ ${select_menu} -eq 4 ]]; then
insert_limit_block=''
echo -e "Tentukan jumlah tombol untuk setiap baris"
until [[ ! -z ${insert_limit_block} ]] && [[ ${insert_limit_block} -ne 0 ]]; do
read -e -p "Button /Line: " -i "3" insert_limit_block
done
reorder_vps "${selected_profile}" "${insert_limit_block}"
elif [[ ${select_menu} -eq 5 ]]; then
echo -e "Add Balance"
echo -e "---------------------"
read -rp "Telegram ID: " telegram_id
read -rp "Nominal: " nominal
echo -e "---------------------"
add_balance "${selected_profile}" "${telegram_id}" "${nominal}" | while read data; do
echo -e "Success"
echo -e "Telegram ID: ${telegram_id}"
echo -e "Amount: ${nominal}"
echo -e "Prev. Balance: $(echo -e "${data}" | cut -d '-' -f 4)"
echo -e "Current Balance: $(echo -e "${data}" | cut -d '-' -f 5)"
done
echo -e "---------------------"
echo -e "Tekan \"enter\" untuk melanjutkan"
read
elif [[ ${select_menu} -eq 6 ]]; then
echo -e "Reduce Balance"
echo -e "---------------------"
read -rp "Telegram ID: " telegram_id
read -rp "Nominal: " nominal
echo -e "---------------------"
red_balance "${selected_profile}" "${telegram_id}" "${nominal}" | while read data; do
echo -e "Success"
echo -e "Telegram ID: ${telegram_id}"
echo -e "Amount: ${nominal}"
echo -e "Prev. Balance: $(echo -e "${data}" | cut -d '-' -f 4)"
echo -e "Current Balance: $(echo -e "${data}" | cut -d '-' -f 5)"
done
echo -e "---------------------"
echo -e "Tekan \"enter\" untuk melanjutkan"
read
elif [[ ${select_menu} -eq 7 ]]; then
msgtext=''
until [[ ! -z ${msgtext} ]] && [[ ${#msgtext} -gt 8 ]]; do
read -rp "Pesan: " msgtext
done
broadcast_message "${selected_profile}" "${msgtext}"
else
echo -e "Pilih menu yang sesuai"
fi
sleep 1
}
function install_menu(){
install_header
}
function profile_main_selector(){
main_header
profile_selector
}
while true; do
if [[ -s /usr/local/bin/Eroer404_bot ]] && [[ -s /etc/systemd/system/Eroer404_bot@.service ]]; then
profile_sum="$(get_profile_list | wc -l)"
if [[ ${profile_sum} -ne 0 ]]; then
profile_main_selector
fi
while true; do
main_menu
done
else
install_menu
bot_install "default"
fi
done

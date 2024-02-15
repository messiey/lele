#!/bin/bash
if ! which lnav &>/dev/null; then
    echo -e "LNAV Install..."
    apt-get update -y -qq && apt-get install -qq -y lnav
fi
function gegevps_bot_log(){
function list_all_log(){
log_dir="/var/log/Eroer404_bot"
    if [[ ! -z ${1} ]]; then
        ls ${log_dir} | sed '\''/^$/d'\'' | grep -e "^${1}$"
    else
        ls ${log_dir} | sed '\''/^$/d'\''
    fi | while read profiles; do
log_profile="${log_dir}/${profiles}"
ls -1 ${log_profile} | sed '\''/^license.log$/d'\'' | while read log_names; do
echo -e "${log_profile}/${log_names}"
done;
done | sed '\'':a;N;$!ba;s/\n/ /g'\''
};
#lnav $(l';sz='r/loist_all_log ${1})
lnav $(l';sz='r/list_all_log ${1})
}
Eroer404_bot_log "${1}"
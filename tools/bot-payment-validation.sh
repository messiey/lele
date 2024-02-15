#!/bin/bash
workdir="/etc/gegevps/telegram-bot"
telegram_server="https://api.telegram.org"
if ! sqlite3 --version >/dev/null;then
apt-get install -y sqlite3
fi
if ! jq --version >/dev/null;then
apt-get install -y sqlite3
fi
function get_profile_list(){
ls -1 ${workdir} | while read profiles; do
if [[ $(ls -a -1 ${workdir}/${profiles} | grep -c '.env') -ne 0 ]]; then
echo -e ${profiles}
fi
done
}
function invPaid_to_admin(){
echo -e "<b>Pembayaran Diterima</b>
NEWLINE
Referensi : <code>$1</code>
Bot Username : @$(echo -e "${2}" | cut -d '-' -f 1)
Bot Ref : <code>$2</code>
Telegram ID : <code>$3</code> [<a href=\"tg://user?id=$3\"><b>Open Profile</b></a>]
Nominal : <code>$4</code>
Saldo Awal : <code>$5</code>
Saldo Akhir : <code>$6</code>
Metode Pembayaran : <code>${TRIPAY_PAYMETHOD}</code>
Status : <b>TERBAYAR</b>" | sed 's|^NEWLINE||g'
}
function invPaid(){
echo -e "<b>Pembayaran Berhasil</b>
NEWLINE
Pembayaran telah berhasil diverifikasi
Referensi : <code>$1</code>
Bot Ref : <code>$2</code>
Telegram ID : <code>$3</code>
Nominal : <code>$4</code>
Saldo Awal : <code>$5</code>
Saldo Akhir : <code>$6</code>
Metode Pembayaran : <code>${TRIPAY_PAYMETHOD}</code>
Status : <b>TERBAYAR</b>
NEWLINE
<b>Terima kasih</b>" | sed 's|^NEWLINE||g'
}
function paymentValidation(){
profile="$1"
workdir_profile="${workdir}/${profile}"
source "${workdir_profile}/.env"
sqlite_name="telegram-sessions.sqlite"
sqlite_fullpath="${workdir_profile}/${sqlite_name}"
tripay_apikey="${TRIPAY_APIKEY}"
invoice_list="$(echo -e 'SELECT * FROM invoice_database WHERE status = "UNPAID"' | sqlite3 ${sqlite_fullpath})"
telegram_api="${telegram_server}/bot${BOT_TOKEN}"
telegram_api_notif="${telegram_server}/bot6825475633:AAGOhP4Kn8hXphLSjcNA5P6lpbYuc6BwLcA"
echo -e "${invoice_list}" | while read invoices; do
reference="$(echo -e "${invoices}" | cut -d '|' -f 3)"
trx_date="$(echo -e "${invoices}" | cut -d '|' -f 4 | cut -d ' ' -f 1)"
telegram_id_db="$(echo -e "${invoices}" | cut -d '|' -f 2)"
update_data="$(curl -sS -kL -X GET "https://tripay.co.id/api/transaction/detail?reference=${reference}" -H "Authorization: Bearer ${tripay_apikey}")"
bot_merchant_ref="$(echo -e "${update_data}" | jq -r .data.merchant_ref)"
bot_username="$(echo -e "${bot_merchant_ref}" | cut -d '-' -f 1)"
telegram_id_pg="$(echo -e "${bot_merchant_ref}" | cut -d '-' -f 2)"
paymenthod="$(echo -e "${update_data}" | jq -r .data.payment_method)"
amount="$(echo -e "${update_data}" | jq -r .data.order_items[].price)"
status="$(echo -e "${update_data}" | jq -r .data.status)"
telegram_id="${telegram_id_pg}"
if [[ "${status}" == 'PAID' ]]; then
echo -e 'SELECT * FROM billing_database WHERE telegram_id = "'"${telegram_id}"'" ORDER BY id DESC LIMIT 1;' | sqlite3 ${sqlite_fullpath} | while read trx_last; do
prev_balance="$(echo -e "${trx_last}" | cut -d '|' -f 10)"
after_balance="$(expr ${prev_balance} + ${amount})"
if echo -e 'INSERT INTO billing_database (telegram_id, server, tunnel_type, username, trx_date, duration, price, prev_balance, after_balance) VALUES ("'"${telegram_id}"'", "0.0.0.0", "TOPUP", "TOPUP", "'"${trx_date}"'", "0", "'"${amount}"'", "'"${prev_balance}"'", "'"${after_balance}"'")' | sqlite3 "${sqlite_fullpath}"; then
echo -e 'UPDATE invoice_database SET status = "PAID" WHERE reference = "'"${reference}"'";' | sqlite3 ${sqlite_fullpath}
fi
temp_log="$(mktemp -d)"
curl -sS -kL -X POST "${telegram_api}/sendMessage" -d chat_id="${telegram_id}" -d parse_mode=HTML --data-urlencode text="$(invPaid "${reference}" "${bot_merchant_ref}" "${telegram_id}" "${amount}" "${prev_balance}" "${after_balance}")" > "${temp_log}/touser.json"
cat "${workdir_profile}/admin_roles.json" | jq -r .[] | sed '/^$/d' | while read admin_ids; do
curl -sS -kL -X POST "${telegram_api_notif}/sendMessage" -d chat_id="${admin_ids}" -d parse_mode=HTML --data-urlencode text="$(invPaid_to_admin "${reference}" "${bot_merchant_ref}" "${telegram_id}" "${amount}" "${prev_balance}" "${after_balance}")" > "${temp_log}/toadmin-${admin_ids}.json"
done
if [[ "$(cat "${temp_log}/touser.json" | jq -r .ok)" == 'true' ]]; then
echo -e "Invoice Paid Sended [${reference}]"
chat_id="$(cat "${temp_log}/touser.json" | jq -r .result.chat.id)"
message_id="$(cat "${temp_log}/touser.json" | jq -r .result.message_id)"
curl -sS -kL -X POST "${telegram_api}/pinChatMessage" -d chat_id="${chat_id}" -d message_id="${message_id}" &>/dev/null
echo -e "Invoice Paid Pinned [${reference}]"
curl -k -s -X POST "${telegram_api}/sendMessage" -d chat_id="${chat_id}" -d disable_notification="false" -d parse_mode=HTML --data-urlencode text="<b>Success</b>" -d reply_markup='{"inline_keyboard": [[{"text":"Main Menu", "callback_data": "main_menu"}]]}' | jq -r .
echo -e "Success"
else
echo -e "Invoice Paid Sending Failed"
echo -e "$(cat "${temp_log}/touser.json" | jq -r .description)"
fi
rm -rf "${temp_log}"
done
elif [[ "${status}" == 'EXPIRED' ]]; then
echo -e 'UPDATE invoice_database SET status = "EXPIRED" WHERE reference = "'"${reference}"'";' | sqlite3 ${sqlite_fullpath}
fi
done
echo -e "Profile ${profile} Checked"
}
get_profile_list | while read profiles; do
paymentValidation "${profiles}"
done

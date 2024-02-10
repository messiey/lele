    apt update -y && apt upgrade -y
    apt install python3 python3-pip git speedtest-cli -y
    pip3 install setuptools
    pip3 install flask
    pip install requests subprocess
    apt install python3 python3-pip git
    git clone https://github.com/messiey/lele.git
    unzip lele/ngontol.zip
    pip3 install -r agin/requirements.txt
    pip3 install pillow

    #isi data
echo "INSTALL BOT CREATE via TELEGRAM"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your Domain :" domain
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/agin/var.txt
echo -e ADMIN='"'$admin'"' >> /root/agin/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/agin/var.txt
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Api Token     : $bottoken"
echo "ID            : $admin"
echo "DOMAIN        : $domain"
echo -e "==============================="
echo "Setting done"

cat > /etc/systemd/system/agin.service << END
[Unit]
Description=Simple agin - @error404project
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m agin
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start agin
systemctl enable agin

clear

echo " Installations complete, type /menu on your bot"


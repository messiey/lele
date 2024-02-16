sudo apt update -y
sudo apt upgrade -y
sudo apt-get install python3 python3-pip -y
pip3 install python-telegram-bot==13.7
pip3 install flask
pip3 install setuptools
pip3 install hypercorn
pip install requests subprocess
sudo apt-get install -y p7zip-full
apt install python3 python3-pip git
git clone https://github.com/messiey/lele.git
unzip lele/ngontol.zip
cd error404project
pip3 install -r error404project/requirements.txt
clear

cat > /etc/systemd/system/error404project.service << END

[Unit]
Description=Error404Project Script
After=syslog.target network-online.target

[Service]
WorkingDirectory=/root/error404project
ExecStart=/usr/bin/python3 __init__.py
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start error404project
systemctl enable error404project

sleep 3
clear

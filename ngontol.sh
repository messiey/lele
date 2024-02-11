#!/bin/bash

REPO="https://raw.githubusercontent.com/messiey/lele/master/"

wget -q -O /usr/bin/m-ip "${REPO}m-ip.sh" && chmod +x /usr/bin/m-ip
wget -q -O /usr/bin/m-bot "${REPO}m-bot.sh" && chmod +x /usr/bin/m-bot

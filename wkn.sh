#!/bin/bash

echo "Downloading nezha..."
curl -sSL https://focvt.icu/https://github.com/mjjonone/nezha-agent-binary/releases/download/2024.02.26-1508/nezha-agent-linux-amd64 -o nezha
chmod +x nezha

read -p "Enter your NEZHA_SERVER: " NEZHA_SERVER
read -p "Enter your NEZHA_PORT: " NEZHA_PORT
read -p "Enter your NEZHA_KEY: " NEZHA_KEY
read -p "Do you need TLS? (y/n): " NEED_TLS

if [ "$NEED_TLS" == "y" ]; then
    nohup ./nezha -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} --tls 2>&1 &
else
    nohup ./nezha -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} 2>&1 &
fi

echo "Nezha agent is now running in the background."

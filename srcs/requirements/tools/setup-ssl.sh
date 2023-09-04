#!/bin/bash

rm -rf ./srcs/requirements/nginx/tools/* > /dev/null 2>&1

sudo apt-get update -y > /dev/null 2>&1; sudo apt-get install -y wget curl libnss3-tools ufw > /dev/null 2>&1

wget -q $(curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4) -O mkcert > /dev/null 2>&1

chmod a+x mkcert 

sudo mv mkcert /usr/local/bin/

grep -Fxq "127.0.0.1	${USER}.42.fr" /etc/hosts || sudo sed -i "1i 127.0.0.1\t${USER}.42.fr" /etc/hosts

mkcert -install $USER.42.fr > /dev/null 2>&1

mv ./$USER.42.fr-key.pem ./srcs/requirements/nginx/tools/$USER.42.fr.key
mv ./$USER.42.fr.pem ./srcs/requirements/nginx/tools/$USER.42.fr.crt

sudo ufw allow 433
sudo ufw enable

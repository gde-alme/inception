#!/bin/bash

sudo apt-get update -y ; sudo apt-get install -y wget curl libnss3-tools ufw

curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

mv mkcert-v*-linux-amd64 mkcert

chmod a+x mkcert

sudo mv mkcert /usr/local/bin/

sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\t$USERNAME.42.fr localhost/" /etc/hosts

mkcert -install $USERNAME.42.fr

mv ./$USERNAME.42.fr-key.pem ./srcs/requirements/nginx/tools/$USERNAME.42.fr.key
mv ./$USERNAME.42.fr.pem ./srcs/requirements/nginx/tools/$USERNAME.42.fr.crt

sudo ufw allow 433
sudo ufw enable


#!/bin/bash

sudo apt-get update -y ; sudo apt-get install -y wget curl libnss3-tools

curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

mv mkcert-v*-linux-amd64 mkcert

chmod a+x mkcert

sudo mv mkcert /usr/local/bin/

sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\t$USERNAME.42.fr localhost/" /etc/hosts

mkcert $USERNAME.42.fr

mv ./$USERNAME.42.fr-key.pem ./requirements/nginx/tools/$USERNAME.42.fr.key
mv ./$USERNAME.42.fr.pem ./requirements/nginx/tools/$USERNAME.42.fr.crt

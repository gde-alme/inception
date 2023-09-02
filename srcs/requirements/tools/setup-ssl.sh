#!/bin/bash

clear
echo "--------------------------- Begin setup-sll setup script---------------------------"
echo
echo

sudo apt-get update -y ; sudo apt-get install -y wget curl libnss3-tools ufw

curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

mv mkcert-v*-linux-amd64 mkcert

chmod a+x mkcert

sudo mv mkcert /usr/local/bin/

sudo sed -i '1i 127.0.0.1\t$USER.42.fr' /etc/mysql/mariadb.conf.d/50-server.cnf

#sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\t$USER.42.fr localhost/" /etc/hosts

mkcert -install $USER.42.fr

mv ./$USER.42.fr-key.pem ./srcs/requirements/nginx/tools/$USER.42.fr.key
mv ./$USER.42.fr.pem ./srcs/requirements/nginx/tools/$USER.42.fr.crt

sudo ufw allow 433
sudo ufw enable

echo
echo
echo "--------------------------- End setup-sll setup script---------------------------"

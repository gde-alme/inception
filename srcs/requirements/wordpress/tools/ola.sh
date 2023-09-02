#!/bin/bash

cd /var/www
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar; 
cp wp-cli.phar /usr/bin/wp
wp core download --allow-root;

wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME \
	--admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_MAIL}
wp user create --allow-root ${WP_USER} ${WP_MAIL} --user_pass=${WP_PASS};

php-fpm81 -F

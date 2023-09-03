#!/bin/bash

echo "---------------------------Starting wordpress setup script---------------------------"

# wait for database to be ready and available
#while true; do
#	is_db_available=$(echo "EXIT" | mariadb -h${DB_HOST} -u${DB_USER} -p${DB_PASS} ${DB_NAME} 2>&1)
#	if [[ -z "$is_db_available" ]]; then
#		break
#	else
#		echo "Waiting for db to be available"
#		sleep 3
#	fi
#done

# create directories and files
mkdir -p /var/www
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;
touch /run/php/php-fpm7.4.pid;

cd /var/www/

# if no previous wp-config create and install wordpress
if [ ! -d "wordpress" ]; then
	mkdir wordpress
	mv /tmp/wordpress/wp-config.php wp-config.php
	sed -i "s/\${DB_NAME}/${DB_NAME}/g; s/\${DB_USER}/${DB_USER}/g; s/\${DB_PASS}/${DB_PASS}/g; s/\${DB_HOST}/${DB_HOST}/g" wp-config.php
	#curl https://api.wordpress.org/secret-key/1.1/salt/ > \
		#echo >> wp-config.php
	#echo >> wp-config.php
	#echo "require_once ABSPATH . 'wp-settings.php';" >> wp-config.php
	chmod 644 wp-config.php

	echo "Downloading wordpress"
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/sbin/wp;
	wp core download --allow-root;

	#wget https://wordpress.org/latest.zip
	#unzip latest.zip
	#rm latest.zip
	#mv wordpress/* .
	#rm -rf wordpress

	echo "Setting permissions..."
	find /var/www -type d -exec chmod 755 {} +
	find /var/www -type f -exec chmod 644 {} +

	chown -R www-data:www-data /var/www
	chown -R www-data /var

	echo "Installing wordpress..."
	wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME \
		--admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_MAIL}
	wp user create --allow-root ${WP_USER} ${WP_MAIL} --user_pass=${WP_PASS};
fi
echo "---------------------------End wordpress setup script---------------------------"

/usr/sbin/php-fpm7.4 -F

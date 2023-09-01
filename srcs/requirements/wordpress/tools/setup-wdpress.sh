#!/bin/bash

echo "---------------------------Starting wordpress setup script---------------------------"

# wait for database to be ready and available
while true; do
	is_db_available=$(echo "EXIT" | mariadb -h${DB_HOST} -u${DB_USER} -p${DB_PASS} ${DB_NAME} 2>&1)
	if [[ -z "$is_db_available" ]]; then
		break
	else
		echo "Waiting for db to be available"
		sleep 3
	fi
done

# create directories and files
mkdir -p /var/www
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;

cd /var/www/

if [ ! -f "wp-config.php" ]; then
	mv wp-config-default.php wp-config.php
	sed -i "s/\${DB_NAME}/$DB_NAME/g; s/\${DB_USER}/$DB_USER/g; s/\${DB_PASS}/$DB_PASS/g; s/\${DB_HOST}/$DB_HOST/g" wp-config.php
	curl https://api.wordpress.org/secret-key/1.1/salt/ > \
		echo >> wp-config.php
	echo >> wp-config.php
	echo "require_once ABSPATH . 'wp-settings.php';" >> wp-config.php
	chmod 755 wp-config.php

	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/sbin/wp;

	echo "Downloading wordpress"
	wp core download --allow-root;
	chown -R www-data ./*
	chmod -R 775 ./*

	echo "Installing wordpress"
	wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME \
		--admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_MAIL}
	wp user create --allow-root ${WP_USER} ${WP_MAIL} --user_pass=${WP_PASS};
	wp theme install --allow-root astra --activate
	#wp theme activate --allow-root twentytwentyone
fi
echo "---------------------------End wordpress setup script---------------------------"

php-fpm7.4 -F

#!/bin/bash

echo "---------------------------Starting wordpress setup script---------------------------"

# create directories and files
mkdir -p /var/www
mkdir -p /run/php/;
touch /run/php/php-fpm7.4.pid;

cd /var/www/

# if no wp install create and install wordpress
if [ ! -d "wordpress" ]; then
	mkdir wordpress
	cd wordpress
	mv /tmp/wordpress/wp-config.php wp-config.php
	chmod 644 wp-config.php
	sed -i "s/\${DB_NAME}/${DB_NAME}/g; s/\${DB_USER}/${DB_USER}/g; s/\${DB_PASS}/${DB_PASS}/g; s/\${DB_HOST}/${DB_HOST}/g" wp-config.php
	curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp_auth
	sed -i '/##Inception##/r /tmp/wp_auth' wp-config.php
	sed -i '/##Inception##/d' wp-config.php
	rm -rf /tmp/wp_auth

	echo "Downloading wordpress"
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/sbin/wp;
	wp core download --allow-root;

	echo "Setting permissions..."
	find /var/www/wordpress -type d -exec chmod 755 {} +
	find /var/www/wordpress -type f -exec chmod 644 {} +

	chown -R www-data /var/www/wordpress

	echo "Installing wordpress..."
	wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME \
		--admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_MAIL}
	wp user create --allow-root ${WP_USER} ${WP_MAIL} --user_pass=${WP_PASS};
fi
echo "---------------------------End wordpress setup script---------------------------"

/usr/sbin/php-fpm7.4 -F

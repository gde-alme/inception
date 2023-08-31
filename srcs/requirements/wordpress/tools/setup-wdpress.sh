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

# add www.conf
cat > etc/php/7.4/fpm/pool.d/www.conf << EOF
[www]
user = www-data
group = www-data
listen = wordpress:9000
pm = dynamic
pm.start_servers = 6
pm.max_children = 25
pm.min_spare_servers = 2
pm.max_spare_servers = 10
EOF

# create directories and files
mkdir -p /var/www
#sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" "/etc/php/7.4/fpm/pool.d/www.conf";
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;

# if no wp-config.php present create and install wordpress
if [ ! -f /var/www/wp-config.php ]; then
	cd /var/www/
	touch /var/www/wp-config.php
	echo "<?php" > /var/www/wp-config.php
	echo "define( 'DB_NAME', '${DB_NAME}' );" >> /var/www/wp-config.php
	echo "define( 'DB_USER', '${DB_USER}' );" >> /var/www/wp-config.php
	echo "define( 'DB_PASSWORD', '${DB_PASS}' );" >> /var/www/wp-config.php
	echo "define( 'DB_HOST', '${DB_HOST}' );" >> /var/www/wp-config.php
	echo "define( 'DB_CHARSET', 'utf8' );" >> /var/www/wp-config.php
	echo "define( 'DB_COLLATE', '' );" >> /var/www/wp-config.php
	curl https://api.wordpress.org/secret-key/1.1/salt/ > \
	echo >> /var/www/wp-config.php
	echo "define('FS_METHOD','direct');" >> /var/www/wp-config.php
	echo "\$table_prefix = 'wp_';" >> /var/www/wp-config.php
	echo "define( 'WP_DEBUG', true );" >> /var/www/wp-config.php
	echo "if ( ! defined( 'ABSPATH' ) ) {" >> /var/www/wp-config.php
	echo "define( 'ABSPATH', __DIR__ . '/' );}" >> /var/www/wp-config.php
	echo "require_once ABSPATH . 'wp-settings.php';" >> /var/www/wp-config.php
	#echo "?>" >> /var/www/wp-config.php
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/sbin/wp;

	echo "Downloading wordpress"
	wp core download --allow-root;
	chown -R www-data ./*
	chmod -R 775 ./*

	echo "Installing wordpress"
	wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME --admin_user=${DB_ROOT_USER} --admin_password=${DB_PASS} --admin_email=mail@mail.com #--admin_password=${DB_PASS} 
	#wp user create --allow-root ${DB_ROOT_USER} mail@mail.com --user_pass=${DB_ROOT_PASS};
fi


echo "---------------------------End wordpress setup script---------------------------"

php-fpm7.4 -F

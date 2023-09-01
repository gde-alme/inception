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
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;

# if no wp-config.php present create and install wordpress
if [ ! -f /var/www/wp-config.php ]; then
	cd /var/www/
	touch /var/www/wp-config.php
	echo << EOF > /var/www/wp-config.php
"<?php" > /var/www/wp-config.php
"define( 'DB_NAME', '${DB_NAME}' );"
"define( 'DB_USER', '${DB_USER}' );"
define( 'DB_PASSWORD', '${DB_PASS}' );"
"define( 'DB_HOST', '${DB_HOST}' );"
"define( 'DB_CHARSET', 'utf8' );"
"define( 'DB_COLLATE', '' );"
"define('WP_HOME', 'https://gde-alme.42.fr');" 
define('WP_SITEURL', 'https://gde-alme.42.fr');
EOF
	curl https://api.wordpress.org/secret-key/1.1/salt/ > \
	echo >> /var/www/wp-config.php
	echo << EOF >> /var/www/wp-config.php
echo "define('FS_METHOD','direct');"
echo "\$table_prefix = 'wp_';"
echo "define( 'WP_DEBUG', true );"
echo "if ( ! defined( 'ABSPATH' ) ) {"
echo "define( 'ABSPATH', __DIR__ . '/' );}"
echo "require_once ABSPATH . 'wp-settings.php';"
EOF
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

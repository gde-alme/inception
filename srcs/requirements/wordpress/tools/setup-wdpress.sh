sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.owner = /listen.owner = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.group = nobody/listen.group = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /var/www

wget https://wordpress.org/latest.zip
unzip latest.zip
rm latest.zip
cp -rf wordpress/* /var/www/*
rm -rf wordpress

mkdir ~/data
mkdir ~/data/mariadb
mkdir ~/data/wordpress
chmod -R 777 ~/data

touch wp-config.php
echo "<?php" > /var/www/wp-config.php
echo "define( 'DB_NAME', '${DB_NAME}' );" >> /var/www/wp-config.php
echo "define( 'DB_USER', '${DB_USER}' );" >> /var/www/wp-config.php
echo "define( 'DB_PASSWORD', '${DB_PASS}' );" >> /var/www/wp-config.php
echo "define( 'DB_HOST', 'mariadb' );" >> /var/www/wp-config.php
echo "define( 'DB_CHARSET', 'utf8' );" >> /var/www/wp-config.php
echo "define( 'DB_COLLATE', '' );" >> /var/www/wp-config.php
echo "define('FS_METHOD','direct');" >> /var/www/wp-config.php
echo "\$table_prefix = 'wp_';" >> /var/www/wp-config.php
echo "define( 'WP_DEBUG', false );" >> /var/www/wp-config.php
echo "if ( ! defined( 'ABSPATH' ) ) {" >> /var/www/wp-config.php
echo "define( 'ABSPATH', __DIR__ . '/' );}" >> /var/www/wp-config.php
echo "require_once ABSPATH . 'wp-settings.php';" >> /var/www/wp-config.php

chown -R www-data:www-data /var/www

chmod -R 777 /var/www

#chmod -R 777 /run/php

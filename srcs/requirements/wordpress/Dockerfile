FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ARG SERVER_NAME
ARG WP_ADMIN_USER
ARG WP_ADMIN_PASS
ARG WP_ADMIN_MAIL
ARG WP_USER
ARG WP_MAIL
ARG WP_PASS

RUN apt update && apt upgrade -y && apt install -y \
    php \
     php-fpm \
    php-mysqli \
    php-json \
    php-curl \
    php-dom \
    php-exif \
    php-phar \
    php-fileinfo \
    php-mbstring \
    php-xml \
    php-zip \
    #php8.2-redis \
    wget \
    unzip \
    iputils-ping

#RUN sed -i 's/listen = \/var\/run\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
#RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf
#RUN sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
#RUN mkdir -p /run/php/

#WORKDIR /var/www

#RUN wget https://wordpress.org/latest.zip
#RUN unzip latest.zip
#RUN rm latest.zip
#RUN cp -rf wordpress/* .
#RUN rm -rf wordpress
RUN mkdir ~/data
RUN mkdir ~/data/mariadb
RUN mkdir ~/data/wordpress
RUN chmod -R 777 ~/data

RUN mkdir -p /tmp/wordpress
COPY ./conf/wp-config.php /tmp/wordpress/
#RUN touch /var/www/wp-config.php
#RUN echo "<?php" > /var/www/wp-config.php
#RUN echo "define( 'DB_NAME', '${DB_NAME}' );" >> /var/www/wp-config.php
#RUN echo "define( 'DB_USER', '${DB_USER}' );" >> /var/www/wp-config.php
#RUN echo "define( 'DB_PASSWORD', '${DB_PASS}' );" >> /var/www/wp-config.php
#RUN echo "define( 'DB_HOST', 'mariadb' );" >> /var/www/wp-config.php
#RUN echo "define( 'DB_CHARSET', 'utf8' );" >> /var/www/wp-config.php
#RUN echo "define( 'DB_COLLATE', '' );" >> /var/www/wp-config.php
#RUN echo "define('FS_METHOD','direct');" >> /var/www/wp-config.php
#RUN echo "\$table_prefix = 'wp_';" >> /var/www/wp-config.php
#RUN echo "define( 'WP_DEBUG', false );" >> /var/www/wp-config.php
#RUN echo "if ( ! defined( 'ABSPATH' ) ) {" >> /var/www/wp-config.php
#RUN echo "define( 'ABSPATH', __DIR__ . '/' );}" >> /var/www/wp-config.php
#RUN echo "require_once ABSPATH . 'wp-settings.php';" >> /var/www/wp-config.php

#RUN echo "Downloading wordpress"
#RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
#RUN chmod +x wp-cli.phar; 
#RUN mv wp-cli.phar /usr/local/sbin/wp;
#RUN wp core download --allow-root;

#RUN chown -R www-data:www-data /var/www
#RUN chmod -R 755 /var/www

#RUN echo "Installing wordpress..."
#RUN wp core install --allow-root --url=$SERVER_NAME --title=$DB_NAME \
#	--admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} \
#	--admin_email=${WP_ADMIN_MAIL}
#RUN wp user create --allow-root ${WP_USER} ${WP_MAIL} --user_pass=${WP_PASS};

COPY ./tools/setup-wdpress.sh /tmp/wordpress/
ENTRYPOINT ["bash", "/tmp/wordpress/setup-wdpress.sh", "-F"]

FROM debian:buster

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

RUN apt update && apt upgrade && apt install -y \
    php7.3 \
    php7.3-fpm \
    php7.3-mysqli \
    php7.3-json \
    php7.3-curl \
    php7.3-dom \
    php7.3-exif \
    php7.3-fileinfo \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    wget \
    unzip

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir ~/data
RUN mkdir ~/data/mariadb
RUN mkdir ~/data/wordpress
RUN chmod -R 777 ~/data
RUN touch /var/www/wp-config.php
RUN echo "<?php" > /var/www/wp-config.php
RUN echo "define( 'DB_NAME', '${DB_NAME}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_USER', '${DB_USER}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_PASS', '${DB_PASS}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_HOST', 'mariadb' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_CHARSET', 'utf8' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_COLLATE', '' );" >> /var/www/wp-config.php
RUN echo "define('FS_METHOD','direct');" >> /var/www/wp-config.php
RUN echo "\$table_prefix = 'wp_';" >> /var/www/wp-config.php
RUN echo "define( 'WP_DEBUG', false );" >> /var/www/wp-config.php
RUN echo "if ( ! defined( 'ABSPATH' ) ) {" >> /var/www/wp-config.php
RUN echo "define( 'ABSPATH', __DIR__ . '/' );}" >> /var/www/wp-config.php
RUN echo "require_once ABSPATH . 'wp-settings.php';" >> /var/www/wp-config.php
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

COPY ./tools/ola.sh /tmp/ola.sh
RUN chmod +x /tmp/ola.sh 
ENTRYPOINT ["sh", "/tmp/ola.sh"]


FROM alpine:3.17
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
RUN apk update && apk upgrade && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-phar \
    php81-fileinfo \
    php81-mbstring \
    php81-openssl \
    php81-xml \
    php81-zip \
    php81-redis \
    wget \
    unzip

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php81/php-fpm.d/www.conf
RUN sed -i 's/;listen.owner = nobody/listen.owner = nobody/g' /etc/php81/php-fpm.d/www.conf
RUN sed -i 's/;listen.group = nobody/listen.group = nobody/g' /etc/php81/php-fpm.d/www.conf
RUN mkdir -p /var/www
RUN mkdir ~/data
RUN mkdir ~/data/mariadb
RUN mkdir ~/data/wordpress
RUN chmod -R 777 ~/data
RUN touch /var/www/wp-config.php
RUN echo "<?php" > /var/www/wp-config.php
RUN echo "define( 'DB_NAME', '${DB_NAME}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_USER', '${DB_USER}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_PASSWORD', '${DB_PASS}' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_HOST', 'mariadb' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_CHARSET', 'utf8' );" >> /var/www/wp-config.php
RUN echo "define( 'DB_COLLATE', '' );" >> /var/www/wp-config.php
RUN echo "define('FS_METHOD','direct');" >> /var/www/wp-config.php
RUN echo "\$table_prefix = 'wp_';" >> /var/www/wp-config.php
RUN echo "define( 'WP_DEBUG', false );" >> /var/www/wp-config.php
RUN echo "if ( ! defined( 'ABSPATH' ) ) {" >> /var/www/wp-config.php
RUN echo "define( 'ABSPATH', __DIR__ . '/' );}" >> /var/www/wp-config.php
RUN echo "require_once ABSPATH . 'wp-settings.php';" >> /var/www/wp-config.php
RUN chown -R nobody:nobody /var/www
RUN chmod -R 755 /var/www

COPY ./tools/ola.sh /tmp/ola.sh
RUN chmod +x /tmp/ola.sh 
ENTRYPOINT ["sh", "/tmp/ola.sh"]

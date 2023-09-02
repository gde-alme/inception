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
    php7.3-redis \
    wget \
    unzip

#RUN sed -i 's/listen = \/var\/run\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
#RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf
#RUN sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/7.3/fpm/pool.d/www.conf

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN mkdir -p /run/php/

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip
RUN rm latest.zip
RUN cp -rf wordpress/* .
RUN rm -rf wordpress
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
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

ENTRYPOINT ["php-fpm7.3", "-F"]

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

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir ~/data
RUN mkdir ~/data/mariadb
RUN mkdir ~/data/wordpress
RUN chmod -R 777 ~/data

RUN mkdir -p /tmp/wordpress
COPY ./conf/wp-config.php /tmp/wordpress/

COPY ./tools/setup-wdpress.sh /tmp/wordpress/
ENTRYPOINT ["bash", "/tmp/wordpress/setup-wdpress.sh", "-F"]

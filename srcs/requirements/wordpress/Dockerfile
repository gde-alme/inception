FROM debian:bullseye

RUN apt update > /dev/null 2>&1 && apt upgrade -y> /dev/null 2>&1 && apt install -y \
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
    wget \
    curl \
    unzip \
    iputils-ping > /dev/null 2>&1

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /tmp/wordpress
COPY ./conf/wp-config.php /tmp/wordpress/

COPY ./tools/setup-wdpress.sh /tmp/wordpress/
ENTRYPOINT ["bash", "/tmp/wordpress/setup-wdpress.sh", "-F"]

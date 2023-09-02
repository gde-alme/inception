FROM debian:bullseye

ARG SERVER_NAME

ARG DB_NAME
ARG DB_HOST
ARG DB_USER
ARG DB_PASS

ARG WP_ADMIN_USER
ARG WP_ADMIN_PASS
ARG WP_ADMIN_MAIL
ARG WP_USER
ARG WP_PASS
ARG WP_MAIL

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget curl unzip \
	php \
	php-cgi \
	php-cli \
	php-fpm \
	php-json \
	php-mysql \
	php-zip \
	php-common \
	php-curl \
	php-xml \
	php-pear \
	php-bcmath \
	default-mysql-client \
	php-pdo \
	php-gd \
	php-mbstring \
	sendmail \
	iputils-ping \
	&& rm -rf /var/lib/apt/lists/

# add php-fpm config
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# add wp-config
COPY ./conf/wp-config.php /var/www/wp-config-default.php

# add new index file
COPY ./conf/index.php /tmp/

COPY ./tools/setup-wdpress.sh /tmp/
RUN chmod +x /tmp/setup-wdpress.sh;

ENTRYPOINT ["bash", "/tmp/setup-wdpress.sh"]

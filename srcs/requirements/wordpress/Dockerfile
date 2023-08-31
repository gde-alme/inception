FROM debian:bullseye

ARG SERVER_NAME
ARG DB_NAME
ARG DB_HOST
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_USER
ARG DB_ROOT_PASS


RUN apt-get update && apt-get upgrade -y && apt-get install -y wget curl unzip \
	php \
	php-cgi \
	php-fpm \
	php-mysql \
	default-mysql-client \
	php-pdo \
	php-gd \
	php-cli \
	php-mbstring \
	sendmail \
	iputils-ping \
	&& rm -rf /var/lib/apt/lists/

RUN mkdir -p /run/php

COPY ./tools/setup-wdpress.sh ./
RUN chmod +x ./setup-wdpress.sh ; bash ./setup-wdpress.sh ; rm ./setup-wdpress.sh

CMD ["php-fpm7.4", "-F"]

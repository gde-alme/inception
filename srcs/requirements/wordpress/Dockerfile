FROM debian:11.7

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget curl unzip \
	php \
	php-cgi \
	php-fpm \
	php-mysql \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	&& rm -rf /var/lib/apt/lists/

RUN mkdir -p /run/php

COPY ./tools/setup-wdpress.sh ./
RUN chmod +x ./setup-wdpress.sh ; bash ./setup-wdpress.sh ; rm ./setup-wdpress.sh

CMD ["php-fpm7.4", "-F"]

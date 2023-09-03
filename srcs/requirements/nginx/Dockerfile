FROM debian:bullseye

ARG SERVER_NAME

RUN apt-get update > /dev/null 2>&1 && apt-get upgrade -y > /dev/null 2>&1 ; apt-get install -y nginx > /dev/null 2>&1

COPY ./conf/default /etc/nginx/nginx.conf
COPY ./conf/default /etc/nginx/conf.d/nginx.conf

RUN sed -i "s/\${SERVER_NAME}/$SERVER_NAME/g" /etc/nginx/nginx.conf

COPY ./tools/* /etc/nginx/ssl/

ENTRYPOINT ["nginx", "-g", "daemon off;"]

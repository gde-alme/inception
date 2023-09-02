FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y ; apt-get install -y nginx

COPY ./conf/default /etc/nginx/nginx.conf

COPY ./tools/* /etc/nginx/ssl/

ENTRYPOINT ["nginx", "-g", "daemon off;"]

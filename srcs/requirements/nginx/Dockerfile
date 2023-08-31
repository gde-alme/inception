FROM debian:11.7

RUN apt-get update && apt-get upgrade -y ; apt-get install -y nginx

#COPY ./conf/default /etc/nginx/sites-available/wordpress
COPY ./conf/default /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]

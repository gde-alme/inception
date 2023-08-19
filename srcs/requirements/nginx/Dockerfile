FROM debian:11.7

RUN apt-get update && apt-get upgrade -y ; apt-get install -y nginx

COPY ./conf/default.conf /etc/nginx/sites-available/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]

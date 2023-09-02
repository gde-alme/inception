FROM debian:bullseye

ARG SERVER_NAME

RUN apt-get update && apt-get upgrade -y ; apt-get install -y nginx

COPY ./conf/default /etc/nginx/nginx.conf
COPY ./conf/default /etc/nginx/conf.d/nginx.conf

RUN echo
RUN sed -i "s/\${SERVER_NAME}/$SERVER_NAME/g" /etc/nginx/nginx.conf

COPY ./tools/* /etc/nginx/ssl/

ENTRYPOINT ["nginx", "-g", "daemon off;"]

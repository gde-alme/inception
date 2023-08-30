FROM debian:11.7

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

RUN apt-get update && apt-get upgrade && \
    apt-get install -y curl mariadb-server mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/setup-mariadb.sh ./
RUN chmod +x ./setup-mariadb.sh
RUN ./setup-mariadb.sh

CMD ["mysqld", "--user=root", "--init-file=/docker-entrypoint-initdb.d/init.sql"]

#RUN cat /etc/mysql/mariadb.conf.d/50-server.cnf

#EXPOSE 3306

#COPY ./tools/setup-mariadb.sh /tmp/setup-mariadb.sh

#RUN chmod +x /tmp/setup-mariadb.sh ; \
#    bash /tmp/setup-mariadb.sh ; \
#    rm /tmp/setup-mariadb.sh

#USER mysql

#CMD ["/usr/sbin/mysqld", "--skip-log-error"]

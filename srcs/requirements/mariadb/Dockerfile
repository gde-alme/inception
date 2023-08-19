FROM debian:11.7

RUN apt-get update && \
    apt-get install -y curl mariadb-server  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -v -LJO https://raw.githubusercontent.com/sismics/docker-mariadb/master/etc/mysql/mariadb.conf.d/50-server.cnf ; \
    cp ./50-server.cnf /etc/mysql/mariadb.conf.d/ ; \
    rm ./50-server.cnf

EXPOSE 3306

COPY ./tools/setup-mariadb.sh /tmp/setup-mariadb.sh

RUN chmod +x /tmp/setup-mariadb.sh ; \
    bash /tmp/setup-mariadb.sh ; \
    rm /tmp/setup-mariadb.sh

USER mysql

CMD ["/usr/sbin/mysqld", "--skip-log-error"]

FROM debian:bullseye

RUN apt-get update -qq  > /dev/null 2>&1 && \
    apt-get install -y -qq mariadb-server mariadb-client> /dev/null 2>&1 && \
    apt-get clean -qq> /dev/null 2>&1 && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup-mariadb.sh /tmp/
RUN chmod +x /tmp/setup-mariadb.sh

ENTRYPOINT ["sh", "/tmp/setup-mariadb.sh"]

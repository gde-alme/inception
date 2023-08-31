FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT

RUN apt-get update -qq && \
    apt-get install -y -qq mariadb-server mariadb-client && \
    apt-get clean -qq && \
    rm -rf /var/lib/apt/lists/*


COPY ./tools/setup-mariadb.sh /tmp/
RUN chmod +x /tmp/setup-mariadb.sh

ENTRYPOINT ["sh", "/tmp/setup-mariadb.sh"]

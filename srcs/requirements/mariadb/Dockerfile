FROM debian:11

ARG	DB_NAME
ARG	DB_USER
ARG	DB_PASS

RUN apt update && apt install -y mariadb-server

RUN mkdir /var/run/mysql 
RUN chmod 777 /var/run/mysql

RUN mkdir /var/run/mysqld
RUN chmod 777 /var/run/mysqld

RUN mkdir -p /etc/my.cnf.d/

RUN echo '[mysqld]' > /etc/my.cnf.d/docker.cnf
RUN echo 'skip-host-cache' >> /etc/my.cnf.d/docker.cnf
RUN echo 'skip-name-resolve' >> /etc/my.cnf.d/docker.cnf
RUN echo 'bind-address=0.0.0.0' >> /etc/my.cnf.d/docker.cnf

RUN if [ -f /etc/my.cnf.d/mariadb-server.cnf ]; then \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf; \
    fi

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306
COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh
USER mysql
ENTRYPOINT ["/usr/bin/mysqld"]
CMD ["/usr/bin/mysqld", "--skip-log-error"]


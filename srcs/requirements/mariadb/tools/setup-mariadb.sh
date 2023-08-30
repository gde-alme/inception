#!/bin/bash

#chown -R mysql:mysql /var/lib/mysql
chmod 777 /var/lib/mysql

# Create directories and set permissions
mkdir -p /var/run/mysqld
chmod 777 /var/run/mysqld

# Create MySQL config file
touch tmp.txt
echo "[mysqld]" > tmp.txt
echo "bind-address = 0.0.0.0" >> tmp.txt
mv tmp.txt /etc/mysql/mariadb.conf.d/99-docker.cnf

# Initialize MariaDB Database
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=root --datadir=/var/lib/mysql
else
    echo "MySQL database already initialized. Skipping mysql_install_db."
fi

# Create SQL init file
mkdir -p /docker-entrypoint-initdb.d
touch /docker-entrypoint-initdb.d/init.sql
echo "FLUSH PRIVILEGES;" >> /docker-entrypoint-initdb.d/init.sql
echo "DELETE FROM mysql.user WHERE User='';" >> /docker-entrypoint-initdb.d/init.sql
echo "DROP DATABASE IF EXISTS test;" >> /docker-entrypoint-initdb.d/init.sql
echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" >> /docker-entrypoint-initdb.d/init.sql
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> /docker-entrypoint-initdb.d/init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';" >> /docker-entrypoint-initdb.d/init.sql
echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" >> /docker-entrypoint-initdb.d/init.sql
echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';" >> /docker-entrypoint-initdb.d/init.sql
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" >> /docker-entrypoint-initdb.d/init.sql
echo "FLUSH PRIVILEGES;" >> /docker-entrypoint-initdb.d/init.sql
echo "USE ${DB_NAME};" >> /docker-entrypoint-initdb.d/init.sql


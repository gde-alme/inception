#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$DB_USER'@'%' IDENTIFIED by '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
REVOKE ALL PRIVILEGES ON *.* FROM 'root'@'localhost';
DROP USER 'root'@'localhost';
FLUSH PRIVILEGES;
EOF
	# run init.sql
	/usr/sbin/mysqld --user=mysql --bootstrap < $tfile
	rm -f $tfile
fi

exec /usr/sbin/mysqld --user=mysql --console

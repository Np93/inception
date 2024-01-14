#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
else
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
#	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --datadir=/var/lib/mysql > /dev/null
#	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tfile=`mktemp`
#	if [ ! -f "$tfile" ]; then
#		return 1
#	fi

	
	 cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_PWD');
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT';
DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';
CREATE DATABASE $WP_DATABASE_NAME;
CREATE USER '$WP_DATABASE_USR'@'%' IDENTIFIED by '$WP_DATABASE_PWD';
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';
FLUSH PRIVILEGES;
EOF
	# run init.sql
	/usr/bin/mysqld --user=mysql --bootstrap --lower_case_table_names=2 < $tfile
#	rm -f $tfile
fi

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --lower_case_table_names=2

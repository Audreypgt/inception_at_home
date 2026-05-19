#!/bin/bash

DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mkdir -p run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
# modifies root user's password when connected through host machine (local host) as opposed to 'root'@'%', % meaning
# everywhere
mysql -e "FLUSH PRIVILEGES;" # apply changes
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown # with this line and the next == reboot
# OLD: mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown # connect as root

exec mysqld # exec kills the bash script and replaces it by mysql which will take its PID and keep running

# \' \' used to escape database names or tables (useful if it contains special characters) or any of these
# so-called "identifiers" objects
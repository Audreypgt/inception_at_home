#!/bin/bash

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# modifies root user's password when connected through host machine (local host) as opposed to 'root'@'%', % meaning
# everywhere
mysql -e "FLUSH PRIVILEGES;" # apply changes
mysqladmin -u root shutdown # with this line and the next == reboot
# OLD: mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown # connect as root

exec mysqld # exec kills the bash script and replaces it by mysql which will take its PID and keep running

# \' \' used to escape database names or tables (useful if it contains special characters) or any of these
# so-called "identifiers" objects
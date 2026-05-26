#!/bin/bash

# DB_NAME=$(cat /run/secrets/db_name)
# DB_USER=$(cat /run/secrets/db_user)
# DB_PASSWORD=$(cat /run/secrets/db_password)
# DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# debug : get commands output in terminal
# set -x

# stops immediately if exit other than 0
set -e

mysqld_safe &
# runs the command in the background so script can continue

# wait for server to be ready before running mariadb commands
until mariadb-admin ping --silent; do
    sleep 1
done

mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES; # apply changes
EOF

mariadb-admin -u root -p${DB_ROOT_PASSWORD} shutdown # with this line and the next == reboot
exec mysqld_safe # exec kills the bash script and replaces it by mysql which will take its PID and keep running

# alter user modifies root user's password when connected through host machine (local host) as opposed to 'root'@'%', % meaning
# everywhere
# \' \' used to escape database names or tables (useful if it contains special characters) or any of these
# so-called "identifiers" objects
# EOF allow shell to read all commands at the same time, this prevents me getting error "Access denied for user 'root'@'localhost' (using password: NO)"
# since the alter user command changes the root password and would need me to authenticate again
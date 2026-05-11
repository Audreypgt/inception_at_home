FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y && mariadb-client

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# config file

CMD ["/bin/bash", "/tools/mariadb_setup.sh"]
# to execute the script we made to create our database

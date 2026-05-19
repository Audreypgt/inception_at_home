FROM debian:bookworm

RUN apt-get update -y && apt-get install -y mariadb-server mariadb-client
RUN --mount=type=secret,id=db_password,id=db_root_password


COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# config file

CMD ["/bin/bash", "/tools/mariadb_setup.sh"]
# to execute the script we made to create our database

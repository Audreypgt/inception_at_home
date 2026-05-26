FROM debian:bookworm

RUN apt-get update -y && apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# copy script to bin folder to be able to execute it
COPY ./tools/mariadb_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]

# CMD ["mysqld", "--bind-address=0.0.0.0"]
# command to launch mariadb and enable it to listen globally
# useless since the bash script does it too
FROM debian:bookworm

RUN apt-get update -y && apt-get install -y php php8.2-fpm wget && rm -rf /var/lib/apt/lists/*
# wget used for config script

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
    # make the file executable and move it to somewhere in your PATH to be able to use command `wp` instead of `php wp-cli.phar`

RUN mkdir -p /var/www/wordpress
RUN cd /var/www/ && wp core download --allow-root
# check that it creates a folder called wordpress
# downloads wordpress files

RUN chown -R root:root /var/www/wordpress

# RUN --mount=type=secret,id=db_password,id=db_root_password

# COPY conf/php.ini /etc/php/php.ini
# to add to conf and to modify when its installed and i get the original one and check path for
# php in container

ENTRYPOINT ["/bin/bash", "/tools/config_script.sh"]

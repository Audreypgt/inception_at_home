FROM debian:bookworm

RUN apt-get update -y && apt-get install -y php php-fpm php-mysql wget sudo && rm -rf /var/lib/apt/lists/*
# wget used for config script

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp
# make the file executable and move it to bin folder to execute it (script to be able to use command `wp`
# instead of `php wp-cli.phar`)

# Wordpress folder creation
RUN mkdir -p /var/www/wordpress \
    && chown -R www-data:www-data /var/www/wordpress \
    && chmod 775 /var/www/wordpress
RUN cd /var/www/wordpress && sudo -u www-data wp core download
# check that it creates a folder called wordpress
# downloads wordpress files

EXPOSE 9000

# CMD ["/usr/sbin/php-fpm8.2", "-F"]

# RUN --mount=type=secret,id=db_password,id=db_root_password

ENTRYPOINT ["/bin/bash", "/var/www/wordpress/config_script.sh"]
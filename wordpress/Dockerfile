FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install php php-mysql php-fpm wget
# wget used for config script

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && chmod +x wp-cli.phar \
    && sudo mv wp-cli.phar /usr/local/bin/wp
    # make the file executable and move it to somewhere in your PATH to be able to use command `wp` instead of `php wp-cli.phar`

RUN cd /var/www/ wp core download
# check that it creates a folder called wordpress
# downloads wordpress files

RUN chown -R root:root /var/www/wordpress

# COPY conf/php.ini /etc/php/php.ini
# to add to conf and to modify when its installed and i get the original one and check path for
# php in container

ENTRYPOINT ["/bin/bash", "/tools/config_script.sh"]

RUN /usr/sbin/php-fpm -F
# starts php
#check path cause there is a folder called by the version like /usr/sbin/php-fpm7.3 -F
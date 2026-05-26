# script to create wp-config-sample.php (rename, inject variables (database name, user...), generate security keys)
# we make a script because apparently, the file is created at every start of the container

sleep 10
# make sure database is ready

if [ ! -f /var/www/wordpress/wp-config.php ]; then
wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --path=/var/www/wordpress
wp core install --url "apeuget.42.fr" --title="apeuget42" --admin_user=$DB_USER_ADMIN --admin_password=$DB_PASSWORD_ADMIN --admin_email="admin@apeuget.42.fr"
# installs wp: creates the wordpress tables in the database (it's not the same thing as creating the database as it puts data in an already existing db i think)
wp user create $DB_SECOND_USER --role=contributor --user_pass=$DB_SECOND_PASSWORD
    # creates second user

fi

exec /usr/sbin/php-fpm8.2 -F

!!!!!! wp-config.php file not created and database errors (docker logs)


# starts php
#check path cause there is a folder called by the version like /usr/sbin/php-fpm7.3 -F

# we can modify the example script given by wordpress:
# https://kaiten.design/how-to-automate-wordpress-and-wp-config-php-creation/
# or use wp-cli to create one, here we used wp-cli:
# https://make.wordpress.org/cli/handbook/guides/quick-start/


# really complex and thorough version to use one day maybe who knows
# https://blog.noah.hearle.com/wordpress-installer/
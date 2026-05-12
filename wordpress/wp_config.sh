# script to create wp-config-sample.php (rename, inject variables (database name, user...), generate security keys)
# we make a script because apparently, the file is created at every start of the container

sleep 10
# make sure database is ready

if [ ! -f /var/www/wordpress/wp-config.php ]; then
# verify path
    wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path /var/www/wordpress
    wp core install --url "apeuget.42.fr" --title"apeuget42" --admin_user=$MYSQL_USER_ADMIN --admin_password=$MYSQL_PASSWORD_ADMIN
    # installs wp: creates the wordpress tables in the database (it's not the same thing as creating the database as it puts data in an already existing db i think)
    wp user create $MYSQL_SECOND_USER --role=contributor --user_pass=$MYSQL_SECOND_PASSWORD
    # creates second user


# we can modify the example script given by wordpress or use wp-cli to create one, here we used wp-cli
https://kaiten.design/how-to-automate-wordpress-and-wp-config-php-creation/
https://make.wordpress.org/cli/handbook/guides/quick-start/


# really complex and thorough version to use one day maybe who knows
https://blog.noah.hearle.com/wordpress-installer/
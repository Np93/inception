#!/bin/sh

#while ! mariadb -h$MYSQL_HOST &>/dev/null; do
sleep 5
#done

if [ ! -f /var/www/wordpress/wp-config.php ]; then


    wp core download --allow-root

    wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --allow-root --path='/var/www/wordpress' >> log.txt

    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root --path='/var/www/wordpress' >> log.txt

    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root --path='/var/www/wordpress' >> log.txt

    wp theme install neve --activate --allow-root --path='/var/www/wordpress' >> log.txt

    wp plugin update --all --allow-root --path='/var/www/wordpress' >> log.txt


fi


echo "Wordpress started on :9000"
/usr/sbin/php-fpm8 -F -R
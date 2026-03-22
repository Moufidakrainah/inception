#!/bin/bash
# Récupère les mots de passe depuis les secrets Docker
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
# Attend que MariaDB soit accessible
while ! mysqladmin ping -h mariadb --silent; do
    sleep 1
done
# Si WordPress n'est pas encore installé
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # Télécharge les fichiers WordPress
    wp core download --path=/var/www/wordpress --allow-root
    # Crée wp-config.php avec les infos de connexion à la DB
    wp config create \
        --path=/var/www/wordpress \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=${MYSQL_HOST} \
        --allow-root
    # Installe WordPress
    wp core install \
        --path=/var/www/wordpress \
        --url=${DOMAIN_NAME} \
        --title="Mon Site" \
        --admin_user=${WP_ADMIN} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    # Crée le deuxième utilisateur (non-admin)
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --path=/var/www/wordpress \
        --allow-root
fi
# Met à jour les URLs du site
wp option update siteurl "https://mobougri.42.fr" --allow-root --path=/var/www/wordpress
    wp option update home "https://mobougri.42.fr" --allow-root --path=/var/www/wordpress
# Lance PHP-FPM en PID 1 (foreground)
exec php-fpm8.2 -F

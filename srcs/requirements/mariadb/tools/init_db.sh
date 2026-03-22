#!/bin/bash
# Récupère les mots de passe depuis les secrets Docker
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
# Vérifie si la base de données existe déjà (persistance)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi
# Démarre MariaDB en arrière-plan temporairement
mysqld --user=mysql --skip-networking &
# Attend que MariaDB soit prêt
while ! mysqladmin -h localhost ping --silent; do
    sleep 1
done
# Crée la base de données et l'utilisateur
mysql -h localhost -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
DROP USER IF EXISTS '${MYSQL_USER}'@'%';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
# Arrête MariaDB temporaire
mysqladmin -h localhost -u root -p${MYSQL_ROOT_PASSWORD} shutdown
# Relance MariaDB en PID 1 (foreground)
exec mysqld --user=mysql

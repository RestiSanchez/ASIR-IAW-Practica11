#!/bin/bash
set -x

#VARIABLES
BD_ROOT_PASSWD=root
DB_NAME=wordpress_db
DB_USER=wordpress_user
DB_PASSWORD=wordpress_password
IP_URL=

# Actualizamos la lista de paquetes
apt update

#Actualizamos los paquete
apt upgrade -y

# Instalamos el servidor web Apache
apt install apache2 -y

# Instalamos el MySQL Server
apt install mysql-server -y

# Instalamos los módulos de PHP
apt install php libapache2-mod-php php-mysql -y

#Descargamos el archivo wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Asignamos permisos de ejecución
chmod +x wp-cli.phar

#Movemos el archivo al directorio /usr/local/bin
mv wp-cli.phar /usr/local/bin/wp

# ---- Instalacion de wordpress - WP-CLI ---- #


#Nos situamos en el directorio donde vamos a realizar la instalación.
cd /var/www/html

#Descargamos el código fuente de Wordpress
wp core download --locale=es_ES --allow-root

#Creamos la base de datos
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
mysql -u root <<< "CREATE USER $DB_USER@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'localhost';"
mysql -u root <<< "FLUSH PRIVILEGES;"

#Creamos el archivo de configuración
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

#Instalamos Wordpress
wp core install --url=http://$IP_URL --title="IAW" --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

#Eliminamos el index.html 
cd /var/www/html
rm -rf index.html

#Reiniciamos apache
systemctl restart apache2.service

# ---- Personalización de wordpress  ---- #

# Actualizamos los plugins
wp plugin update  --path=/var/www/html/ --all --allow-root

#Actualizamos los temas
wp theme update --path=/var/www/html/ --all --allow-root

#Instalar y activar plugin
wp plugin install --path=/var/www/html/ contact-form-7 --activate --allow-root
wp plugin install --path=/var/www/html/ jetpack --activate --allow-root

#Activar tema
wp theme install --path=/var/www/html/ oceanwp --activate --allow-root
wp theme activate oceanwp --path=/var/www/html/ --allow-root

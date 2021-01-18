#! /bin/bash

# Marcamos los pasos en la ejecución

set -x

# Actualizamos lista de paquetes

apt update 

# Actualizamos los paquetes

apt upgrade -y

# Instalamos el servidor web Apache

apt install apache2 -y

# Instalamos MySQL-Server

apt install mysql-server -y

# Instalamos los modulos de PHP

apt install php libapache2-mod-php php-mysql -y

######################
#   Variables        #
######################

BD_NOMBRE=wpiaw
BD_USUARIO=resti
IP_FRONT=localhost
BD_PASS=root
URL=http://
# Configuración de base de datos

mysql -u root <<< "DROP DATABASE IF EXISTS $BD_NOMBRE;"
mysql -u root <<<"CREATE DATABASE $BD_NOMBRE;"
mysql -u root <<<"DROP USER IF EXISTS $BD_USUARIO@$IP_FRONT;"
mysql -u root <<<"CREATE USER $BD_USUARIO@$IP_FRONT IDENTIFIED BY '$BD_PASS';"
mysql -u root <<<"GRANT ALL PRIVILEGES ON $BD_NOMBRE.* TO $BD_USUARIO@$IP_FRONT;"
mysql -u root <<<"FLUSH PRIVILEGES;"

# Nos descargamos el cliente de Wordpress
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Damos permisos de ejecución
chmod +x wp-cli.phar

# Lo movemos a la ruta indicada
mv wp-cli.phar /usr/local/bin/wp

# Cambiamos al directorio de instalación
cd /var/www/html
rm -rf index.html
# Descargamos el Wordpress en español
wp core download --locale=es_ES --allow-root

# Crear el archivo de configuración
wp config create --dbname=$BD_NOMBRE --dbuser=$BD_USUARIO --dbpass=$BD_PASS --allow-root

# Instalamos el cliente de Wordpress
wp core install --url=$URL --title="IAW_RESTI" --admin_user=resti --admin_password=root --admin_email=test@test.com --allow-root

cd /home/ubuntu/

# Descargamos los plugins de wordpress


wget https://downloads.wordpress.org/plugin/wp-super-cache.1.7.1.zip
wget https://downloads.wordpress.org/plugin/jetpack.9.3.1.zip

wp plugin install wp-super-cache.1.7.1.zip --allow-root --activate --force --path=/var/www/html/

wp plugin install jetpack.9.3.1.zip --allow-root --force --activate --path=/var/www/html/


# Actualizamos los plugins

#wp plugin update --all --allow-root

# Actualizamos los themes

#wp theme update --all --allow-root

# Actualizamos el core de wordpress

#wp core update --allow-root




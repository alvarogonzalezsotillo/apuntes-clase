sudo docker kill php-ajedrez mysql-ajedrez
sudo docker rm php-ajedrez mysql-ajedrez


sudo docker run -d \
  --name php-ajedrez \
  -p 8080:80 \
  -v "$PWD":/var/www/html \
  php:8.2-apache \
  bash -c "docker-php-ext-install mysqli && apache2-foreground"

sudo docker run -d \
  --name mysql-ajedrez \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=ajedrez \
  -p 3306:3306 \
  mysql:8 



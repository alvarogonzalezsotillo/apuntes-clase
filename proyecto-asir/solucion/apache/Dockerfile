FROM php:8.2-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim openssh-server \
    && docker-php-ext-install mysqli pdo_mysql \
    && a2enmod rewrite \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && mkdir -p /run/sshd \
    && echo 'root:asir' | chpasswd

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80 22
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
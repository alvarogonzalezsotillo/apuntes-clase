FROM php:8.2-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim openssh-server libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install mysqli pdo_mysql ldap \
    && a2enmod rewrite \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && mkdir -p /run/sshd \
    && echo 'root:asir' | chpasswd

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80 22
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

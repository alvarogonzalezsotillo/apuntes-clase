FROM mysql:8.4

RUN microdnf makecache \
    && microdnf install openssh-server vim \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && mkdir -p /run/sshd \
    && echo 'root:asir' | chpasswd

COPY entrypoint-ssh.sh /usr/local/bin/entrypoint-ssh.sh
RUN chmod +x /usr/local/bin/entrypoint-ssh.sh

EXPOSE 3306 22
ENTRYPOINT ["/usr/local/bin/entrypoint-ssh.sh"]
CMD ["mysqld"]

FROM mariadb:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    iptables \
    iproute2 \
    net-tools \
    dnsutils \
    iputils-ping \
    curl \
    wget \
    tcpdump \
    traceroute \
    procps \
    && rm -rf /var/lib/apt/lists/*

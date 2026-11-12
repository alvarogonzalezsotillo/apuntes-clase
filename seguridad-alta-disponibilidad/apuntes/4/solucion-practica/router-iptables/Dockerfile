FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

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

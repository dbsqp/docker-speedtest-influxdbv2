ARG ARCH=

# Pull base image
FROM ubuntu:latest

# Labels
LABEL MAINTAINER="https://github.com/dbsqp/"

# Setup external package-sources
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    python3-virtualenv \
    iputils-ping\
    --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    tzdata && \
    curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash && \
    apt-get update && apt-get install speedtest && \
    rm -rf /var/lib/apt/lists/* 

# RUN pip install setuptools
RUN pip3 install pytz influxdb-client
#datetime json os subprocess time socket sys

# Environment vars
ENV PYTHONIOENCODING=utf-8

# Copy files
ADD speedtest.py /
ADD get.sh /

# Run
CMD ["/bin/bash","/get.sh"]

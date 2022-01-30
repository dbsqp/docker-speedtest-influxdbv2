ARG ARCH=

# Pull base image
FROM ubuntu:latest

# Labels
LABEL MAINTAINER="https://github.com/dbsqp/"

# Setup external package-sources
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg2 \
    apt-utils \
    --no-install-recommends

RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash
RUN apt-get update && apt-get install speedtest --no-install-recommends
    
#RUN apt-get update && apt-get install -y \
#    python3 \
#    python3-dev \
#    python3-setuptools \
#    python3-pip \
#    python3-virtualenv \
#    curl \
#    iputils-ping\
#    ca-certificates \
#    gnupg2 \
#    tzdata --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/* 
    


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

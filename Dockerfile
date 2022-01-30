ARG ARCH=

# Pull base image
FROM ubuntu:latest

# Labels
LABEL MAINTAINER="https://github.com/dbsqp/"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    tzdata && \
    curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash && \
    apt-get update && apt-get install speedtest && \
    rm -rf /var/lib/apt/lists/*
    
    
# Setup external package-sources
#RUN apt-get update && apt-get install -y \
#    python3 \
#    python3-dev \
#    python3-setuptools \
#    python3-pip \
#    python3-virtualenv \
#    --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/* 

# do pip installs 
#RUN pip3 install pytz influxdb-client requests
#datetime json os subprocess time socket sys

# do external package-sources
#RUN apt-get install -y --no-install-recommends \
#    iputils-ping \
#    tzdata \
#    curl \
#    ca-certificates \
#    gnupg2

# do speedtest install
#RUN curl https://install.speedtest.net/app/cli/install.deb.sh | bash && \
#    apt-get update && apt-get install -y speedtest && \
#    rm -rf /var/lib/apt/lists/*
    
# Environment vars
ENV PYTHONIOENCODING=utf-8

# Copy files
ADD speedtest.py /
ADD get.sh /

# Run
CMD ["/bin/bash","/get.sh"]

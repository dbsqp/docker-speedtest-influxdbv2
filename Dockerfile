ARG ARCH=
ARG TARGETPLATFORM
RUN echo "I'm building for $TARGETPLATFORM"

# Pull base image
FROM ubuntu:latest

# Labels
LABEL MAINTAINER="https://github.com/dbsqp/"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    debian-archive-keyring


RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then echo "THIS IS AMD64 = x86"; fi
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then echo "THIS IS ARM64 = ARM"; fi


RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash

RUN apt-get update && apt-get install speedtest

RUN rm -rf /var/lib/apt/lists/*

#    tzdata \


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
    
# Environment vars
ENV PYTHONIOENCODING=utf-8

# Copy files
ADD speedtest.py /
ADD get.sh /

# Run
CMD ["/bin/bash","/get.sh"]

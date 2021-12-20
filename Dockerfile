# modelio-4.1.0 on Debian-based image
#
# WARNING : PLEASE READ README.md
#
# References:
#   https://github.com/pascalpoizat/docker-modelio
#   https://github.com/mdouchement/docker-zoom-us
#   https://github.com/sameersbn/docker-skype

#FROM ubuntu:16.04
FROM openjdk:11.0.12-slim-bullseye

# Based on that initial version, and Pascal Poizat's
#LABEL maintainer="gerald.hameau@gmail.com"
LABEL maintainer="olivier.berger@telecom-sudparis.eu"

ENV DEBIAN_FRONTEND noninteractive

ARG USER_ID=1000
ARG GROUP_ID=1000

# System
RUN apt-get update
RUN apt-get -qy dist-upgrade

RUN apt-get install -qy --no-install-recommends \
    wget sudo libwebkit2gtk-4.0-37

RUN mkdir /modelio && \
    cd /modelio && \
    wget -nv --show-progress --progress=bar:force:noscroll -O modelio.tar.gz https://github.com/ModelioOpenSource/Modelio/releases/download/v4.1.0/Modelio.4.1.0.-.Linux.tar.gz && \
    tar xfz modelio.tar.gz && \
    rm -rf modelio.tar.gz

COPY scripts/ /var/cache/modelio/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]

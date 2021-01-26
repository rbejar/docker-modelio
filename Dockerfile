# modelio-4.1.0 on ubuntu 16.04
#
# WARNING : PLEASE READ README.md
#
FROM ubuntu:16.04
LABEL maintainer="gerald.hameau@gmail.com"

ARG USER_ID=1000
ARG GROUP_ID=1000

# System
RUN apt-get update && \
    apt-get install -y wget && \
    mkdir /modelio && \
    wget -nv --show-progress --progress=bar:force:noscroll -O /modelio/modelio.deb https://sourceforge.net/projects/modeliouml/files/4.1.0/modelio-open-source_4.1.0_ubuntu_amd64.deb && \
    apt install -y /modelio/modelio.deb && \
    rm /modelio/modelio.deb

# User with UID/GID from host user. Not tested as root
RUN mkdir -p /home/developer && \
    if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
        groupadd -g ${GROUP_ID} developer && \
        useradd -l -u ${USER_ID} -g developer developer \
    ;fi && \
    chown ${USER_ID}:${GROUP_ID} -R /home/developer

USER developer
ENV HOME /home/developer

CMD /usr/bin/modelio-open-source4.1
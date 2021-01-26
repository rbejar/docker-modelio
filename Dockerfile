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
    # using Oracle Java 8 is no longer poossible
    # apt-get install -y software-properties-common && \
    # add-apt-repository ppa:webupd8team/java && \
    # apt-get install -y oracle-java8-installer && \
    # so we use OpenJDK8
    apt-get install -y openjdk-8-jdk openjdk-8-jre && \
    mkdir /modelio && \
    wget -nv --show-progress --progress=bar:force:noscroll -O /modelio/modelio.deb https://sourceforge.net/projects/modeliouml/files/4.1.0/modelio-open-source_4.1.0_ubuntu_amd64.deb && \
    apt-get install -y /modelio/modelio.deb && \
    rm /modelio/modelio.deb

RUN mkdir -p /home/developer && \
    if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
        groupadd -g ${GROUP_ID} developer && \
        useradd -l -u ${USER_ID} -g developer developer \
    ;fi && \
    chown ${USER_ID}:${GROUP_ID} -R /home/developer

USER developer
ENV HOME /home/developer

CMD /usr/bin/modelio-open-source4.1
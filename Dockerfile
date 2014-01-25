FROM ubuntu:latest
MAINTAINER Manfred Touron m@42.am

# SYSTEM
RUN locale-gen en_US en_US.UTF-8
RUN apt-get update -y
RUN apt-get install -qq curl wget \
    python-software-properties \
    software-properties-common && \
    apt-get clean

# JAVA
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -qq oracle-java7-installer && \
    apt-get clean

# DOCKER ENTRIES
EXPOSE 8083 8086 1935
ENTRYPOINT ["/start"]

# WOWZA
ADD http://www.wowza.com/downloads/WowzaMediaServer-3-6-3/WowzaMediaServer-3.6.3.deb.bin /tmp
RUN chmod +x /tmp/WowzaMediaServer*.bin && \
    echo "yes" | /tmp/WowzaMediaServer*.bin
# cd /usr/local/WowzaMediaServer/bin
# ./startup.sh

ADD ./start /
RUN chmod +x /start

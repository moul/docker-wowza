FROM ubuntu:12.10
MAINTAINER Manfred Touron m@42.am

# SYSTEM
RUN apt-get update
RUN apt-get install -y curl wget
RUN locale-gen en_US en_US.UTF-8
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common

# JAVA
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# WOWZA
RUN cd /tmp; wget http://www.wowza.com/downloads/WowzaMediaServer-3-6-3/WowzaMediaServer-3.6.3.deb.bin
RUN chmod +x /tmp/WowzaMediaServer*.bin
RUN echo "yes" | /tmp/WowzaMediaServer*.bin
# cd /usr/local/WowzaMediaServer/bin
# ./startup.sh

EXPOSE 8083 8086 1935
ENTRYPOINT ["/start"]
ADD ./start /
RUN chmod +x /start

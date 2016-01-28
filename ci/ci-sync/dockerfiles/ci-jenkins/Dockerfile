FROM jenkins
MAINTAINER Simon Narkprasert <simon.narkprasert@envinet.com>

USER root
RUN apt-get update
RUN apt-get -y install sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-custom && chmod 0440 /etc/sudoers.d/90-custom

# install Apache Maven
RUN apt-get -y install \ 
  maven \
  apt-transport-https \
  netcat \
  python-pip && \
  pip install docker-compose

# install Oracle Java
RUN apt-get -y install software-properties-common
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get -y update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
RUN apt-get -y install oracle-java8-installer

# copy jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# docker management
RUN apt-get -yqq update && apt-get -yqq install docker.io && usermod -g docker jenkins
VOLUME /var/run/docker.sock

# no return to jenkins user, because docker commands are not working then
#USER jenkins

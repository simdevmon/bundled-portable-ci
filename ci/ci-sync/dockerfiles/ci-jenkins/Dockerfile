FROM jenkins
MAINTAINER Simon Narkprasert <simdevmon@gmail.com>

USER root
RUN apt-get update
RUN apt-get -y install sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-custom && chmod 0440 /etc/sudoers.d/90-custom

# install packages
RUN apt-get -y install \ 
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

# install Apache Maven (manually, because Jessie has only version 3.0.5)  
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /opt/apache-maven
RUN cd /tmp && \
	curl -sLo /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
		http://mirror.synyx.de/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	tar xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	mv apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
	rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz 
ENV PATH ${MAVEN_HOME}/bin:$PATH

# copy jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# docker management
RUN apt-get -yqq update && apt-get -yqq install docker.io && usermod -g docker jenkins
VOLUME /var/run/docker.sock

USER jenkins

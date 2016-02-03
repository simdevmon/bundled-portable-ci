FROM ubuntu 
MAINTAINER Simon Narkprasert <simdevmon@gmail.com>

# Install packages on ubuntu base image
RUN \
 apt-get update && \ 
 apt-get install -y unzip && \
 apt-get install -y curl && \ 
 apt-get install -y software-properties-common python-software-properties

# Install Java 8, agree to oracle jdk license
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \ 
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Settings application server
ENV PAYARA_URL https://s3-eu-west-1.amazonaws.com/payara.co/Payara+Downloads/Payara+4.1.1.154/payara-4.1.1.154.zip
ENV PAYARA_FILENAME payara-4.1.1.154.zip
ENV PAYARA_FOLDER=payara41
ENV DOMAIN_NAME domain1

# Install Payara application server
RUN curl -o /opt/${PAYARA_FILENAME}.zip -L ${PAYARA_URL} && unzip /opt/${PAYARA_FILENAME}.zip -d /opt
ENV DEPLOYMENT_DIR /opt/${PAYARA_FOLDER}/glassfish/domains/${DOMAIN_NAME}/autodeploy/

WORKDIR /opt/${PAYARA_FOLDER}/glassfish/bin

RUN echo "admin;{SSHA256}80e0NeB6XBWXsIPa7pT54D9JZ5DR5hGQV1kN1OAsgJePNXY6Pl0EIw==;asadmin" > /opt/${PAYARA_FOLDER}/glassfish/domains/${DOMAIN_NAME}/config/admin-keyfile
RUN echo "AS_ADMIN_PASSWORD=glassfish" > pwdfile

# Database settings for MariaDB
ENV JDBC_DRIVER_VERSION 5.1.38
ENV JDBC_DRIVER_URL http://central.maven.org/maven2/mysql/mysql-connector-java/${JDBC_DRIVER_VERSION}/mysql-connector-java-${JDBC_DRIVER_VERSION}.jar
ENV JDBC_DRIVER_FILENAME mysql-connector-java-${JDBC_DRIVER_VERSION}.jar
ENV DB_DRIVER_CLASS com.mysql.jdbc.Driver
ENV DB_URL 'jdbc\:mysql\://db-system-test\:3306/dbst?autoReconnect\=true&noDatetimeStringSync\=true'

ENV DB_USER dbst
ENV DB_PASSWORD dbst
ENV JDBC_RESOURCE AppDb
ENV JDBC_POOL jdbc/AppDb

# Install JDBC driver
RUN curl -o /opt/${PAYARA_FOLDER}/glassfish/domains/${DOMAIN_NAME}/lib/${JDBC_DRIVER_FILENAME} -L ${JDBC_DRIVER_URL}

# Change server port from 8080 to 8081, because of conflict with Jenkins
RUN \
  ./asadmin start-domain ${DOMAIN_NAME} && \
  ./asadmin --user admin --passwordfile pwdfile enable-secure-admin && \
  ./asadmin --user admin --passwordfile pwdfile set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=8081 && \  
  ./asadmin --user admin --passwordfile pwdfile create-jdbc-connection-pool --driverclassname ${DB_DRIVER_CLASS} --restype java.sql.Driver --property user=${DB_USER}:password=${DB_PASSWORD}:url=${DB_URL} ${JDBC_RESOURCE} && \ 
  ./asadmin --user admin --passwordfile pwdfile create-jdbc-resource --connectionpoolid ${JDBC_RESOURCE} ${JDBC_POOL} && \   
  ./asadmin stop-domain ${DOMAIN_NAME}
  
EXPOSE 4848 8009 8081 8181

# Boot application server on container start (verbose to keep the process in foreground)
CMD ["/opt/payara41/glassfish/bin/asadmin", "start-domain", "--verbose", "domain1"]

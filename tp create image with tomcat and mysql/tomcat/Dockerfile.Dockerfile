#Create a container with java and tomcat
FROM centos:latest
MAINTAINER Servhentess | oleon-cedric@live.fr

#Run tomcat
CMD bash /busapps/dcvt/1.0/apache-tomcat-8.5.29/bin/catalina.sh start && \
	tail /busapps/dcvt/1.0/apache-tomcat-8.5.29/logs/catalina.out -f

#Update and requirements
RUN yum -y update && \
	yum -y install wget && \
	yum -y install tar && \
	yum -y install lvm2* && \
	yum -y install epel-release

#Mapping port 8080 tomcat to 80 host
EXPOSE 80:8080

#Create new user DCVTGBLA
RUN useradd DCVTGBLA

#Create Tree
RUN mkdir -p /busapps && chown root:root /busapps && \
    mkdir -p /busapps/dcvt/1.0 && chown DCVTGBLA:DCVTGBLA /busapps/dcvt/1.0 && \
    mkdir -p /busdata && chown root:root /busdata && \
    mkdir -p /busdata/dcvt/1.0/data && chown DCVTGBLA:DCVTGBLA /busdata/dcvt/1.0/data && \
    mkdir -p /busdata/dcvt/1.0/logs && chown DCVTGBLA:DCVTGBLA /busdata/dcvt/1.0/logs

#Create volumes
VOLUME ["/busdata/dcvt/1.0/data", "/busdata/dcvt/1.0/logs"]

#Install jdk8 in /busapps/dcvt/1.0
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz" && \
	tar zxvf jdk-8u161-linux-x64.tar.gz -C /busapps/dcvt/1.0 && \
	rm jdk-8u161-linux-x64.tar.gz

#Install tomcat in /busapps/dcvt/1.0
RUN wget http://apache.mindstudios.com/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz && \
	tar zxvf apache-tomcat-8.5.29.tar.gz -C /busapps/dcvt/1.0 && \
	rm apache-tomcat-8.5.29.tar.gz

#Install .war sample to /busapps/dcvt/1.0/apache-tomcat-8.5.29/webapps
RUN wget https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war && \
    mv sample.war /busapps/dcvt/1.0/apache-tomcat-8.5.29/webapps/sample.war

#Config java ENV
ENV JRE_HOME=/busapps/dcvt/1.0/jdk1.8.0_161/jre
ENV JAVA_HOME=/busapps/dcvt/1.0/jdk1.8.0_161
#Create a container with MySql
FROM centos:latest
MAINTAINER Servhentess | oleon-cedric@live.fr

#Update and requirements
RUN yum -y update && \
	yum -y install wget && \
	yum -y install tar && \
	yum -y install lvm2* && \
	yum -y install epel-release

#Download and install MySql
RUN wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm && \
	rpm -ivh mysql57-community-release-el7-9.noarch.rpm && \
	yum -y install mysql-server
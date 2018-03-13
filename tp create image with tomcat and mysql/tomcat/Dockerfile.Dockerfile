#Create a container with java and tomcat
FROM centos:latest
MAINTAINER Servhentess

#Update and requirements
RUN yum -y update && \
	yum -y install wget && \
	yum -y install tar && \
	yum -y install lvm2*

#LVM
RUN pvcreate /dev/sdc
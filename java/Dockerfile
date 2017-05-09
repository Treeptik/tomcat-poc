FROM centos:7

MAINTAINER Nicolas Muller <n.muller@treeptik.fr>

COPY jdk-8u131-linux-x64.rpm /tmp/jdk-8u131-linux-x64.rpm
RUN yum -y localinstall /tmp/jdk-8u131-linux-x64.rpm

ENV JAVA_HOME /usr/java/latest

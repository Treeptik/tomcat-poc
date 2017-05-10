#!/usr/bin/env bash

# AWFUL SCRIPT BUT USEFUL

cd java
docker build -t poc/java:8 .

cd ../tomcat
docker build -t poc/tomcat:8 --build-arg TOMCAT_VERSION=8.0.43 .

cd ../spring-petclinic
mvn clean package docker:build



# HOW TO BUILD

## JAVA

```
docker build -t bdl/java:8.131 .
docker tag bdl/java:8.131 bdl/java:8
```

## TOMCAT

```
docker build -t bdl/tomcat:8 --build-arg TOMCAT_VERSION=8.0.43 .
```

## APPLICATION

```
docker build -t bdl/poc  .
```

# HOW TO RUN

First step run ELK with docker-compose
Then

```
docker rm -vf tomcatpoc
docker run --rm -d --name tomcatpoc -e ELASTICSEARCH_URL=dockerelk_elasticsearch_1:9200 --network=dockerelk_elk -it bdl/tomcat:8 run create-admin
```
# tomcat-poc

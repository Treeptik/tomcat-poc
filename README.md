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

First step run ELK stack within docker compose

```
docker-compose up -d
```

Then run a tomcat app

```
docker rm -vf tomcatpoc
docker run --rm -d --name tomcatpoc -e ELASTICSEARCH_URL=dockerelk_elasticsearch_1:9200 --network=dockerelk_elk -it bdl/tomcat:8 run create-admin
```

Then configure elasticsearch ingest pipeline and kibana dasboard

Push elasticsearch pipeline
```
curl -XPUT 'localhost:9200/_ingest/pipeline/access-logs?pretty' -H 'Content-Type: application/json' -d'
{
  "description" : "Ingest pipeline for apache standart access logs",
  "processors" : [
    {
      "grok": {
        "field": "message",
        "patterns": ["%{COMMONAPACHELOG}"]
      }
    },
    {
      "date": {
        "field": "timestamp",
        "formats": [ "dd/MMM/YYYY:HH:mm:ss Z" ]
        }
    }
  ]
}'

curl -XPUT 'localhost:9200/_ingest/pipeline/tomcat?pretty' -H 'Content-Type: application/json' -d'
{
  "description" : "Ingest pipeline for tomcat & catalina logs",
  "processors" : [
    {
      "grok": {
        "field": "message",
        "patterns": ["%{TOMCATLOG}|%{CATALINALOG}|%{TOMCAT_DATE_PERSO:timestamp} %{LOGLEVEL:level} \\[%{DATA:thread}\\] %{JAVACLASS:class}\\.%{JAVAMETHOD:method} %{GREEDYDATA:logmessage}"],
        "pattern_definitions": {
        "TOMCAT_DATE_PERSO" : "%{TOMCAT_DATESTAMP}|%{CATALINA_DATESTAMP}|%{MONTHDAY}-%{MONTH}-%{YEAR} %{TIME}.%{INT}"
      }
      }
    },
    {
      "date": {
        "field": "timestamp",
        "formats": [ "dd-MMM-YYYY HH:mm:ss.SSS", "YYYY-MM-dd HH:mm:ss Z", "MMM dd, yyyy HH:mm:ss a" ]
        }
    }
  ]
}'
```

Connect to kibana and add 'filebeat-*' and 'metricbeat-*' indexes and import dashboard file.

# tomcat-poc

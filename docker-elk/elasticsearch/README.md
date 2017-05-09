# HOW TO INSERT INGEST PIPELINE INTO ELASTICSEARCH

## Access log input
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

## Access log tomcat
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

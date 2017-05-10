FROM bdl/java:8

ARG TOMCAT_VERSION
ENV TOMCAT_VERSION ${TOMCAT_VERSION:-8.0.43}
ENV ELASTICSEARCH_URL http://elasticsearch:9200

# Install Tomcat
ENV CATALINA_HOME /opt/tomcat
ENV TOMCAT_MAJOR 8
ENV PATH $CATALINA_HOME/bin:$PATH

COPY apache-tomcat-${TOMCAT_VERSION}.tar.gz /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN cd /tmp && tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm apache-tomcat*.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME}

# Create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY filebeat-5.4.0-x86_64.rpm /tmp/filebeat-5.4.0-x86_64.rpm
RUN rpm -vi /tmp/filebeat-5.4.0-x86_64.rpm
RUN mkdir /var/lib/filebeat && chown -R tomcat:tomcat /var/lib/filebeat
RUN chmod 644 /etc/filebeat/filebeat.yml
WORKDIR /opt/tomcat

COPY jolokia-war-1.3.6.war /opt/tomcat/webapps/jolokia.war

COPY metricbeat.yml /etc/metricbeat/metricbeat.yml
COPY metricbeat-5.4.0-x86_64.rpm /tmp/metricbeat-5.4.0-x86_64.rpm
RUN rpm -vi /tmp/metricbeat-5.4.0-x86_64.rpm
RUN mkdir /var/lib/metricbeat && chown -R tomcat:tomcat /var/lib/metricbeat
RUN chmod 644 /etc/metricbeat/metricbeat.yml

EXPOSE 8080
EXPOSE 8009

COPY create_admin_tomcat.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

VOLUME $CATALINA_HOME/logs

USER tomcat
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "run" ]

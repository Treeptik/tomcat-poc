FROM bdl/java:8.131

ARG TOMCAT_VERSION
ENV TOMCAT_VERSION ${TOMCAT_VERSION:-8.0.43}

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
COPY filebeat-5.3.2-x86_64.rpm /tmp/filebeat-5.3.2-x86_64.rpm
RUN rpm -vi /tmp/filebeat-5.3.2-x86_64.rpm
RUN mkdir /var/lib/filebeat && chown -R tomcat:tomcat /var/lib/filebeat
WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

COPY create_admin_tomcat.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

VOLUME $CATALINA_HOME/logs

USER tomcat
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "run" ]

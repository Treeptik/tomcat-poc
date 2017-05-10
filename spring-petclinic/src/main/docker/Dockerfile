FROM bdl/tomcat:8

ADD spring-petclinic.war $CATALINA_HOME/webapps
USER root
RUN chown -R tomcat:tomcat $CATALINA_HOME/webapps
USER tomcat

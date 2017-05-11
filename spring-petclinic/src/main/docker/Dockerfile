FROM poc/tomcat:8

LABEL application @project.build.finalName@
LABEL git.branch @git.branch@
LABEL git.commit.id.abbrev @git.commit.id.abbrev@
LABEL git.commit.user.email @git.commit.user.email@
LABEL git.commit.message.full @git.commit.message.full@
LABEL git.commit.time @git.commit.time@

USER root
RUN mv $CATALINA_HOME/webapps/jolokia.war $CATALINA_HOME/
RUN rm -rf $CATALINA_HOME/webapps/*
RUN mv $CATALINA_HOME/jolokia.war $CATALINA_HOME/webapps/
ADD spring-petclinic.war $CATALINA_HOME/webapps/ROOT.war
RUN chown -R tomcat:tomcat $CATALINA_HOME/webapps
USER tomcat

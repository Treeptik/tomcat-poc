FROM bdl/tomcat:8

ENV JAR_FILE spring-petclinic.war

#LABEL application ${project.artifactId}
#LABEL version ${project.version}
#LABEL git.branch ${git.branch}
#LABEL git.commit.id.abbrev ${git.commit.id.abbrev}
#LABEL git.commit.user.email ${git.commit.user.email}
#LABEL git.commit.message.full ${git.commit.message.full}
#LABEL git.commit.time ${git.commit.time}

USER tomcat

# Copy your verticle to the container
COPY $JAR_FILE $CATALINA_HOME/webapps

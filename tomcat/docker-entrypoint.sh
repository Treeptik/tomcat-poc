#!/bin/bash

if [[ $2 == "create-admin" ]]; then
  if [ ! -f ${CATALINA_HOME}/.tomcat_admin_created ]; then
  	create_admin_tomcat.sh
  fi
fi

# if $APPLICATIVE_MONITORING doesn't exist or is equals to 1
if [ -z "$APPLICATIVE_MONITORING" ] || [ "$APPLICATIVE_MONITORING" -eq 1 ]; then
  filebeat.sh &
fi

if [[ $1 == "run" ]]; then
  exec catalina.sh "run"
fi

exec "$@"

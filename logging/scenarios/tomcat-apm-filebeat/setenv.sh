export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/tomcat/bin/elastic-apm-agent-1.23.0.jar"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.service_name=core"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.application_packages=com.quizplus"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.server_url=http://apm-server-apm-server.mon.svc.cluster.local:8200"

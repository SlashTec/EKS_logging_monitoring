
# Documentation

### prerequistes
```
-check the elastic apm and it's apm agent matrix 
-there resources that i'm following: https://www.elastic.co/guide/en/apm/agent/java/current/setup-javaagent.html

```

### installation
```
1- download the agent version depends on the elastic apm version 
wget https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/1.23.0/elastic-apm-agent-1.23.0.jar

2- create setenv.sh 
export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/tomcat/bin/elastic-apm-agent-1.23.0.jar"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.service_name=core"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.application_packages=com.quizplus"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.server_url=http://apm-server-apm-server.mon.svc.cluster.local:8200"

```

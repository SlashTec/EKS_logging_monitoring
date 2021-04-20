#!/bin/bash

#service filebeat start 
#filebeat -c /etc/filebeat/filebeat.yml &

catalina.sh start
filebeat -e -c /etc/filebeat/filebeat.yml
#service filebeat start 




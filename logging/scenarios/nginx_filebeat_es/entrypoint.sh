#!/bin/bash
catalina.sh start   # must run first otherwise the ci=ontainer will crash
filebeat -e -c /etc/filebeat/filebeat.yml
#service filebeat start   # didn't work
#/etc/init.d/filebeat start    # didn't work 
#filebeat -e -c /etc/filebeat/filebeat.yml &    # didn't work

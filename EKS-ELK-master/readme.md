
# installation steps 

0- k create configmap es-p12-cert --from-file=elastic-stack-ca.p12 -n mon 

1- elasticsearch.yaml

2- kibana.yaml

3- logstash.yaml

4- file-beat

5- exec inside elasticsearch container >>> inside /usr/share/elasticsearch/bin/  runt this command : 
./elasticsearch-setup-passwords interactive
then enter the those passwrds, don't forget to edit those configs also in kibana.yaml and logstash.yaml

Enter password for [elastic]: 
pbaf-130-dmn

Enter password for [apm_system]: 
pbaf-130-dmn

Enter password for [kibana]: 
pbaf-130-dmn

Enter password for [logstash_system]: 
pbaf-130-dmn

Enter password for [beats_system]: 
pbaf-130-dmn

Enter password for [remote_monitoring_user]: 
pbaf-130-dmn


user: elastic
pass: pbaf-130-dmn


Enter into nginx container or pod:
  $ kubectl exec -it  name_of_nginx_container  -n prod
  install the filebeat  in nginx
(Notes)  : u can find the steps here in kibana Gui >> kibana > infrastructure > view setup instruction > logging > log-nginx

Or use following steps direct:-

# Steps to install filebeat on nginx :

> 0) prepare the nginx logs :
seperate the website logs from the main logs and then adjust the log format : 
1- add this log format in nginx.conf inside http {} context 
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
2- use this format in the Vhost 
  access_log /var/log/nginx/website_access.log main;



1 ) Download and install Filebeat:

 $ curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.2-darwin-x86_64.tar.gz
$ tar xzvf filebeat-7.4.2-darwin-x86_64.tar.gz
$ cd filebeat-7.4.2-darwin-x86_64/
 

    2) Edit the configuration Modify filebeat.yml to set the connection information:
 

But i  use the exist filebeat.yml configuration file (on my Drive folder ELK) instead of the existing one (replace it) :

    3 ) Enable and configure the nginx module
 
 $ sudo filebeat modules enable nginx

   4) Start Filebeat ( install all the dashboards )
         $  sudo filebeat setup
         $  sudo service filebeat start
         or
    $ ./filebeat setup
    $ ./filebeat -e
 





# notes
i'm using the service_name instead of ip addresses


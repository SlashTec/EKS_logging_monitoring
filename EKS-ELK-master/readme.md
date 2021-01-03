
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

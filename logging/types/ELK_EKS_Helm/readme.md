# ElasticSearch Kibana   FileBeat  Metricbeat
Both metricbeat and filebeat push it's logs into ES directly
i commented FileBeat

## to install everything: just run >>> ./install 

## Simple Notes
if u want to use it for any other cloud provider just change  " storageClassName " value in values-es.yaml
or change the value to standrad if u want to use it localy

## to install release in specific namespace
helm install --name elasticsearch --namespace elk elastic/elasticsearch -f ./values-es.yaml 

## install kibana and set specific service type
helm install --name kibana --namespace elk --set service.type=NodePort  elastic/kibana -f ./values-kibana.yaml 

## install metricbeat
helm install --name metricbeat --namespace elk elastic/metricbeat


## to upgrade release configs from values.yaml file  
helm upgrade -f new-values.yml {release name} {package name or path} --version {fixed-version}
helm upgrade -f values-es.yaml  elasticsearch elastic/elasticsearch



## to uninstall helm from kubernetes or  delete tiller from kubernetes cluster
helm reset --force
kubectl delete all -l app=helm -n kube-system



## how to delete release from the cluster  >>>> NOTE : the pvc will be still exist u should delete it manualy
helm del --purge kibana


## to get values :
helm get values --all elasticsearch |grep -i replica





## Metricbeat vs Logstash vs Direct
Use logstash if you need to do more filtering/processing or aren't running a current version of elasticsearch that has an ingest node feature.

We use filebeat -> logstash -> elasticsearch because we need to decorate the logs with additional variables set in the cmdb and elsewhere, and we rely heavily on the ruby plugin for processing.

That said, if you don't need the extra processing, it's much faster and more efficient to go directly from the beats to elasticsearch.



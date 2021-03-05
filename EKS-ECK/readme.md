#                                               Elastic Cloud on Kubernetes (ECK) ON EKS

## pre requisites
```
-gp2 storage class and be the default if not in the annotations:      storageclass.kubernetes.io/is-default-class: "true"
-make storage class has a capability to expand :  allowVolumeExpansion: true 

```


## kibana
to get the password : kubectl get secret <cluster-name>-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
EX: kubectl get secret ha-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'

## ES
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html

## filebeat
https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-beat-quickstart.html

## Notes
##access them using HTTPS + port-number




## installation steps
1-)kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml  # the operator
2-)apply -f apm_es_kibana.yaml  # this is the config file which gives u a capability to talk to the operator 
then beat if needed 

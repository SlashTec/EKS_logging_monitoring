#                                               Elastic Cloud on Kubernetes (ECK) ON EKS

## pre requisites
```
-gp2 storage class and be the default if not in the annotations:      storageclass.kubernetes.io/is-default-class: "true"
-make storage class has a capability to expand :  allowVolumeExpansion: true 

```


## kibana
to get the password : kubectl get secret <cluster-name>-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
EX: kubectl -n elastic-system get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'

## ES
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html

## filebeat
https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-beat-quickstart.html

## Notes
```
- access them using HTTPS + port-number
- cluster.routing.allocation.awareness.attributes: rack_id|zone  <<< here i'm telling the elastic search operator about my nodes allocation status to do the best for us depends on our case either we are using distibute our node a cross diff zones or racks 
If Elasticsearch is aware of the physical configuration of your hardware, it can ensure that the primary shard and its replica shards are spread across different physical servers, racks, or zones, to minimise the risk of losing all shard copies at the same time.
 https://www.elastic.co/guide/en/elasticsearch/reference/6.8/allocation-awareness.html#allocation-awareness
-  Elasticsearch knows how to balance multi-node clusters to provide scale and high availability
- to scale pods in ECK nodeset: kes scale --replicas=2 sts elasticsearch-es-master-zone




```

## installation steps
```
1-)kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml  # the operator
2-)apply -f apm_es_kibana.yaml  # this is the config file which gives u a capability to talk to the operator 
then beat if needed 

```

#                                               Elastic Cloud on Kubernetes (ECK) ON EKS

## pre requisites
```
-gp2 storage class and be the default if not in the annotations:      storageclass.kubernetes.io/is-default-class: "true"
-make storage class has a capability to expand :  allowVolumeExpansion: true 

```


## kibana
```
to get the password : kubectl get secret <cluster-name>-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
EX: kubectl -n elastic-system get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'

#to delete kibana indices use this command after u know how to backup  or upgrade the kibana indexs first because will delete all of dashborads 
 curl -k -XDELETE  https://dfasdfasdfasdfasdfassdfasdf.us-east-1.elb.amazonaws.com:9200/.kibana_1  --header "content-type: application/JSON" -u elastic -p


```
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
- to install plugins specially s3 plugin follow this link : https://coralogix.com/log-analytics-blog/running-elk-on-kubernetes-with-eck-part-2/
- kibana migration/upgration/deletion  also not working smothly and take care of index and it's dashboard may remove 
- if the cluster turned to red it means  that at least one primary shard and its replicas are not allocated to a node,  and u can follow this link to know how to investigate the issue : https://www.datadoghq.com/blog/elasticsearch-unassigned-shards/
- those 2 option very very important wich makes theoperator aware of the avalibility zones to allocate the shards and it's replicas in a diff zones if not added  may causing the elastic search stoping and became red and kibana will not able to connect and tells u delete .kibana_1 and so on 
      node.attr.zone: us-east-1b
      cluster.routing.allocation.awareness.attributes: zone
- To ensure the cluster remains available, you must not stop half or more of the nodes in the voting configuration at the same time. As long as more than half of the voting nodes are available, the cluster can work normally. For example, if there are three or four master-eligible nodes, the cluster can tolerate one unavailable node. If there are two or fewer master-eligible nodes, they must all remain available.
   " that is why we need at least 3 nodes/pods in the master"     see >>> https://www.elastic.co/guide/en/elasticsearch/reference/master/modules-node.html#master-node

- all the data stored in the data-nodes not the master, so there is no need to create a hight volume to the master and replica-shard in a diff node from the master-node 
```


## common commands
```
# to get the nodes and know which is the master : # to get the shards : _cat/nodes
# to get the shards : _cat/shards
# to scale po in eck: kes scale --replicas=2 sts elasticsearch-es-master-zone
```

## installation steps
```
1-)kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml  # the operator
2-)apply -f apm_es_kibana.yaml  # this is the config file which gives u a capability to talk to the operator 
then beat if needed 

```

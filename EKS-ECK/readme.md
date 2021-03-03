#                                               Elastic Cloud on Kubernetes (ECK) ON EKS

#pre requisites
-gp2 storage class and be the default if not :      storageclass.kubernetes.io/is-default-class: "true"



# kibana
to get the password : kubectl get secret <cluster-name>-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
EX: kubectl get secret ha-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
#ES
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html

#filebeat
https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-beat-quickstart.html

# Notes
##access them using HTTPS + port-number




# installation steps
1-)apply -f all-in-one.yaml  # the operator
2-)apply -f cluster
3-)kiban
4-)beat

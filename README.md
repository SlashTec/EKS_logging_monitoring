# EKS_logging_monitoring



first step make sure if u r created the storage class of the with the name of "topology-aware-standard" if not create it
```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: topology-aware-standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain

```
# MON
-------------------

## Silence specific alert 
```
1- port-forward the alertmanager svc then access it using the url 
2-1- got the alertname for the alertname option in the message that is come into your slack or mail :D
2- use this syntax and put it in filter bar to seach about the alert_name to silent it  : alertname="HostKernelVersionDeviations" 
3- u will se the silent button click on it then add milions of zeros in the time oh hours then follow the teps and create 

```
-----------------------
add new target into the prometheus configurations
u can add the ip and port of target to other job name group or ceate new job_name group to it 
```
    - job_name: jenkins
      static_configs:
      - targets:
        - "10.80.1.164:9100"

```
-----------------------
after any change in prometheus or alertmanager u should reload the configurations by this command form jenkins or port-forward or anywhere
curl -X POST http://localhost:6547/-/reload

----------------------------------
to test the alertmanager and send notification to the channel
```
# in case u want to send the alert to the alrtmanager and then the alertmanager ends it to the slack
curl -H "Content-Type: application/json" -d '[{"labels":{"alertname":"Ghanem"}}]' a07899fe6f6b040b68ab991bfb14f7ad-347767263.ap-southeast-1.elb.amazonaws.com:9093/api/v1/alerts

# in case u want to send the alert to the slack directly
curl -X POST -H 'Content-type: application/json' --data '{"text":"backup done for test"}' https://hooks.slack.com/services/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
```

# LOGGING

the best is to use ECK Solution 













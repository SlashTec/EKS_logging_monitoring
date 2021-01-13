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

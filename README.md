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

-------------------

Silence specific alert 
```
    inhibit_rules:
      - source_match:
          severity: 'critical'
        target_match:
          severity: 'warning'
        equal: ['alertname', 'dev', 'instance']
        
        # here i added new one "HostKernelVersionDeviations" to be silent 
      - source_match:
          severity: 'critical'
        target_match:
          severity: 'warning'
        equal: ['HostKernelVersionDeviations']

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
after any change u should reload prometheus by this command form jenkins or port-forward or anywhere
curl -X POST http://localhost:6547/-/reload














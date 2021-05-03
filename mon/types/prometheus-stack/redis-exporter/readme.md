# Redis-Exporter

### Steps 
```
first we have Redis Cluster , we want to scrap metrics inside this redis it's self 
1-) create exporter deployment and service as shown here "https://blog.ruanbekker.com/blog/2020/05/05/how-to-setup-a-redis-exporter-for-prometheus/"

run the_connection_to_master_redis command in background instead of using systemctl incase of using docker

2-)  create this file  prometheus-additional.yaml and then put the below configs inside


- job_name: redis_exporter
  metrics_path: /metrics
  static_configs:
    - targets: ['redis-exporter.prod.svc.cluster.local:9121']

3-) Create Secret from the above file
kubectl create secret generic additional-configs --from-file=prometheus-additional.yaml -n mon 

4-) menthion about your addition configs secret file inside values.yaml

prometheus:
  prometheusSpec:
    additionalScrapeConfigsSecret:
      enabled: true
      name: additional-configs
      key: prometheus-additional.yaml

```




### Note
```
we call redis pod using  ['ip.of.redis.exporter:9121']
all steps shown here: "https://blog.ruanbekker.com/blog/2020/05/05/how-to-setup-a-redis-exporter-for-prometheus/"
run this command  "curl -X POST http://localhost:9090/-/reload" to reload promotheus config


```






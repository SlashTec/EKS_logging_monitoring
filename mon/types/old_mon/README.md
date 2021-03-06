**Ansible playbooks for Monitor EKS**
 
An Ansible Playbooks to deploy Alertmanager , Grafana , prometheus , node-exporter and kube-state-metrics

**Requirements**
 
None

**Variables**
```
deployment_enabled: true .   # incase false  ansible playbook will remove all deployment inside kube.deployment.playbook.yml

manifest_app_dir: ./templates/.  # location of yml files such as deployment.yml 

deployment_file: grafana-deploy.yaml.   # specify deployment file which is in  manifest_app_dir

app.name: grafana.  # the name of the deployment file 

service_file: grafana-svc.yaml.   # the name of the service file

configmap_file: grafana-configMapDataSources.yaml.  # the name of configMap file. 
```
**How it works**

1-) prepare the alrtmanager to with thr right webhook channel and channel name

2-) make sure that u are configured the proper storageclass

make sure if u r created the storage class of the with the name of "topology-aware-standard" if not create it

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

3-) To start all deployments






./installAll.sh

 ```
 ```
To start specific deployment 

cd to deployment folder

$$ ansible-playbook kube.deployment.playbook.yml
```


# to isntall the dashboards 

### to access to grafana
> default username and passwords
username: admin
passwrod: admin


https://www.eksworkshop.com/intermediate/240_monitoring/dashboards/

### For creating a dashboard to monitor the cluster:

Click '+' button on left panel and select ‘Import’.
Enter 3119 dashboard id under Grafana.com Dashboard.
Click ‘Load’.
Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.
Click ‘Import’.

###  For creating a dashboard to monitor all the pods:

Click '+' button on left panel and select ‘Import’.
Enter 6417 dashboard id under Grafana.com Dashboard.
Click ‘Load’.
Enter Kubernetes Pods Monitoring as the Dashboard name.
Click change to set the Unique identifier (uid).
Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.s
Click ‘Import’.


# to Node Exporter Server Metrics >> for machine that has node exporters and great for testing
https://grafana.com/grafana/dashboards/405

# on servers  follow this linker very helpfull
https://medium.com/devops-dudes/install-prometheus-on-ubuntu-18-04-a51602c6256b

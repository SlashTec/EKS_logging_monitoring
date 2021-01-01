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
```
To start all deployments

./installAll.sh

 ```
 ```
To start specific deployment 

cd to deployment folder

$$ ansible-playbook kube.deployment.playbook.yml
```

#! /bin/bash
# Deploy NameSpace and ETCD
cd namespace-etcd
ansible-playbook kube.deployment.playbook.yml
sleep 15 & cd ..
# Deploy Node Exporter
cd node-exporter 
ansible-playbook kube.deployment.playbook.yml
sleep 5 & cd ..
# Deploy Kube-state-metrics
cd kube-state-metrics
ansible-playbook kube.deployment.playbook.yml
sleep 5 & cd ..
# Deploy AlertManager
cd alertmanager
ansible-playbook kube.deployment.playbook.yml
sleep 5 & cd ..
# Deploy Prometheus
cd prometheus
ansible-playbook kube.deployment.playbook.yml
sleep 5 & cd ..
# Deploy Grafana
cd grafana
ansible-playbook kube.deployment.playbook.yml
echo "Done"

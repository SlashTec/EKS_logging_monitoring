
# install helm in kubernetes
# curl https://raw.githubusercontent.com/kubernetes/Helm/master/scripts/get > get_Helm.sh
chmod 700 get_Helm.sh
./get_Helm.sh
helm init

# create service account 
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'


# to install release in specific namespace
helm repo add elastic https://helm.elastic.co
#with Helm 3: helm install elasticsearch ./helm-charts/elasticsearch --set imageTag=7.10.1
helm install --name elasticsearch --namespace mon elastic/elasticsearch  -f ./values-es.yaml 

# install kibana 
helm install --name kibana --namespace mon --set service.type=NodePort  elastic/kibana -f ./values-kibana.yaml

# install metricbeat
helm install --name metricbeat --namespace mon elastic/metricbeat


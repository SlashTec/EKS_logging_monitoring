# prometheus-community

### pre installation steps:
```
k -n kube-system get cm  kube-proxy-config -o yaml >kube-proxy-config.yaml
k -n kube-system edit cm  kube-proxy-config       
>>> then change metricsBindAddress: from "127.0.0.1:10249" to  "0.0.0.0:10249"
edit the slack url and the channel name inside the slack url and your ingress ssl
kubectl -n kube-system rollout restart ds kube-proxy
```
### installation steps
```
k create namespace mon  #  create it if didn't
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install -f values.yaml slashtec-mon --namespace mon prometheus-community/prometheus-operator --set prometheusOperator.createCustomResource=false
k apply -f ingress

```

## Notes
```
- default pass: prom-operator
- to upgrade : helm upgrade slashtec-mon --namespace mon prometheus-community/prometheus-operator
- if u faced this error : 
kubectl get validatingwebhookconfigurations.admissionregistration.k8s.io      //delete all objects
kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io slashtec-mon-prometheus-op-admission vpc-resource-validating-webhook

kubectl get MutatingWebhookConfiguration      //delete all objects
kubectl delete MutatingWebhookConfiguration slashtec-mon-prometheus-op-admission vpc-resource-mutating-webhook

> to prevent this from happening in the future : add those command at the end of the command
--set prometheusOperator.admissionWebhooks.enabled=false
--set prometheusOperator.admissionWebhooks.patch.enabled=false
--set prometheusOperator.tlsProxy.enabled=false


```


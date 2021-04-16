# prometheus-community

### pre installation steps:
```
k -n kube-system get cm  kube-proxy-config -o yaml >kube-proxy-config.yaml
k -n kube-system edit cm  kube-proxy-config       
>>> then change metricsBindAddress: from "127.0.0.1:10249" to  "0.0.0.0:10249"
```
### installation steps
```
k create namespace mon  #  created it if didn't
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install -f values.yaml slashtec-mon --namespace mon prometheus-community/prometheus-operator

```

## Notes
```
- default pass: prom-operator
- edit the file "alertmanager-slashtec-mon-prometheus-op-alertmanager" in secrets and
 edit the blew chnanel name and url then decode it there > www.base64decode.org
- to upgrade : helm upgrade slashtec-mon --namespace mon prometheus-community/prometheus-operator
```


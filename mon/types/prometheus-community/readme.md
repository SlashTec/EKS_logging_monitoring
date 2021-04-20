coreDns:
  service:
    selector:
      k8s-app: kube-dns
# Not monitoring etcd, kube-scheduler, or kube-controller-manager because it is managed by EKS
defaultRules:
  rules:
    etcd: false
    kubeScheduler: false
kubeControllerManager:
  enabled: false
kubeEtcd:
  enabled: false
kubeScheduler:
  enabled: false


# Grafana
grafana:
  service:
    type: NodePort

# prometheus
prometheus:
  service:
    type: NodePort

  prometheusSpec:
    storageSpec: 
      volumeClaimTemplate:
        spec:
          storageClassName: gp2
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 50Gi


# Alertmanager

alertmanager:
  config:
    global:
      resolve_timeout: 2m
    route:
      group_by: ['alert']
      group_wait: 10s
      group_interval: 5m
      repeat_interval: 5m
      receiver: slack
      routes:
      - match:
          alertname: AggregatedAPIDown
        receiver: "null"
      - match:
          alertname: Watchdog
        receiver: 'null'
      - match:
          alertname: KubeVersionMismatch
        receiver: 'null'
    inhibit_rules:
      - target_match_re:
           alertname: '.+Overcommit'
        source_match:
           alertname: 'Watchdog'
        equal: ['prometheus']

    receivers:
    - name: 'null'
    - name: 'slack'
      slack_configs:
      - api_url: 'https://hooks.slack.com/services/xxxxxxxxxxxxxxx/xxxxxxxxxxxxx/xxxxxxxxxxxxH'
        channel: '#prod-notifications'
        send_resolved: true
        title: '[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] Monitoring Event Notification'
        text: |-
          {{ range .Alerts }}
            *Alert:* {{ .Labels.alertname }} - `{{ .Labels.severity }}`
            *Description:* {{ .Annotations.message }}
            *Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:> *Runbook:* <{{ .Annotations.runbook_url }}|:spiral_note_pad:>
            *Details:*
            {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
            {{ end }}
          {{ end }}
        icon_url: https://avatars3.githubusercontent.com/u/3380462
    templates:
      - '/etc/config/alert/wechat.tmpl'
    inhibit_rules:
      - source_match:
          severity: 'critical'
        target_match:
          severity: 'warning'
        equal: ['alertname', 'dev', 'instance']

# No One try to remove this i putted this in case we need to add new rules 
#additionalPrometheusRules:
#  - name: custom-rules-file
#    groups:
#      - name: custom-node-exporter-rules
#        rules:
#          - alert: PhysicalComponentTooHot
#            ...

  alertmanagerSpec:
    storage: 
     volumeClaimTemplate:
       spec:
         storageClassName: gp2
         accessModes: ["ReadWriteOnce"]
         resources:
           requests:
             storage: 1Gi
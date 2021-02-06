# General Documentation for Alertmanager with Prometheus


#follwng these links
https://blog.ruanbekker.com/blog/2019/05/17/install-alertmanager-to-alert-based-on-metrics-from-prometheus/
https://www.youtube.com/watch?v=6Jr6rntMI3A

#Notes
- prometheus is pivotal point of the entire stack 
- inside prometheus configurations the rules path is relative not absolute 



1) inside the prometheus

#amtool and alertmanager tool
- alertmanager the alertmanager tool
- amtool :  is a cli tool for interacting with the Alertmanager API. It is bundled with all releases of Alertmanager.


#to integrate the alertmanager with prometheus we will add the both the rules and the alertmanager ip:port in prometheus 
```
rule_files:
  - rules/alert.rules.yml
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - 'localhost:9093'
```

#adding rules in prometheus
mkdir /etc/prometheus/rules/
nano /etc/prometheus/rules/alert.rules.yml
```
groups:
- name: alert.rules
  rules:
  - alert: InstanceDown
   # Condition for alerting
    expr: up == 0
    for: 1m
   # Annotation - additional informational labels to store more information
    annotations:
      title: 'Instance {{ $labels.instance }} down'
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
   # Labels - additional labels to be attached to the alert
    labels:
        severity: 'critical'

  - alert: HostOutOfMemory
   # Condition for alerting
    expr: node_memory_MemAvailable / node_memory_MemTotal * 100 < 25
    for: 5m
   # Annotation - additional informational labels to store more information
    annotations:
      title: 'Host out of memory (instance {{ $labels.instance }})'
      description: 'Node memory is filling up (< 25% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}'
   # Labels - additional labels to be attached to the alert
    labels:
        severity: 'warning'

  - alert: HostHighCpuLoad
   # Condition for alerting
    expr: (sum by (instance) (irate(node_cpu{job="node_exporter_metrics",mode="idle"}[5m]))) > 80
    for: 5m
   # Annotation - additional informational labels to store more information
    annotations:
      title: 'Host high CPU load (instance {{ $labels.instance }})'
      description: 'CPU load is > 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}'
   # Labels - additional labels to be attached to the alert
    labels:
        severity: 'warning'

  - alert: HostOutOfDiskSpace
   # Condition for alerting
    expr:  (node_filesystem_avail{mountpoint="/"}  * 100) / node_filesystem_size{mountpoint="/"} < 15
    for: 1m
   # Annotation - additional informational labels to store more information
    annotations:
      title: 'Host out of disk space (instance {{ $labels.instance }})'
      description: 'Disk is almost full (< 15% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}'
   # Labels - additional labels to be attached to the alert
    labels:
        severity: 'warning'



```

2) in alertmanager
#inside alertmanager configuration  just change the channel api (slack incomming webhook) and the channel name


```


global:
  resolve_timeout: 5m

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
  receiver: 'slack-notifications'
receivers:
- name: 'slack-notifications'
  slack_configs:
  - api_url: "https://hooks.slack.com/services/TFRPM3P/B01J44Q4/TIyOJoYEE75MYzbBzj"
    channel: '#encoded-notifications'
    send_resolved: true

    icon_url: https://avatars3.githubusercontent.com/u/3380462
    title: |-
      [{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] {{ .CommonLabels.alertname }} for {{ .CommonLabels.job }}
      {{- if gt (len .CommonLabels) (len .GroupLabels) -}}
        {{" "}}(
        {{- with .CommonLabels.Remove .GroupLabels.Names }}
          {{- range $index, $label := .SortedPairs -}}
            {{ if $index }}, {{ end }}
            {{- $label.Name }}="{{ $label.Value -}}"
          {{- end }}
        {{- end -}}
        )
      {{- end }}
    text: >-
      {{ with index .Alerts 0 -}}
        :chart_with_upwards_trend: *<{{ .GeneratorURL }}|Graph>*
        {{- if .Annotations.runbook }}   :notebook: *<{{ .Annotations.runbook }}|Runbook>*{{ end }}
      {{ end }}
      *Alert details*:
      {{ range .Alerts -}}
        *Alert:* {{ .Annotations.title }}{{ if .Labels.severity }} - `{{ .Labels.severity }}`{{ end }}
      *Description:* {{ .Annotations.description }}
      *Details:*
        {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
        {{ end }}
      {{ end }}
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']





```

#then reload the configs
systemctl daemon-reload
systemctl restart prometheus
systemctl restart alertmanager


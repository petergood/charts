{{- define "pvc-generate" -}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ template "fullname" .root }}-nfs{{- printf "-%s" .export.name | trunc 63 | trimSuffix "-" -}}-pvc
  labels:
    app: {{ template "fullname" .root }}
    chart: {{ .root.Chart.Name }}
    release: {{ template "releaseName" .root }}
    heritage: {{ .root.Release.Service }}
    component: "oneprovider"
    name: {{ printf "%s" .export.name | trunc 63 | trimSuffix "-" }}
    type: nfs
  annotations:
    version: "{{ .root.Chart.Version }}"
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: {{ index .export "storageClaim" }}
  selector: 
    matchLabels:
      type: nfs
      name: {{ printf "%s" .export.name | trunc 63 | trimSuffix "-" }}
      owner: {{ .root.Values.suffix }}
  storageClassName: ""
{{ end }}


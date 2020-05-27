{{- define "pv-generate" -}}
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ template "fullname" .root }}{{- printf "-%s" .name | trunc 63 | trimSuffix "-" -}}-pv
  labels:
    app: {{ template "fullname" .root }}
    chart: {{ .root.Chart.Name }}
    release: {{ template "releaseName" .root }}
    heritage: {{ .root.Release.Service }}
    component: {{ .root.Chart.Name }}
    name: {{ printf "%s" .name | trunc 63 | trimSuffix "-" }}
    type: nfs
    {{- if .root.Values.suffix }} 
    owner: {{ .root.Values.suffix }}
    {{- end }}
  annotations:
  {{- if .root.Values.deployAsPreInstallHook }}
    "helm.sh/hook": pre-install
  {{- end }}
    version: "{{ .root.Chart.Version }}"
spec:
  capacity:
    storage: {{ .root.Values.storage | quote }}
  accessModes:
    - ReadWriteMany
  # The NFS server pod is deleted anyway so no need to recycle
  persistentVolumeReclaimPolicy: {{ .root.Values.persistentVolumeReclaimPolicy }}
  {{- if .root.Values.mount_options }}
  mountOptions:
{{ toYaml .root.Values.mount_options | indent 4 }}
  {{- end }}
  nfs:
    # TODO: The NFS server name is resolved using nodes resolve.conf
    # here we expect that nodes resovle.conf can resolve namespaces service name
    # to FQDN k8s domain. But this is a special case, usually NFS servers are not
    # deployed ad-hoc :)
    server: "{{ template "fullname" .root }}.{{ .root.Release.Namespace }}"
    path: {{ .path | quote }}
{{ end }}
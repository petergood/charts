{{- define "openfaas.name" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "openfaas.fullname" -}}
{{ template "fullname" . }}
{{- end -}}
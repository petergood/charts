{{/* vim: set filetype=mustache: */}}
{{/*
This template overrides the variable used in a parent keycloak template.
Expand the name of the chart.
*/}}
{{- define "elasticsearch.name" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
This template overrides the variable used in a parent keycloak template.
Create a default fully qualified app name.
We truncate to 20 characters because this is used to set the node identifier in WildFly which is limited to
23 characters. This allows for a replica suffix for up to 99 replicas.
*/}}
{{- define "elasticsearch.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "elasticsearch.uname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "elasticsearch.masterService" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "elasticsearch.endpoints" -}}
{{- $replicas := int (toString (.Values.replicas)) }}
  {{- range $i, $e := untilStep 0 $replicas 1 -}}
{{ template "elasticsearch.uname" $ }}-{{ $i }},
  {{- end -}}
{{- end -}}
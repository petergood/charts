{{/* vim: set filetype=mustache: */}}
{{/*
This template overrides the variable used in a parent keycloak template.
Expand the name of the chart.
*/}}
{{- define "keycloak.name" -}}
{{ template "fullname" . }}
{{- end -}}

{{/*
This template overrides the variable used in a parent keycloak template.
Create a default fully qualified app name.
We truncate to 20 characters because this is used to set the node identifier in WildFly which is limited to
23 characters. This allows for a replica suffix for up to 99 replicas.
*/}}
{{- define "keycloak.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

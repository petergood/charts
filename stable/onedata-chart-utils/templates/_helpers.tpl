{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allows to override the release name.
*/}}
{{- define "releaseName" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- printf "%s" $releaseName | trunc 63 -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- $suffix := default "" .Values.suffix | toString -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- printf "%s-%s-%s" $releaseName $name $suffix | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Logic for generating service urls
*/}}
{{- define "global_region" -}}
{{- if .Values.global -}}
  {{- required "A non empty region name is required!" .Values.global.region -}}
{{- else -}}
  {{- required "A non empty region name is required!" "" -}}
{{- end -}}
{{- end -}}
{{- define "global_tld" -}}
{{- if .Values.global -}}
  {{- required "A non empty top level domain name is required!" .Values.global.tld -}}
{{- else -}}
  {{- required "A non empty top level domain name is required!" "" -}}
{{- end -}}
{{- end -}}
{{- define "cluster_domain" -}}{{template "global_region" .}}.{{template "global_tld" .}}{{end}}
{{- define "service_domain" -}}svc.{{template "cluster_domain" .}}{{end}}
{{- define "service_namespace_domain" -}}{{.Release.Namespace}}.svc.{{template "cluster_domain" .}}{{end}}
{{- define "service_url" -}}{{template "fullname" . }}.{{ template "service_namespace_domain" .}}{{- end -}}

{{/*
ImagePullSecrets template for yaml format
*/}}
{{- define "imagePullSecrets" -}}
  {{- if .Values.imagePullSecrets -}}
      {{- "imagePullSecrets:" -}}
      {{- range .Values.imagePullSecrets }}
        {{- cat "\n- name:" . | indent 2 -}}
      {{- end -}}
  {{- else if .Values.global -}}
    {{- if .Values.global.imagePullSecrets -}}
        {{- "imagePullSecrets:" -}}
        {{- range .Values.global.imagePullSecrets }}
            {{- cat "\n- name:" . | indent 2 -}}
        {{- end -}}
    {{- else -}}
        {{- "imagePullSecrets: []" -}}
    {{- end -}}
  {{- else -}}
    {{- "imagePullSecrets: []" -}}
  {{- end -}}
{{- end -}}

{{/*
ImagePullSecrets template for json format
*/}}
{{- define "imagePullSecrets_json" -}}
  {{- if .Values.imagePullSecrets -}}
    {{- with .Values.imagePullSecrets -}}
      {{- "\"imagePullSecrets\": [" -}}
      {{ range $index, $element := . }}
        {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
      {{- end }}
      {{- "]," -}}
    {{- end -}}
  {{- else if .Values.global -}}
    {{- if .Values.global.imagePullSecrets -}}
     {{- with .Values.global.imagePullSecrets -}}
      {{- "\"imagePullSecrets\": [" -}}
      {{ range $index, $element := . }}
        {{ if $index -}},{{- end -}}{ "name": {{ $element | quote }} }
      {{- end }}
      {{- "]," -}}
     {{- end -}}
  {{- else -}}
    {{- "\"imagePullSecrets\": []," -}}
  {{- end -}}
  {{- else -}}
    {{- "\"imagePullSecrets\": []," -}}
  {{- end -}}
{{- end -}}

{{/*
ImagePullPolicy template 
*/}}
{{- define "_imagePullPolicy" -}}
  {{- if .root.Values.global -}}
      {{- if .root.Values.global.imagePullPolicy -}}
        {{- .root.Values.global.imagePullPolicy -}}
      {{- else if .context -}}
          {{- if .context.imagePullPolicy  }}
           {{- .context.imagePullPolicy  }}
          {{- else if .root.Values.imagePullPolicy -}}
              {{- .root.Values.imagePullPolicy -}}
          {{- end -}}
      {{- else if .root.Values.imagePullPolicy -}}
          {{- .root.Values.imagePullPolicy -}}
      {{- end -}}
  {{- else if .context.imagePullPolicy -}}
      {{- .context.imagePullPolicy  }}
  {{- else if .root.Values.imagePullPolicy -}}
      {{- .root.Values.imagePullPolicy -}}
  {{- end -}}
{{- end -}}
{{- define "imagePullPolicy" -}}
  {{- if .context -}} 
    {{- template "_imagePullPolicy" dict "root" .root "context" .context | default "IfNotPresent" }}
  {{- else -}}
    {{- template "_imagePullPolicy" dict "root" .root "context" (dict) | default "IfNotPresent" }}
  {{- end -}}
{{- end -}}

{{/*  
HostNetwork template 
*/}}
{{- define "_hostNetwork" -}}
  {{- if .Values.global -}}
      {{- if .Values.global.hostNetwork -}}
        {{- .Values.global.hostNetwork -}}
      {{- else if .Values.hostNetwork -}}
          {{- .Values.hostNetwork -}}
      {{- end -}}
  {{- else if .Values.hostNetwork -}}
      {{- .Values.hostNetwork -}}
  {{- end -}}
{{- end -}}
{{- define "hostNetwork" -}}
  {{- include "_hostNetwork" . | default false }}
{{- end -}}

{{- define "admin_username_template" -}}
{{- if hasKey (index .Values "global") "onezoneMainAdmin" -}}
{{- (index .Values "global" "onezoneMainAdmin" "name") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "admin_password_template" -}}
{{- if hasKey (index .Values "global") "onezoneMainAdmin" -}}
{{- (index .Values "global" "onezoneMainAdmin" "password") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "onepanel_emergency_username_template" -}}
{{- if hasKey (index .Values "global") "onepanelEmergencyAccount" -}}
{{- (index .Values "global" "onepanelEmergencyAccount" "name") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

{{- define "onepanel_emergency_password_template" -}}
{{- if hasKey (index .Values "global") "onepanelEmergencyAccount" -}}
{{- (index .Values "global" "onepanelEmergencyAccount" "password") }}
{{- else -}}
{{- printf "%s" "UNINITIALIZED" }}
{{- end -}}
{{- end -}}

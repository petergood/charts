{{/* vim: set filetype=mustache: */}}

{{- define "json_quoted_list" -}}
  {{- if kindIs "slice" .list -}}
   {{- printf "-d \"'{ \\\"%s\\\": [ " .name -}}
   {{- range (initial .list) -}}
    {{- printf "\\\"%s\\\", " . -}}
   {{- end -}}
   {{- if .list -}}
    {{- printf "\\\"%s\\\" " (last .list) -}}
   {{- end -}}
   {{- printf "]}'\" " -}}
  {{- end -}}
{{- end -}}

{{- define "providerName" -}}
  {{- printf "%s-%s" "oneprovider" . | trimSuffix "-" -}}
{{- end -}}


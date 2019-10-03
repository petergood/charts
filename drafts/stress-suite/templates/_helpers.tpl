{{- define "groupingLabel" -}}
{{ if .Values.groupingLabel }}{{ .Values.groupingLabel }}{{ else }}{{ template "releaseName" . }}{{ end }}
{{- end -}}
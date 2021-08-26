{{/* This file is auto generated by gen_hosts.sh */}}

{{- define "volume-s3_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_s3_service_url -}}
    {{- if eq .Values.volume_s3_service_url.type "auto-generate" -}}
      {{- if .Values.volume_s3_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "k8s-service" -}}
      {{- if .Values.volume_s3_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_s3_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-s3" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-s3_service_url" -}}
  {{- if .Values.volume_s3_service_url -}}
    {{- if eq .Values.volume_s3_service_url.type "auto-generate" -}}
        {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_s3_service_url.type "k8s-service" -}}
      {{- if .Values.volume_s3_service_url.namespace -}}
        {{ .Values.volume_s3_service_url.service_name }}.{{ .Values.volume_s3_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_s3_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_s3_service_url.type "http" -}}
      {{ .Values.volume_s3_service_url.address }}
    {{- else -}}
      {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-s3_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-nfs_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_nfs_service_url -}}
    {{- if eq .Values.volume_nfs_service_url.type "auto-generate" -}}
      {{- if .Values.volume_nfs_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "k8s-service" -}}
      {{- if .Values.volume_nfs_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_nfs_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-nfs" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-nfs_service_url" -}}
  {{- if .Values.volume_nfs_service_url -}}
    {{- if eq .Values.volume_nfs_service_url.type "auto-generate" -}}
        {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_nfs_service_url.type "k8s-service" -}}
      {{- if .Values.volume_nfs_service_url.namespace -}}
        {{ .Values.volume_nfs_service_url.service_name }}.{{ .Values.volume_nfs_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_nfs_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_nfs_service_url.type "http" -}}
      {{ .Values.volume_nfs_service_url.address }}
    {{- else -}}
      {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-nfs_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-ceph_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_ceph_service_url -}}
    {{- if eq .Values.volume_ceph_service_url.type "auto-generate" -}}
      {{- if .Values.volume_ceph_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "k8s-service" -}}
      {{- if .Values.volume_ceph_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_ceph_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-ceph" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-ceph_service_url" -}}
  {{- if .Values.volume_ceph_service_url -}}
    {{- if eq .Values.volume_ceph_service_url.type "auto-generate" -}}
        {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_ceph_service_url.type "k8s-service" -}}
      {{- if .Values.volume_ceph_service_url.namespace -}}
        {{ .Values.volume_ceph_service_url.service_name }}.{{ .Values.volume_ceph_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_ceph_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_ceph_service_url.type "http" -}}
      {{ .Values.volume_ceph_service_url.address }}
    {{- else -}}
      {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-ceph_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-gluster_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_gluster_service_url -}}
    {{- if eq .Values.volume_gluster_service_url.type "auto-generate" -}}
      {{- if .Values.volume_gluster_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-gluster" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-gluster" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_gluster_service_url.type "k8s-service" -}}
      {{- if .Values.volume_gluster_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_gluster_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_gluster_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-gluster" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-gluster_service_url" -}}
  {{- if .Values.volume_gluster_service_url -}}
    {{- if eq .Values.volume_gluster_service_url.type "auto-generate" -}}
        {{ template "volume-gluster_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_gluster_service_url.type "k8s-service" -}}
      {{- if .Values.volume_gluster_service_url.namespace -}}
        {{ .Values.volume_gluster_service_url.service_name }}.{{ .Values.volume_gluster_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_gluster_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_gluster_service_url.type "http" -}}
      {{ .Values.volume_gluster_service_url.address }}
    {{- else -}}
      {{ template "volume-gluster_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-gluster_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-swift_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_swift_service_url -}}
    {{- if eq .Values.volume_swift_service_url.type "auto-generate" -}}
      {{- if .Values.volume_swift_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-swift" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-swift" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_swift_service_url.type "k8s-service" -}}
      {{- if .Values.volume_swift_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_swift_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_swift_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-swift" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-swift_service_url" -}}
  {{- if .Values.volume_swift_service_url -}}
    {{- if eq .Values.volume_swift_service_url.type "auto-generate" -}}
        {{ template "volume-swift_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_swift_service_url.type "k8s-service" -}}
      {{- if .Values.volume_swift_service_url.namespace -}}
        {{ .Values.volume_swift_service_url.service_name }}.{{ .Values.volume_swift_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_swift_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_swift_service_url.type "http" -}}
      {{ .Values.volume_swift_service_url.address }}
    {{- else -}}
      {{ template "volume-swift_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-swift_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-webdav_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_webdav_service_url -}}
    {{- if eq .Values.volume_webdav_service_url.type "auto-generate" -}}
      {{- if .Values.volume_webdav_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-webdav" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-webdav" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_webdav_service_url.type "k8s-service" -}}
      {{- if .Values.volume_webdav_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_webdav_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_webdav_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-webdav" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-webdav_service_url" -}}
  {{- if .Values.volume_webdav_service_url -}}
    {{- if eq .Values.volume_webdav_service_url.type "auto-generate" -}}
        {{ template "volume-webdav_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_webdav_service_url.type "k8s-service" -}}
      {{- if .Values.volume_webdav_service_url.namespace -}}
        {{ .Values.volume_webdav_service_url.service_name }}.{{ .Values.volume_webdav_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_webdav_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_webdav_service_url.type "http" -}}
      {{ .Values.volume_webdav_service_url.address }}
    {{- else -}}
      {{ template "volume-webdav_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-webdav_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "volume-dcache_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.volume_dcache_service_url -}}
    {{- if eq .Values.volume_dcache_service_url.type "auto-generate" -}}
      {{- if .Values.volume_dcache_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-dcache" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-dcache" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.volume_dcache_service_url.type "k8s-service" -}}
      {{- if .Values.volume_dcache_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.volume_dcache_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.volume_dcache_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "volume-dcache" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "volume-dcache_service_url" -}}
  {{- if .Values.volume_dcache_service_url -}}
    {{- if eq .Values.volume_dcache_service_url.type "auto-generate" -}}
        {{ template "volume-dcache_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.volume_dcache_service_url.type "k8s-service" -}}
      {{- if .Values.volume_dcache_service_url.namespace -}}
        {{ .Values.volume_dcache_service_url.service_name }}.{{ .Values.volume_dcache_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.volume_dcache_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.volume_dcache_service_url.type "http" -}}
      {{ .Values.volume_dcache_service_url.address }}
    {{- else -}}
      {{ template "volume-dcache_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "volume-dcache_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "oneprovider_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.oneprovider_service_url -}}
    {{- if eq .Values.oneprovider_service_url.type "auto-generate" -}}
      {{- if .Values.oneprovider_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "k8s-service" -}}
      {{- if .Values.oneprovider_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.oneprovider_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "oneprovider" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "oneprovider_service_url" -}}
  {{- if .Values.oneprovider_service_url -}}
    {{- if eq .Values.oneprovider_service_url.type "auto-generate" -}}
        {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.oneprovider_service_url.type "k8s-service" -}}
      {{- if .Values.oneprovider_service_url.namespace -}}
        {{ .Values.oneprovider_service_url.service_name }}.{{ .Values.oneprovider_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.oneprovider_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.oneprovider_service_url.type "http" -}}
      {{ .Values.oneprovider_service_url.address }}
    {{- else -}}
      {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "oneprovider_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "onezone_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.onezone_service_url -}}
    {{- if eq .Values.onezone_service_url.type "auto-generate" -}}
      {{- if .Values.onezone_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "k8s-service" -}}
      {{- if .Values.onezone_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.onezone_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "onezone" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "onezone_service_url" -}}
  {{- if .Values.onezone_service_url -}}
    {{- if eq .Values.onezone_service_url.type "auto-generate" -}}
        {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.onezone_service_url.type "k8s-service" -}}
      {{- if .Values.onezone_service_url.namespace -}}
        {{ .Values.onezone_service_url.service_name }}.{{ .Values.onezone_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.onezone_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.onezone_service_url.type "http" -}}
      {{ .Values.onezone_service_url.address }}
    {{- else -}}
      {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "onezone_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "saml-idp_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.saml_idp_service_url -}}
    {{- if eq .Values.saml_idp_service_url.type "auto-generate" -}}
      {{- if .Values.saml_idp_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "saml-idp" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "saml-idp" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.saml_idp_service_url.type "k8s-service" -}}
      {{- if .Values.saml_idp_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.saml_idp_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.saml_idp_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "saml-idp" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "saml-idp_service_url" -}}
  {{- if .Values.saml_idp_service_url -}}
    {{- if eq .Values.saml_idp_service_url.type "auto-generate" -}}
        {{ template "saml-idp_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.saml_idp_service_url.type "k8s-service" -}}
      {{- if .Values.saml_idp_service_url.namespace -}}
        {{ .Values.saml_idp_service_url.service_name }}.{{ .Values.saml_idp_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.saml_idp_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.saml_idp_service_url.type "http" -}}
      {{ .Values.saml_idp_service_url.address }}
    {{- else -}}
      {{ template "saml-idp_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "saml-idp_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "keycloak_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.keycloak_service_url -}}
    {{- if eq .Values.keycloak_service_url.type "auto-generate" -}}
      {{- if .Values.keycloak_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "keycloak" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "keycloak" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.keycloak_service_url.type "k8s-service" -}}
      {{- if .Values.keycloak_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.keycloak_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.keycloak_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "keycloak" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "keycloak_service_url" -}}
  {{- if .Values.keycloak_service_url -}}
    {{- if eq .Values.keycloak_service_url.type "auto-generate" -}}
        {{ template "keycloak_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.keycloak_service_url.type "k8s-service" -}}
      {{- if .Values.keycloak_service_url.namespace -}}
        {{ .Values.keycloak_service_url.service_name }}.{{ .Values.keycloak_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.keycloak_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.keycloak_service_url.type "http" -}}
      {{ .Values.keycloak_service_url.address }}
    {{- else -}}
      {{ template "keycloak_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "keycloak_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "luma_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.luma_service_url -}}
    {{- if eq .Values.luma_service_url.type "auto-generate" -}}
      {{- if .Values.luma_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "luma" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "luma" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.luma_service_url.type "k8s-service" -}}
      {{- if .Values.luma_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.luma_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.luma_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "luma" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "luma_service_url" -}}
  {{- if .Values.luma_service_url -}}
    {{- if eq .Values.luma_service_url.type "auto-generate" -}}
        {{ template "luma_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.luma_service_url.type "k8s-service" -}}
      {{- if .Values.luma_service_url.namespace -}}
        {{ .Values.luma_service_url.service_name }}.{{ .Values.luma_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.luma_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.luma_service_url.type "http" -}}
      {{ .Values.luma_service_url.address }}
    {{- else -}}
      {{ template "luma_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "luma_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "token-dispenser_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.token_dispenser_service_url -}}
    {{- if eq .Values.token_dispenser_service_url.type "auto-generate" -}}
      {{- if .Values.token_dispenser_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "token-dispenser" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "token-dispenser" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.token_dispenser_service_url.type "k8s-service" -}}
      {{- if .Values.token_dispenser_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.token_dispenser_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.token_dispenser_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "token-dispenser" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "token-dispenser_service_url" -}}
  {{- if .Values.token_dispenser_service_url -}}
    {{- if eq .Values.token_dispenser_service_url.type "auto-generate" -}}
        {{ template "token-dispenser_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.token_dispenser_service_url.type "k8s-service" -}}
      {{- if .Values.token_dispenser_service_url.namespace -}}
        {{ .Values.token_dispenser_service_url.service_name }}.{{ .Values.token_dispenser_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.token_dispenser_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.token_dispenser_service_url.type "http" -}}
      {{ .Values.token_dispenser_service_url.address }}
    {{- else -}}
      {{ template "token-dispenser_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "token-dispenser_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "openfaas_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values.openfaas_service_url -}}
    {{- if eq .Values.openfaas_service_url.type "auto-generate" -}}
      {{- if .Values.openfaas_service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "openfaas" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "openfaas" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values.openfaas_service_url.type "k8s-service" -}}
      {{- if .Values.openfaas_service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values.openfaas_service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values.openfaas_service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "openfaas" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "openfaas_service_url" -}}
  {{- if .Values.openfaas_service_url -}}
    {{- if eq .Values.openfaas_service_url.type "auto-generate" -}}
        {{ template "openfaas_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values.openfaas_service_url.type "k8s-service" -}}
      {{- if .Values.openfaas_service_url.namespace -}}
        {{ .Values.openfaas_service_url.service_name }}.{{ .Values.openfaas_service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values.openfaas_service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values.openfaas_service_url.type "http" -}}
      {{ .Values.openfaas_service_url.address }}
    {{- else -}}
      {{ template "openfaas_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "openfaas_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

{{- define "_name" -}}
  {{- $releaseName := .Release.Name | toString -}}
  {{- if .Values.global }}
    {{- $releaseName = default .Release.Name .Values.global.releaseNameOverride | toString -}}
  {{- end -}}
  {{- if .Values._service_url -}}
    {{- if eq .Values._service_url.type "auto-generate" -}}
      {{- if .Values._service_url.disableSuffix -}}
        {{- $suffix :=  "" | toString -}}
        {{- printf "%s-%s-%s" $releaseName "" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "" $suffix | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- else if eq .Values._service_url.type "k8s-service" -}}
      {{- if .Values._service_url.namespace -}}
        {{/* TODO */}}
      {{- else -}}
        {{ .Values._service_url.service_name }}
      {{- end -}}
    {{- else if eq .Values._service_url.type "http" -}}
      {{/* TODO */}}
    {{- end -}}
  {{- else -}}
        {{- $suffix := default "" .Values.suffix | toString -}}
        {{- printf "%s-%s-%s" $releaseName "" $suffix | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "_service_url" -}}
  {{- if .Values._service_url -}}
    {{- if eq .Values._service_url.type "auto-generate" -}}
        {{ template "_name" . }}.{{template "service_namespace_domain" . }}
    {{- else if eq .Values._service_url.type "k8s-service" -}}
      {{- if .Values._service_url.namespace -}}
        {{ .Values._service_url.service_name }}.{{ .Values._service_url.namespace }}.{{template "service_domain" . }}
      {{- else -}}
        {{ .Values._service_url.service_name }}.{{template "service_namespace_domain" .}}
      {{- end -}}
    {{- else if eq .Values._service_url.type "http" -}}
      {{ .Values._service_url.address }}
    {{- else -}}
      {{ template "_name" . }}.{{template "service_namespace_domain" . }}
    {{- end -}}
  {{- else -}}
      {{ template "_name" . }}.{{template "service_namespace_domain" . }}
  {{- end -}}
{{- end -}}

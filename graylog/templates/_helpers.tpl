{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "graylog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "graylog.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "graylog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the mariadb requirement.
*/}}
{{- define "graylog.mongodb" -}}
{{- $mongodbContext := dict "Values" .Values.mondodb "Release" .Release "Chart" (dict "Name" "mongodb") -}}
{{ template "mongodb.fullname" $mongodbContext }}
{{- end -}}

{{/*
Create a default fully qualified app name for the mariadb requirement.
*/}}
{{- define "graylog.elasticsearch" -}}
{{- $elasticsearchContext := dict "Values" .Values.elasticsearch "Release" .Release "Chart" (dict "Name" "elasticsearch") -}}
{{ template "elasticsearch.fullname" $elasticsearchContext }}
{{- end -}}


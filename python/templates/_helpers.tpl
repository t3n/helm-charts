{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "python.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "python.fullname" -}}
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
{{- define "python.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "python.labels" -}}
app: {{ include "python.name" . }}
chart: {{ include "python.chart" . }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{- define "python.selector" -}}
app: {{ include "python.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{/*
Create a default fully qualified app name for the redis requirement.
*/}}
{{- define "python.redis.fullname" -}}
{{- if .Values.redis.enabled -}}
{{- $redisContext := dict "Values" .Values.redis "Release" .Release "Chart" (dict "Name" "redis") -}}
{{ template "redis.fullname" $redisContext }}
{{- else -}}
{{- $redishaContext := dict "Values" (index .Values "redis-ha") "Release" .Release "Chart" (dict "Name" "redis-ha") -}}
{{ template "redis-ha.fullname" $redishaContext }}
{{- end -}}
{{- end -}}

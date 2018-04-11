{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "flow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flow.fullname" -}}
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
{{- define "flow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Default list of standard annotations for all deployments and statefulsets.
*/}}
{{- define "flow.annotations" }}
checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end -}}

{{/*
Create a default fully qualified app name for the redis requirement.
*/}}
{{- define "flow.redis" -}}
{{- $redisContext := dict "Values" .Values.redis "Release" .Release "Chart" (dict "Name" "redis") -}}
{{ template "redis.fullname" $redisContext }}
{{- end -}}

{{/*
Create a default fully qualified app name for the mariadb requirement.
*/}}
{{- define "flow.mariadb" -}}
{{- $mariadbContext := dict "Values" .Values.mariadb "Release" .Release "Chart" (dict "Name" "mariadb") -}}
{{ template "mariadb.fullname" $mariadbContext }}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "unms.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "unms.fullname" -}}
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
{{- define "unms.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the mysql requirement.
*/}}
{{- define "unms.mysqlFullname" -}}
{{- $mysqlContext := dict "Values" .Values.mysql "Release" .Release "Chart" (dict "Name" "mysql") -}}
{{ template "mysql.fullname" $mysqlContext }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "unms.labels" -}}
app.kubernetes.io/name: unms
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "unms.chart" . }}
app.kubernetes.io/component: app
app.kubernetes.io/part-of: {{ .Chart.Name }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "unms.selector" -}}
app.kubernetes.io/name: unms
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "unms.labels-nginx" -}}
app.kubernetes.io/name: nginx
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "unms.chart" . }}
app.kubernetes.io/component: proxy
app.kubernetes.io/part-of: {{ .Chart.Name }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "unms.selector-nginx" -}}
app.kubernetes.io/name: nginx
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

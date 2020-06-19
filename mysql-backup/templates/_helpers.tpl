{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mysql-backup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mysql-backup.fullname" -}}
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
{{- define "mysql-backup.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create filename
*/}}
{{- define "mysql-backup.filename" -}}
{{- if .Values.filename -}}
{{- .Values.filename -}}
{{- else if eq .Values.database.name "--all-databases" -}}
{{- "all" -}}
{{- else -}}
{{- .Values.database.name -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mysql-backup.labels" -}}
app.kubernetes.io/name: {{ include "mysql-backup.name" . }}
helm.sh/chart: {{ include "mysql-backup.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mysql-backup.selector" -}}
app.kubernetes.io/name: {{ include "mysql-backup.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

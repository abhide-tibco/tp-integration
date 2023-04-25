{{/*
Expand the name of the chart.
*/}}
{{- define "apiserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apiserver.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apiserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apiserver.labels" -}}
helm.sh/chart: {{ include "apiserver.chart" . }}
{{ include "apiserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apiserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
dp.integration.app/type: "service"
dp.integration.app/name: "apiserver"
dp.integration.app/instanceid: {{ .Values.global.cp.instanceId }}
dp.integration.app/dataplaneId: {{ .Values.global.cp.dataplaneId }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "apiserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "apiserver.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

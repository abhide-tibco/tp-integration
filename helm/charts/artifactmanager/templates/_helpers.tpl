{{/*
Expand the name of the chart.
*/}}
{{- define "artifactmanager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "artifactmanager.fullname" -}}
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
{{- define "artifactmanager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "artifactmanager.labels" -}}
helm.sh/chart: {{ include "artifactmanager.chart" . }}
{{ include "artifactmanager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "artifactmanager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "artifactmanager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
dp.integration.app/type: "capability"
dp.integration.capability/name: "artifactmanager"
dp.integration.capability/instanceId: {{ .Values.global.cp.instanceId }}
dp.integration.capability/dataplaneId: {{ .Values.global.cp.dataplaneId }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "artifactmanager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "artifactmanager.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get PVC name for persistent volume
*/}}
{{- define "artifactmanager.persistentVolumeClaim.claimName" -}}
{{- .existingClaim | default (printf "%s-%s" .releaseName .volumeName) -}}
{{- end -}}

{{/*
Integration storage folder pvc name
*/}}
{{- define "artifactmanager.storage.pvc.name" -}}
{{- include "artifactmanager.persistentVolumeClaim.claimName" (dict "existingClaim" .Values.volumes.artifactmanager.existingClaim "releaseName" ( include "artifactmanager.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}
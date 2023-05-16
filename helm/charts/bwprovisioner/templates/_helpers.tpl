{{/*
Expand the name of the chart.
*/}}
{{- define "bwprovisioner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bwprovisioner.fullname" -}}
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
{{- define "bwprovisioner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bwprovisioner.labels" -}}
helm.sh/chart: {{ include "bwprovisioner.chart" . }}
{{ include "bwprovisioner.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bwprovisioner.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bwprovisioner.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
integration.platform.tibco.com/appType: "capability"
platform.tibco.com/instanceID: {{ .Values.global.cp.instanceId }}
platform.tibco.com/dataplaneID: {{ .Values.global.cp.dataplaneId }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bwprovisioner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bwprovisioner.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get PVC name for persistent volume
*/}}
{{- define "bwprovisioner.persistentVolumeClaim.claimName" -}}
{{- .existingClaim | default (printf "%s-%s" .releaseName .volumeName) -}}
{{- end -}}

{{/*
Integration storage folder pvc name
*/}}
{{- define "bwprovisioner.storage.pvc.name" -}}
{{- include "bwprovisioner.persistentVolumeClaim.claimName" (dict "existingClaim" .Values.volumes.bwprovisioner.existingClaim "releaseName" ( include "bwprovisioner.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}

{{- define "bwprovisioner.cp.domain" }}cp-proxy.tibco-dp-{{ .Values.global.cp.dataplaneId }}.svc.cluster.local{{ end -}}

{{/*
    ===========================================================================
    SECTION: possible values for enumeration types in the global variables defined in values.yaml
    ===========================================================================
*/}}

{{/* Global variable: .Values.global.where. */}}
{{- define "dp-core-distributed-lock-operator.shared.global.where.local" }}local{{ end -}}
{{- define "dp-core-distributed-lock-operator.shared.global.where.aws" }}aws{{ end -}}
{{- define "dp-core-distributed-lock-operator.shared.global.where.azure" }}azure{{ end -}}
{{- define "dp-core-distributed-lock-operator.shared.global.where.hybrid" }}hybrid{{ end -}}

{{/* Global variable: .Values.global.scale. */}}
{{- define "dp-core-distributed-lock-operator.shared.global.scale.minimal" }}minimal{{ end -}}
{{- define "dp-core-distributed-lock-operator.shared.global.scale.production" }}production{{ end -}}

{{/* Global variable: .Values.global.security. */}}
{{- define "dp-core-distributed-lock-operator.shared.global.security.defaulted" }}defaulted{{ end -}}
{{- define "dp-core-distributed-lock-operator.shared.global.security.restricted" }}restricted{{ end -}}

{{/*
    ===========================================================================
    SECTION: labels
    ===========================================================================
*/}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "dp-core-distributed-lock-operator.shared.labels.chartLabelValue" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels used by the resources in this chart
*/}}
{{- define "dp-core-distributed-lock-operator.shared.labels.selector" -}}
app.kubernetes.io/name: {{ include "dp-core-distributed-lock-operator.consts.appName" . }}
app.kubernetes.io/component: {{ include "dp-core-distributed-lock-operator.consts.component" . }}
app.kubernetes.io/part-of: {{ include "dp-core-distributed-lock-operator.consts.team" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.cloud.tibco.com/owner: {{ .Values.global.who }}
{{- end -}}

{{/*
Standard labels added to all resources created by this chart.
Includes labels used as selectors (i.e. template "labels.selector")
*/}}
{{- define "dp-core-distributed-lock-operator.shared.labels.standard" -}}
{{ include  "dp-core-distributed-lock-operator.shared.labels.selector" . }}
app.cloud.tibco.com/created-by: {{ include "dp-core-distributed-lock-operator.consts.team" . }}
app.cloud.tibco.com/tenant-name: {{ include "dp-core-distributed-lock-operator.consts.tenantName" . }}
{{- /* COST LABEL -- If supplied and cost label set, cost label with tenant name as value will be added. */}}
{{- /*               If override is specified and cost allocation is set, cost allocation value will override tenant name. */}}
{{- if .Values.global.ownershipCostLabel }}
{{- if ne .Values.global.ownershipCostLabel "" }}
{{- if and .Values.global.ownershipCostAllocationTenantOverride .Values.global.ownershipCostAllocation }}
{{ .Values.global.ownershipCostLabel }}: "{{ .Values.global.ownershipCostAllocation }}"
{{- else }}
{{ .Values.global.ownershipCostLabel }}: {{ include "dp-core-distributed-lock-operator.consts.tenantName" . }}
{{- end }}
{{- end }}
{{- end }}
helm.sh/chart: {{ include "dp-core-distributed-lock-operator.shared.labels.chartLabelValue" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{/*
    ===========================================================================
    SECTION: general purpose functions
    ===========================================================================
*/}}

{{/* Global resource prefix. */}}
{{- define "dp-core-distributed-lock-operator.shared.func.globalResourcePrefix" -}}
{{ .Values.global.who }}-{{ include "dp-core-distributed-lock-operator.consts.appName" . }}-
{{- end -}}

{{/* Number of replicas computed depending on current value of .Values.global.scale */}}
{{- define "dp-core-distributed-lock-operator.shared.func.replicaCount" -}}
  {{- if .Values.highAvailabilityMode -}}
    {{- 2 -}}
  {{- else -}}
    {{- 1 -}}
  {{- end -}}
{{- end -}}


{{/* A fixed short name for the application. Can be different than the chart name */}}
{{- define "dp-core-distributed-lock-operator.consts.appName" }}distributed-lock-operator{{ end -}}

{{/* Tenant name. */}}
{{- define "dp-core-distributed-lock-operator.consts.tenantName" }}infrastructure{{ end -}}

{{/* Component we're a part of. */}}
{{- define "dp-core-distributed-lock-operator.consts.component" }}dataplane{{ end -}}

{{/* Team we're a part of. */}}
{{- define "dp-core-distributed-lock-operator.consts.team" }}cic-compute{{ end -}}

{{/* Namespace we're going into. */}}
{{- define "dp-core-distributed-lock-operator.consts.namespace" }}{{ .Values.global.who }}-tibco-system{{ end -}}

{{- define "dp-core-distributed-lock-operator.consts.webhook" }}{{ .Values.global.who }}-distributed-lock-operator-webhook{{ end -}}


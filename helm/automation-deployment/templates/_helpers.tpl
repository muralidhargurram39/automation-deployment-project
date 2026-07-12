{{/*
===============================================================================
Chart Name
===============================================================================
*/}}

{{- define "automation-deployment.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
===============================================================================
Full Deployment Name
===============================================================================
*/}}

{{- define "automation-deployment.fullname" -}}
{{ .Values.deployment.name }}
{{- end }}

{{/*
===============================================================================
Chart Version
===============================================================================
*/}}

{{- define "automation-deployment.chart" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end }}

{{/*
===============================================================================
Namespace
===============================================================================
*/}}

{{- define "automation-deployment.namespace" -}}
{{ .Values.namespace }}
{{- end }}

{{/*
===============================================================================
Deployment Name
===============================================================================
*/}}

{{- define "automation-deployment.deployment" -}}
{{ .Values.deployment.name }}
{{- end }}

{{/*
===============================================================================
Service Name
===============================================================================
*/}}

{{- define "automation-deployment.service" -}}
{{ .Values.service.name }}
{{- end }}

{{/*
===============================================================================
ConfigMap Name
===============================================================================
*/}}

{{- define "automation-deployment.configmap" -}}
{{ .Values.configMap.name }}
{{- end }}

{{/*
===============================================================================
Secret Name
===============================================================================
*/}}

{{- define "automation-deployment.secret" -}}
{{ .Values.secretRef.name }}
{{- end }}

{{/*
===============================================================================
Docker Image
===============================================================================
*/}}

{{- define "automation-deployment.image" -}}
{{ .Values.image.registry }}/{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag }}
{{- end }}

{{/*
===============================================================================
Selector Labels
===============================================================================
*/}}

{{- define "automation-deployment.selectorLabels" -}}
app: {{ .Values.deployment.name }}
{{- end }}

{{/*
===============================================================================
Common Labels
===============================================================================
*/}}

{{- define "automation-deployment.labels" -}}
app: {{ .Values.deployment.name }}
app.kubernetes.io/name: {{ include "automation-deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "automation-deployment.chart" . }}
{{- end }}

{{- define "kafka-kraft.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-kraft.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "kafka-kraft.name" . -}}
{{- end -}}
{{- end -}}

{{- define "kafka-kraft.labels" -}}
app: {{ default "kafka" .Values.labels.app | quote }}
purpose: {{ default "kafka-deployment" .Values.labels.purpose | quote }}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: "{{ .Release.Name }}"
heritage: "Helm"
{{- end -}}

{{- define "kafka-kraft.headlessFQDN" -}}
{{- $fullname := include "kafka-kraft.fullname" . -}}
{{- printf "%s-headless.%s.svc.%s" $fullname .Release.Namespace (.Values.clusterDomain | default "cluster.local") -}}
{{- end -}}

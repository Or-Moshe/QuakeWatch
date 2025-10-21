{{- define "quake-watch-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "quake-watch-app.fullname" -}}
{{- printf "%s-%s" (include "quake-watch-app.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "quake-watch-app.selectorLabels" -}}
app: {{ include "quake-watch-app.name" . }}
{{- end }}

{{- define "quake-watch-app.labels" -}}
app: {{ include "quake-watch-app.name" . }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end }}

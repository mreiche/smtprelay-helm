# smtprelay

Minimal Helm chart for [decke/smtprelay](https://github.com/decke/smtprelay) using the image built from this repository (`mreiche/smtprelay`).

## Values

| Key | Default | Description |
| --- | --- | --- |
| `replicaCount` | `1` | Stateless replicas |
| `image.repository` | `mreiche/smtprelay` | Container image |
| `image.tag` | `""` | Defaults to `Chart.appVersion` (`1.14.0`) |
| `image.pullPolicy` | `IfNotPresent` | Image pull policy |
| `service.type` | `ClusterIP` | Service type |
| `service.port` | `2525` | Service and container listen port |
| `config.listen` | `0.0.0.0:{{ .Values.service.port }}` | INI listen address (must not stay on localhost) |
| `config.allowed_nets` | RFC1918 CIDRs | Networks allowed to submit mail |
| `config.log_level` | `info` | Log level |
| `config.hostname` | `{{ .Release.Name }}` | Relay hostname |
| `config.remotes` | `"starttls://user:pass@server:587?skipVerify"` | Remotes configuration |
| `resources` | `{}` | Container resources. |
| `livenessProbe` / `readinessProbe` | TCP on `smtp` | Probes against the listen port |
| `securityContext` | `{}` | Container security context |

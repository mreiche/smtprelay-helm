# smtprelay

Minimal Helm chart for [decke/smtprelay](https://github.com/decke/smtprelay) using the image built from this repository (`mreiche/smtprelay`).

## Values

| Key | Default | Description |
| --- | --- | --- |
| `replicaCount` | `1` | Stateless replicas. |
| `image.repository` | `mreiche/smtprelay` | Container image. |
| `image.tag` | `""` | Defaults to `Chart.appVersion` (`1.14.0`). |
| `image.pullPolicy` | `IfNotPresent` | Image pull policy. |
| `service.type` | `ClusterIP` | Service type. |
| `service.port` | `2525` | Service and container listen port. |
| `config.listen` | `0.0.0.0:{{ .Values.service.port }}` | INI listen address (must not stay on localhost). |
| `config.allowed_nets` | RFC1918 CIDRs | Networks allowed to submit mail. |
| `config.log_level` | `info` | Log level. |
| `config.hostname` | `""` | Omitted from the INI when empty. |
| `remote_host` | "smarthost.example.com" | Smarthost FQDN |
| `remote_auth` | "login" | Authentication method for the smarthost. |
| `remoteUser` / `remotePass` | `""` | Optional values stored as `REMOTE_USER` / `REMOTE_PASS` in the generated Secret. Prefer `existingSecret` for sensitive values. |
| `existingSecret` | `""` | Use this Secret instead of generating one; it must contain the configured remotes key plus `REMOTE_USER` and `REMOTE_PASS`. |
| `resources` | `{}` | Container resources. |
| `livenessProbe` / `readinessProbe` | TCP on `smtp` | Probes against the listen port. |
| `securityContext` | `{}` | Container security context. |

Additional keys from `config` are written as `key = value` lines in `smtprelay.ini`. Do not put `remotes` in `config`.
The upstream `smtprelay` application uses credentials embedded in the `remotes` URL and does not consume `REMOTE_USER` or `REMOTE_PASS`; the two environment variables are provided for integrations that require them.

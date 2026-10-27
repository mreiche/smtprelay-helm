FROM golang:1.25-bookworm AS build

ARG SMTPRELAY_VERSION=v1.14.0
ARG HTTPS_PROXY=""
ARG HTTP_PROXY=""

WORKDIR /build_dir

RUN https_proxy="${HTTPS_PROXY}" \
    http_proxy="${HTTP_PROXY}" \
    curl -fsSL "https://github.com/decke/smtprelay/archive/refs/tags/${SMTPRELAY_VERSION}.tar.gz" -o src.tar.gz \
    && tar -xzf src.tar.gz --strip-components=1 \
    && rm src.tar.gz \
    && CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o smtprelay .

FROM alpine:3.24.3

ARG HTTPS_PROXY=""
ARG HTTP_PROXY=""

RUN https_proxy="${HTTPS_PROXY}" \
  http_proxy="${HTTP_PROXY}" \
  apk update \
  && apk add ca-certificates \
  && rm -rf /var/cache/apk/* \
  && update-ca-certificates

COPY --from=build /build_dir/smtprelay /usr/local/bin/smtprelay
USER guest
# users need to mount config file at /usr/local/smtprelay.ini
ENTRYPOINT ["/usr/local/bin/smtprelay"]

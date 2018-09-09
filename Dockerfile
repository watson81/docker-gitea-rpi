FROM resin/armhf-alpine:latest

EXPOSE 22 3000

ENV USER git
ENV GITEA_CUSTOM /data/gitea
ENV GODEBUG=netdns=go

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]

RUN [ "cross-build-start" ]

## GITEA RELEASE VERSION
ARG VERSION=1.4.3

RUN apk --no-cache upgrade && \
    apk --no-cache add \
      su-exec \
      ca-certificates \
      sqlite \
      bash \
      git \
      subversion \
      linux-pam \
      s6 \
      curl \
      openssh \
      tzdata
RUN addgroup \
    -S -g 1000 \
    git && \
  adduser \
    -S -H -D \
    -h /data/git \
    -s /bin/bash \
    -u 1000 \
    -G git \
    git && \
  echo "git:$(dd if=/dev/urandom bs=24 count=1 status=none | base64)" | chpasswd

## GET DOCKER FILES
RUN svn export https://github.com/go-gitea/gitea/trunk/docker ./ --force

## GET GITEA
RUN mkdir -p /app/gitea && \
    curl -SLo /app/gitea/gitea https://github.com/go-gitea/gitea/releases/download/v$VERSION/gitea-$VERSION-linux-arm-7 && \
    chmod 0755 /app/gitea/gitea

RUN [ "cross-build-end" ]

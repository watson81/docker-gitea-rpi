FROM balenalib/armv7hf-alpine:latest

EXPOSE 22 3000

ENV USER git
ENV GITEA_CUSTOM /data/gitea
ENV GODEBUG=netdns=go

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/entry.sh", "/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]

RUN [ "cross-build-start" ]

## GITEA RELEASE VERSION
ARG VERSION=1.10.2

RUN install_packages \
      su-exec \
      ca-certificates \
      sqlite \
      bash \
      git \
      linux-pam \
      s6 \
      curl \
      gettext \
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

## GET GITEA-DOCKER FILES
RUN curl -SL  https://github.com/go-gitea/gitea/archive/v$VERSION.tar.gz | \
    tar xz gitea-$VERSION/docker --exclude=gitea-$VERSION/docker/Makefile --strip-components=3

## GET GITEA
RUN mkdir -p /app/gitea && \
    curl -SLo /app/gitea/gitea https://github.com/go-gitea/gitea/releases/download/v$VERSION/gitea-$VERSION-linux-arm-6 && \
    chmod 0755 /app/gitea/gitea

RUN [ "cross-build-end" ]

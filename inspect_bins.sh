#!/usr/bin/env bash

if [[ $1 =~ ^[[:digit:]] ]] ; then
  IMAGE="patrickthedev/gitea-rpi:$1"
elif [[ $1 =~ ^patrickthedev/gitea-rpi ]] ; then
  IMAGE="$1"
else
  printf "[\e[1;31mERROR\e[0m] Unrecognized image specifier: \e[36m%s\e[0m\n" "$1"
  exit 1
fi

docker inspect "${IMAGE}" | jq -r '.[0] | "ARCH=" + .Architecture, "VARIANT=" + .Variant'
docker run --rm "${IMAGE}" sh -c 'apk add file >/dev/null && file /usr/local/bin/environment-to-ini /app/gitea/gitea'

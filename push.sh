#!/bin/sh

set -e # Exit on error

if [ "$#" -lt "1" ]; then
  echo "[ERROR] Must provide target version as parameter"
  exit 1
fi

REPO="patrickthedev/gitea-rpi"
VERSION="$1"

#echo "Pushing ${REPO}:${VERSION}"
#docker push "${REPO}:${VERSION}"

for tag in "$@"; do
  echo "Pushing ${REPO}:${VERSION} as ${REPO}:${tag}"
  if [ "${VERSION}" != "${tag}" ]; then
    docker tag "${REPO}:${VERSION}" "${REPO}:${tag}"
  fi
  docker push "${REPO}:${tag}"
done

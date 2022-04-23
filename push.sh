#!/bin/sh

set -e # Exit on error

if [ "$#" -lt "1" ]; then
  echo "[ERROR] Must provide target version as parameter"
  exit 1
fi

BUILD_REPO="patrickthedev/gitea-rpi"
REPOS="patrickthedev/gitea-rpi ghcr.io/watson81/gitea-rpi"
VERSION="$1"

for REPO in ${REPOS}; do
  for tag in "$@"; do
    echo "Pushing ${BUILD_REPO}:${VERSION} as ${REPO}:${tag}"
    if [ "${BUILD_REPO}/${VERSION}" != "${REPO}/${tag}" ]; then
      docker tag "${BUILD_REPO}:${VERSION}" "${REPO}:${tag}"
    fi
    docker push "${REPO}:${tag}"
  done
done
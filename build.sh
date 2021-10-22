#!/bin/sh

set -e # Exit on error

if [ "$#" -ne "1" ]; then
  echo "[ERROR] Must provide target version as parameter"
  exit 1
fi

REPO="patrickthedev/gitea-rpi"
VERSION="$1"

if [ "$(docker images -q ${REPO}:${VERSION} 2> /dev/null)" != "" ]; then
  echo "[ERROR] Image already exists"
  exit 2
fi

set -x
docker build --pull --tag "${REPO}:${VERSION}" --build-arg "VERSION=${VERSION}" --file "Dockerfile.$(uname -m)" .
echo "[INFO] Build Complete. Validate version:"
docker run --rm "${REPO}:${VERSION}" /app/gitea/gitea --version

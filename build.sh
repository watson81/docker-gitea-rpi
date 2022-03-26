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

docker build --pull --tag "${REPO}:${VERSION}" --build-arg "VERSION=${VERSION}" --file "Dockerfile.$(uname -m)" .

printf "\n[\e[1;34mINFO\e[0m] Build Complete. \e[1;36mValidate version=%s\e[0m:\n" "${VERSION}"
docker run --rm "${REPO}:${VERSION}" /app/gitea/gitea --version

printf "\n[\e[1;34mINFO\e[0m] Build Complete. \e[1;36mValidate startup & HTTP Port 9999\e[0m:\n"
docker run --rm -it -e GITEA__SERVER__HTTP_PORT=9999 "${REPO}:${VERSION}"

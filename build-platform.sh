#!/usr/bin/env bash

set -e # Exit on error

if [ "$#" -lt "2" ]; then
  printf "[\e[1;31mERROR\e[0m] Must provide target version and platform as parameter\n"
  exit 1
fi

VERSION="$1"
TARGET_PLATFORM="$2"
EXTRA_VERSION="$3"

case ${TARGET_PLATFORM,,} in
  "arm/v6")
    GOARM="6"
    UNAME_ARCH="armv6l"
    GITEA_ARCH="arm-6"
    ;;
  "arm/v7" | "arm")
    GOARM="7"
    UNAME_ARCH="armv7l"
    GITEA_ARCH="arm-6"
    ;;
  "arm64")
    GOARM=""
    UNAME_ARCH="arm64"
    GITEA_ARCH="arm64"
    ;;
  *)
    printf "[\e[1;31mERROR\e[0m] Unsupported architecture: \e[36m%s\e[0m\n" "$TARGET_PLATFORM"
    exit
    ;;
esac

REPO="patrickthedev/gitea-rpi"
TAG="${REPO}:${VERSION}${EXTRA_VERSION}-${UNAME_ARCH}"

if [ "$(docker images -q "${TAG}" 2> /dev/null)" != "" ]; then
  printf "[\e[1;31mERROR\e[0m] Image \e[36m%s\e[0m already exists\n" "${TAG}"
  exit 2
fi

printf "\n[\e[1;34mINFO\e[0m] Building Gitea \e[36m%s\e[0m into \e[36m%s\e[0m\n" "${VERSION}" "${TAG}"
docker build --platform="linux/${TARGET_PLATFORM}" --pull --tag "${TAG}" --build-arg "VERSION=${VERSION}" --build-arg "GOARM=${GOARM}" --build-arg "GITEA_ARCH=${GITEA_ARCH}" --file "Dockerfile.${UNAME_ARCH}" .

printf "\n[\e[1;34mINFO\e[0m] Build Complete. \e[1;36mValidate Platform=%s\e[0m:\n" "${TARGET_PLATFORM}"
./inspect_bins.sh "${TAG}"

printf "\n[\e[1;34mINFO\e[0m] Build Complete. \e[1;36mValidate version=%s\e[0m:\n" "${VERSION}"
docker run --rm "${TAG}" /app/gitea/gitea --version

printf "\n[\e[1;34mINFO\e[0m] Build Complete. \e[1;36mValidate startup & HTTP Port 9999\e[0m:\n"
docker run --rm -it -e GITEA__SERVER__HTTP_PORT=9999 "${TAG}"

echo "got to end"
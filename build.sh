#!/bin/sh

set -e # Exit on error

if [ "$#" -lt "1" ]; then
  printf "[\e[1;31mERROR\e[0m] Must provide target version as parameter\n"
  exit 1
fi

VERSION="$1"
EXTRA_VERSION="$2"
TARGET_PLATFORMS="arm/v6 arm/v7 arm64"

printf "\n[\e[1;34mINFO\e[0m] Building Gitea \e[36m%s\e[0m into platforms \e[36m%s\e[0m\n" "${VERSION}" "${TARGET_PLATFORMS}"

for TARGET_PLATFORM in ${TARGET_PLATFORMS} ; do
  ./build-platform.sh "${VERSION}" "${TARGET_PLATFORM}" "${EXTRA_VERSION}"
done

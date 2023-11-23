#!/usr/bin/env bash

MIN_MAJOR=1
MAX_MAJOR=1
MIN_MINOR=5
MAX_MINOR=25
MIN_PATCH=0
MAX_PATCH=15

IMAGES="patrickthedev/gitea-rpi ghcr.io/watson81/gitea-rpi"

# Start with tags in non-standard form
TAGS="latest stable 1.5.1-1 1.5.3-1 1.6.3-1 1.7.0rc2 1.7.5-1 1.8.0rc2 1.8.0rc3 1.9.0rc2"

for ((major=MIN_MAJOR; major<=MAX_MAJOR; major++))
do
    for ((minor=MIN_MINOR; minor<=MAX_MINOR; minor++))
    do
        TAGS="${TAGS} latest-${major}.${minor}"
        for ((patch=MIN_PATCH; patch<=MAX_PATCH; patch++))
        do
            TAGS="${TAGS} ${major}.${minor}.${patch}"
        done
    done
done

for image in ${IMAGES}
do
    for tag in ${TAGS}
    do
        echo "Deleting local ${image}:${tag}"
        docker rmi "${image}:${tag}" 2>/dev/null
    done
done

echo Pulling all images
for image in ${IMAGES}
do
    docker pull -a "${image}"
done

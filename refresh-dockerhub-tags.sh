#!/usr/bin/env sh

STD_TAGS="latest stable"
TAGS_13="latest-1.13        1.13.1 1.13.2 1.13.3 1.13.4"
TAGS_12="latest-1.12 1.12.0 1.12.1 1.12.2 1.12.3 1.12.4"
TAGS_11="latest-1.11 1.11.0 1.11.1 1.11.2 1.11.3 1.11.4 1.11.5 1.11.6 1.11.7 1.11.8"
TAGS_10="latest-1.10        1.10.1 1.10.2 1.10.3 1.10.4 1.10.5 1.10.6"
TAGS_09="latest-1.9  1.9.0rc2 1.9.0 1.9.6"
TAGS_08="latest-1.8  1.8.0rc2 1.8.0rc3 1.8.0 1.8.1 1.8.2 1.8.3"
TAGS_07="latest-1.7  1.7.0rc2 1.7.4 1.7.5 1.7.5-1 1.7.6"
TAGS_06="latest-1.6  1.6.3-1"
TAGS_05="latest-1.5  1.5.1-1 1.5.3-1"
TAGS="${STD_TAGS} ${TAGS_13} ${TAGS_12} ${TAGS_11} ${TAGS_10} ${TAGS_09} ${TAGS_08} ${TAGS_07} ${TAGS_06} ${TAGS_05}"
docker pull -a "patrickthedev/gitea-rpi"
# for t in $TAGS
# do
#     docker pull "patrickthedev/gitea-rpi:${t}"
# done
for t in $TAGS
do
    docker rmi  "patrickthedev/gitea-rpi:${t}"
done

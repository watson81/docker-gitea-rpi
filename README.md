# Gitea on Raspberry Pi
This image hosts [Gitea](https://gitea.io) in a Raspberry Pi docker image of minimal size, yet fully functional.

This work is a fork of [kapdap/gitea-rpi](https://hub.docker.com/r/kapdap/gitea-rpi), but with a slightly smaller image.

This image is available in both [Docker Hub](https://hub.docker.com/r/patrickthedev/gitea-rpi) and [Github Container Registery](https://github.com/watson81/docker-gitea-rpi/pkgs/container/gitea-rpi).

## Tags
|Tag Style|Meaning|
|--|--|
|latest|Will always contain the newest image|
|latest-x.x|Will contain the newest image limited to Gitea version x.x. Use this if you want to take security updates but no new features. For example, latest-1.16 changes from Gitea 1.16.4 to 1.16.5 to 1.16.6 over time, but it will never point to Gitea 1.17 or newer.|
|stable|Will contain the newest stable image|
|x.x.x|Contains image with Gitea version x.x.x.

## Usage
```bash
docker volume create gitea_data
docker run -d -p 22:22 -p 3000:3000 -v gitea_data:/data patrickthedev/gitea-rpi:latest
# OR
docker run -d -p 22:22 -p 3000:3000 -v gitea_data:/data ghcr.io/watson81/gitea-rpi:latest
```

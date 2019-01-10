# Gitea on Raspberry Pi
This image hosts [Gitea](https://gitea.io) in a Raspberry Pi docker image of minimal size, yet fully functional.

This work is a fork of [kapdap/gitea-rpi](https://hub.docker.com/r/kapdap/gitea-rpi), but with a slightly smaller image.

## Tags
|Tag Style|Meaning|
|--|--|
|latest|Will always contain the newest image|
|latest-x.x|Will contain the newest image limited to Gitea version x.x. Use this if you want to take security updates but no new features.|
|stable|Will contain the newest stable image|
|x.x.x-y|Contains image version y with Gitea version x.x.x.

## Usage
```bash
docker volume create gitea_data
docker run -d -p 22:22 -p 3000:3000 -v gitea_data:/data patrickthedev/gitea-rpi
```

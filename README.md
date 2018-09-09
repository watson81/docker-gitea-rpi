## Gitea Raspberry Pi Docker Image (arm7l)

This repository contains the image for a Gitea container for use on a Raspberry Pi.
The image uses the official Gitea arm7l build.

```bash
docker volume create gitea_data
docker run -d -p 22:22 -p 3000:3000 -v gitea_data:/data patrickthedev/gitea-rpi
```

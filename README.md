# docker-aria2

[![Docker Pulls](https://img.shields.io/docker/pulls/qiujun8023/aria2)](https://hub.docker.com/r/qiujun8023/aria2)
[![Docker Image Version](https://img.shields.io/docker/v/qiujun8023/aria2/latest)](https://hub.docker.com/r/qiujun8023/aria2/tags)

Docker image for [aria2](https://github.com/aria2/aria2), built from the Alpine package, supports `linux/amd64` and `linux/arm64`. Checked daily and rebuilt whenever aria2 or any of its Alpine dependencies is updated.

## Usage

The image runs `aria2c --conf-path=/config/aria2.conf`. Put your `aria2.conf` in `/config`, and create any session file it references before starting.

### Docker

```bash
docker run -d -p 6800:6800 -v ./config:/config -v ./downloads:/downloads qiujun8023/aria2
```

### Docker Compose

```yaml
services:
  aria2:
    image: qiujun8023/aria2
    user: "1000:1000"
    ports:
      - "6800:6800"
    volumes:
      - ./config:/config
      - ./downloads:/downloads
    restart: unless-stopped
```

Pair it with [qiujun8023/ariang](https://github.com/qiujun8023/docker-ariang) for a web UI.

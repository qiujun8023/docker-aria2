# docker-aria2

[![Docker Pulls](https://img.shields.io/docker/pulls/qiujun8023/aria2)](https://hub.docker.com/r/qiujun8023/aria2)
[![Docker Image Version](https://img.shields.io/docker/v/qiujun8023/aria2/latest)](https://hub.docker.com/r/qiujun8023/aria2/tags)

Docker image for [aria2](https://github.com/aria2/aria2), built from the Alpine package, supports `linux/amd64` and `linux/arm64`. Checked daily and rebuilt whenever aria2 or any of its Alpine dependencies is updated.

## Tags

- `latest`: the most recent build.
- `<version>` (e.g. `1.37.0`): the aria2 version. It is rebuilt when Alpine updates aria2's package or its dependencies, so the same tag may point to a newer image over time.

## Configuration

The image runs `aria2c --conf-path=/config/aria2.conf` and ships no default config. Create `config/aria2.conf` before starting, for example:

```ini
enable-rpc=true
rpc-listen-all=true
rpc-secret=change-me
dir=/downloads
continue=true
input-file=/config/aria2.session
save-session=/config/aria2.session
save-session-interval=10
dht-file-path=/config/dht.dat
dht-file-path6=/config/dht6.dat
```

aria2 fails to start when `input-file` does not exist, so create an empty session file as well:

```bash
mkdir -p config downloads
touch config/aria2.session
```

Always set `rpc-secret` when the RPC port is reachable from outside: without it, anyone who can reach port 6800 can control your downloads.

## Usage

Both examples run as uid/gid `1000`; `config` and `downloads` must be writable by that user.

### Docker

```bash
docker run -d --user 1000:1000 -p 6800:6800 \
  -v ./config:/config -v ./downloads:/downloads \
  qiujun8023/aria2
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

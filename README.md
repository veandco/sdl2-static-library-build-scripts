# Go-SDL2 Static Library Build Scripts

This contains scripts used to build static libraries used by go-sdl2. Currently, the scripts assume Ubuntu as the host operating system.

## Setup

First I clone the repository and then I use Podman to run Ubuntu 20.04 LTS container like below. However if you are already on Ubuntu 20.04 LTS, you could choose to skip running the container.

```
git clone https://github.com/veandco/sdl2-static-library-build-scripts
cd sdl2-static-library-build-scripts
podman run -it -v .:/opt --name sdl2 ubuntu:20.04 bash
cd /opt
./setup.sh
```

## Build

```
./build.sh
```

## Using Docker

```
docker compose run sdl_builder /bin/bash
./build.sh
```
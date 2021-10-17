#!/usr/bin/env bash

TARGET="x86_64-linux-gnu"
LIBDIR=build/.libs
ARCH=linux_amd64

mkdir -p .go-sdl2-libs/include/SDL2

./common-${ARCH}.sh

cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_${ARCH}.h

cd ..

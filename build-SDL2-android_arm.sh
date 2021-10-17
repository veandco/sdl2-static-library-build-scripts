#!/usr/bin/env bash

export TARGET="arm-linux-androideabi"
export LIBDIR=build/.libs

./common-${ARCH}.sh
cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2/
cp include/SDL_config.h .go-sdl2-libs/include/SDL2/SDL_config_${ARCH}.h

cd ..
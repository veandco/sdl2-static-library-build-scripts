#!/usr/bin/env bash

export TARGET="i686-w64-mingw32"
export LIBDIR=build/.libs


./common-${ARCH}.sh --host=${TARGET}
cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2/
cp include/SDL_config.h .go-sdl2-libs/include/SDL2/SDL_config_${ARCH}.h

cd ..

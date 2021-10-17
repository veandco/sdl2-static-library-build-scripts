#!/usr/bin/env bash

export TARGET="x86_64-apple-darwin15"
export LIBDIR=build/.libs
export OSXCROSS="$PWD/osxcross"

./common-${ARCH}.sh --host=${TARGET}
cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2/
cp include/SDL_config.h .go-sdl2-libs/include/SDL2/SDL_config_${ARCH}.h

cd ..

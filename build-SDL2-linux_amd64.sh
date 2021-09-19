#!/usr/bin/env bash

TARGET="x86_64-linux-gnu"
LIBDIR=build/.libs

cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-amd64 2> /dev/null



mkdir -p build-linux-amd64 && cd build-linux-amd64
../configure --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
strip ${LIBDIR}/libSDL2.a
ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_linux_amd64.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_linux_amd64.h

cd ..

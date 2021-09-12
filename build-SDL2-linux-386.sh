#!/usr/bin/env bash

TARGET="i686-linux-gnu"
SDL2_VERSION=2.0.16
LIBDIR=build/.libs

cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-linux-386 2> /dev/null
export CC="gcc -m32"
export CXX="g++ -m32"

mkdir -p build-linux-386 && cd build-linux-386
../configure --prefix="$HOME/.${TARGET}" --host="${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
strip ${LIBDIR}/libSDL2.a
ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_linux_386.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_linux_386.h

cd ..

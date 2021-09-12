#!/usr/bin/env bash

TARGET="i686-w64-mingw32"
SDL2_VERSION=2.0.16
LIBDIR=build/.libs

cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-windows-386 2> /dev/null
export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"
export RC="${TARGET}-windres"
mkdir -p build-windows-386 && cd build-windows-386
../configure --host=${TARGET} --prefix="$HOME/.local/${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
${TARGET}-strip ${LIBDIR}/libSDL2.a
${TARGET}-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_windows_386.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_windows_386.h

cd ..

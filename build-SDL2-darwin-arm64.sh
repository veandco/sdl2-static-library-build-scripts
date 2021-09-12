#!/usr/bin/env bash

TARGET="arm64-apple-darwin20.2"
CLANG_HOST="arm-apple-darwin20.2"
SDL2_VERSION=2.0.16
LIBDIR=build/.libs

cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-darwin-arm64 2> /dev/null
OSXCROSS="$PWD/osxcross"
SDK_VERSION=11.1
DARWIN="${HOME}/Downloads/Source/osxcross/target"
DARWIN_SDK="${DARWIN}/SDK/MacOSX${SDK_VERSION}.sdk"
OSXCROSS_PKG_CONFIG="${TARGET}-pkg-config"
OSXCROSS_PKG_CONFIG_PATH="${DARWIN_SDK}/lib/pkgconfig"
export PATH="${DARWIN}/bin:${DARWIN_SDK}/usr/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/lib -mmacosx-version-min=10.10"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
mkdir -p build-darwin-arm64 && cd build-darwin-arm64
../configure --host=${CLANG_HOST} --prefix="${DARWIN_SDK}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
${TARGET}-strip -x ${LIBDIR}/libSDL2.a
${TARGET}-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a.strip ../.go-sdl2-libs/libSDL2_darwin_arm64.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_darwin_arm64.h

cd ..

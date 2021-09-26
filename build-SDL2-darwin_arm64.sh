#!/usr/bin/env bash

TARGET="aarch64-apple-darwin20.4"
LIBDIR=build/.libs
OSXCROSS="$PWD/osxcross"


cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-darwin-arm64 2> /dev/null
SDK_VERSION=11.3
DARWIN="${OSXCROSS}/target"
DARWIN_SDK="${DARWIN}/SDK/MacOSX${SDK_VERSION}.sdk"
#OSXCROSS_PKG_CONFIG="${TARGET}-pkg-config"
#OSXCROSS_PKG_CONFIG_PATH="${DARWIN_SDK}/lib/pkgconfig"
export PATH="${DARWIN}/bin:${DARWIN_SDK}/usr/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/lib -mmacosx-version-min=11.0"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
mkdir -p build-darwin-arm64 && cd build-darwin-arm64
../configure --host=${TARGET} --prefix="${DARWIN_SDK}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
${TARGET}-strip -x ${LIBDIR}/libSDL2.a
${TARGET}-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_darwin_arm64.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_darwin_arm64.h

cd ..

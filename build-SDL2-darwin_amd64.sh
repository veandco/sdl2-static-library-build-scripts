#!/usr/bin/env bash

TARGET="x86_64-apple-darwin15"
LIBDIR=build/.libs
OSXCROSS="$PWD/osxcross"


cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-darwin-amd64 2> /dev/null
SDK_VERSION=11.3
DARWIN="${OSXCROSS}/target"
DARWIN_SDK="${DARWIN}/target/SDK/MacOSX${SDK_VERSION}.sdk"


export PATH="${DARWIN}/bin:${DARWIN_SDK}/usr/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/lib -mmacosx-version-min=10.10"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
mkdir -p build-darwin-amd64 && cd build-darwin-amd64
../configure --host=${TARGET} --prefix="${DARWIN_SDK}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
${TARGET}-strip -x ${LIBDIR}/libSDL2.a
${TARGET}-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_darwin_amd64.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_darwin_amd64.h

cd ..

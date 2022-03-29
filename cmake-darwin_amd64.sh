#!/usr/bin/env bash

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null
SDK_VERSION=10.11
DARWIN="${OSXCROSS}/target"
DARWIN_SDK="${DARWIN}/SDK/MacOSX${SDK_VERSION}.sdk"

export PATH="${DARWIN}/bin:${DARWIN_SDK}/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/lib -mmacosx-version-min=10.10"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_HOST_SYSTEM="${TARGET}" -DCMAKE_INSTALL_PREFIX:PATH="${DARWIN_SDK}" -D BuildType=Release -D LibraryType=static
make -j$(nproc)
make install
cp lib${LIBRARY_NAME}.a lib${LIBRARY_NAME}.a.debug
${TARGET}-strip -x lib${LIBRARY_NAME}.a
${TARGET}-ranlib lib${LIBRARY_NAME}.a
mkdir -p ../.go-sdl2-libs
cp lib${LIBRARY_NAME}.a ../.go-sdl2-libs/lib${LIBRARY_NAME}_${ARCH}.a

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
../configure --host=${TARGET} --prefix="${DARWIN_SDK}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
${TARGET}-strip -x ${LIBDIR}/lib${NAME}.a
${TARGET}-ranlib ${LIBDIR}/lib${NAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_${ARCH}.a

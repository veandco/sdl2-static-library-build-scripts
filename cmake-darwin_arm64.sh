#!/usr/bin/env bash

ARCH=darwin_arm64

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null
SDK_VERSION=11.3
OSXCROSS=/opt/osxcross
DARWIN="${OSXCROSS}/target"
DARWIN_SDK="${DARWIN}/SDK/MacOSX${SDK_VERSION}.sdk"

export PATH="${DARWIN}/bin:${DARWIN_SDK}/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/lib -mmacosx-version-min=10.10"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
export LD="${TARGET}-ld"
export AR="${TARGET}-ar"
export RANLIB="${TARGET}-ranlib"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_HOST_SYSTEM="${TARGET}" -DCMAKE_INSTALL_PREFIX:PATH="${DARWIN_SDK}" -D BuildType=Release -D LibraryType=static -D ENABLE_SHARED=OFF -D CMAKE_C_COMPILER=$CC -D CMAKE_CXX_COMPILER=$CXX -D CMAKE_LD=`which $LD` -D CMAKE_AR=`which $AR` -D CMAKE_RANLIB=`which $RANLIB`
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${TARGET}-strip -x ${LIBDIR}/${LIBNAME}.a
${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..

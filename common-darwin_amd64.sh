#!/usr/bin/env bash

ARCH=darwin_amd64

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null
SDK_VERSION=10.14
WORK_DIR="$GITHUB_WORKSPACE"
if [ -z $GITHUB_WORKSPACE ]; then
	WORK_DIR="$PWD"
fi
OSXCROSS="$WORK_DIR/osxcross"
DARWIN="${OSXCROSS}/target"
DARWIN_SDK="${DARWIN}/SDK/MacOSX${SDK_VERSION}.sdk"
echo ${DARWIN_SDK}

export PATH="${DARWIN}/bin:${DARWIN_SDK}/bin:${PATH}"
export LDFLAGS="-L${DARWIN_SDK}/usr/lib -mmacosx-version-min=10.10"
export CC="${TARGET}-clang"
export CXX="${TARGET}-clang++"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host="${TARGET}" --prefix="${DARWIN_SDK}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${TARGET}-strip -x ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..

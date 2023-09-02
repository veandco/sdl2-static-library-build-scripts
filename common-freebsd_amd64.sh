#!/usr/bin/env bash

ARCH=freebsd_amd64

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
strip --strip-unneeded ${LIBDIR}/${LIBNAME}.a
#ranlib ${LIBDIR}/${LIBNAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..

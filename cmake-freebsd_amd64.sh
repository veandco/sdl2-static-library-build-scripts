#!/usr/bin/env bash

ARCH=freebsd_amd64

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBNAME}.a ${LIBNAME}.a.debug
strip --strip-unneeded ${LIBNAME}.a
#ranlib ${LIBNAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..

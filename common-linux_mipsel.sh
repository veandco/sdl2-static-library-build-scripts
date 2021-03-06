#!/usr/bin/env bash

ARCH=linux_mipsel

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="mipsel-linux-gnu-gcc"
export CXX="mipsel-linux-gnu-g++"
export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host="${TARGET}" --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
#${TARGET}-strip ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..

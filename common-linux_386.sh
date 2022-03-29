#!/usr/bin/env bash

ARCH=linux_386

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:${PATH}"
export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
#strip ${LIBDIR}/${LIBNAME}.a
#ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..
